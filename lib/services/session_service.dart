import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionOutcome {
  final String? sessionId;
  final bool expired;
  SessionOutcome.active(this.sessionId) : expired = false;
  SessionOutcome.expired()
      : sessionId = null,
        expired = true;
}

class SessionService {
  final _db = FirebaseFirestore.instance;
  static const _sessionDuration = Duration(hours: 24);

  String _prefsKey(String tableId) => 'session_$tableId';

  String _newSessionId() {
    final rand = Random();
    return '${DateTime.now().microsecondsSinceEpoch}-${rand.nextInt(999999)}';
  }

  /// Called once when the app loads. Decides whether this browser gets
  /// into the menu, or sees "Your QR has expired".
  ///
  /// Design note: a browser reopening an old tab/link and a genuine fresh
  /// QR scan both hit the identical URL — the web has no way to tell them
  /// apart directly. So this is self-healing instead: the first load after
  /// a session goes stale shows the expired screen AND clears this
  /// browser's local memory of it. The very next load of that same link
  /// (whether from a real re-scan or just tapping it again) then finds no
  /// local session and starts a brand-new one automatically.
  Future<SessionOutcome> resolveSession(String tableId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _prefsKey(tableId);
    final localId = prefs.getString(key);
    final docRef = _db.collection('table_sessions').doc(tableId);

    if (localId == null) {
      // No memory of ever visiting this table on this browser — always
      // treated as a fresh scan, and takes over the table's session.
      final newId = _newSessionId();
      await docRef.set({
        'session_id': newId,
        'started_at': FieldValue.serverTimestamp(),
      });
      await prefs.setString(key, newId);
      return SessionOutcome.active(newId);
    }

    final snap = await docRef.get();
    if (!snap.exists) {
      await prefs.remove(key);
      return SessionOutcome.expired();
    }

    final data = snap.data()!;
    final remoteId = data['session_id'] as String?;
    final startedAt = (data['started_at'] as Timestamp?)?.toDate();
    final withinWindow = startedAt != null && DateTime.now().difference(startedAt) < _sessionDuration;

    if (remoteId != localId || !withinWindow) {
      await prefs.remove(key);
      return SessionOutcome.expired();
    }

    if (await _isFullyPaidOff(tableId, localId)) {
      await prefs.remove(key);
      return SessionOutcome.expired();
    }

    return SessionOutcome.active(localId);
  }

  /// This browser's already-resolved session id for [tableId], if any —
  /// cheap local read, used by pages reached after resolveSession already ran.
  Future<String?> getLocalSessionId(String tableId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsKey(tableId));
  }

  /// True once every order placed under this session is paid — meaning the
  /// whole visit is settled and it's time to require a fresh scan.
  Future<bool> _isFullyPaidOff(String tableId, String sessionId) async {
    final snap = await _db.collection('orders').where('table_id', isEqualTo: tableId).get();
    final sessionOrders = snap.docs.where((d) => d.data()['session_id'] == sessionId).toList();
    if (sessionOrders.isEmpty) return false; // haven't ordered yet — not expired
    return sessionOrders.every((d) => d.data()['status'] == 'paid');
  }
}
