import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/session_service.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';
import 'table_order_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final String _tableId;
  String? _sessionId;
  bool _checking = true;
  bool _expired = false;

  @override
  void initState() {
    super.initState();
    _tableId = Uri.base.queryParameters['table'] ?? 'unknown';
    _resolveSession();
  }

  /// Session validity is checked before anything else — an expired QR
  /// means there's no point even offering the guest/login choice.
  Future<void> _resolveSession() async {
    final outcome = await SessionService().resolveSession(_tableId);
    if (!mounted) return;

    if (outcome.expired) {
      setState(() {
        _expired = true;
        _checking = false;
      });
      return;
    }

    _sessionId = outcome.sessionId;
    _checkExistingLogin();
  }

  /// If this browser already has a signed-in session (guest or logged in
  /// customer) from earlier in the visit, skip straight to the menu instead
  /// of asking them to choose again on every scan.
  void _checkExistingLogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goToMenu());
      return;
    }
    setState(() => _checking = false);
  }

  void _goToMenu() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TableOrderPage(tableId: _tableId, sessionId: _sessionId!),
      ),
    );
  }

  Future<void> _continueAsGuest() async {
    await FirebaseAuth.instance.signInAnonymously();
    if (!mounted) return;
    _goToMenu();
  }

  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ).then((_) {
      // Come back here after login/register succeeds and re-check.
      if (FirebaseAuth.instance.currentUser != null) _goToMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    if (_checking) {
      return const Scaffold(
        backgroundColor: AppColors.pageBg,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_expired) {
      return Scaffold(
        backgroundColor: AppColors.pageBg,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/logo.jpg', width: 88, height: 88, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.qr_code_2, size: 40, color: AppColors.forestMuted),
                    const SizedBox(height: 12),
                    Text('Your QR has expired', style: text.displaySmall, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(
                      'This table\u2019s session has ended. Please scan the QR code on your table again to start a new order.',
                      style: text.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/logo.jpg', width: 96, height: 96, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),
                  Text('Plates & Pours', style: text.displaySmall, textAlign: TextAlign.center),
                  const SizedBox(height: 4),
                  Text('Garden Resto & Café', style: text.bodySmall, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Table $_tableId',
                      style: text.bodySmall?.copyWith(color: AppColors.forest, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Log in to earn loyalty points on this order, or continue as a guest.',
                    style: text.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: Text('Log in or sign up', style: text.labelLarge),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _continueAsGuest,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.forest,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('Continue as guest', style: text.bodyLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
