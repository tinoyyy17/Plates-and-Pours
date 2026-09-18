import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';
import 'welcome_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    // Clear the nav stack so "back" can't return to a signed-out session's menu.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomePage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final isGuest = user == null || user.isAnonymous;

        return Scaffold(
          backgroundColor: AppColors.pageBg,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.forest,
            elevation: 0,
            title: Text('Profile', style: text.titleMedium),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: isGuest
                    ? _GuestView(text: text)
                    : _AccountView(uid: user.uid, text: text, onLogout: () => _logout(context)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GuestView extends StatelessWidget {
  final TextTheme text;
  const _GuestView({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.person_outline, size: 48, color: AppColors.forestMuted),
        const SizedBox(height: 12),
        Text('You\u2019re browsing as a guest', style: text.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(
          'Log in to start earning loyalty points on your orders.',
          style: text.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const LoginPage())),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: Text('Log in or sign up', style: text.labelLarge),
          ),
        ),
      ],
    );
  }
}

class _AccountView extends StatefulWidget {
  final String uid;
  final TextTheme text;
  final VoidCallback onLogout;

  const _AccountView({required this.uid, required this.text, required this.onLogout});

  @override
  State<_AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<_AccountView> {
  bool _sendingVerification = false;
  bool _justSentVerification = false;

  Future<void> _resendVerification() async {
    setState(() => _sendingVerification = true);
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      if (!mounted) return;
      setState(() => _justSentVerification = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email sent.')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Couldn\u2019t send email right now (${e.code}). Try again shortly.')),
      );
    } finally {
      if (mounted) setState(() => _sendingVerification = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('customers').doc(widget.uid).snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();
        final username = (data?['username'] ?? FirebaseAuth.instance.currentUser?.displayName ?? 'Customer').toString();
        final email = (data?['email'] ?? FirebaseAuth.instance.currentUser?.email ?? '').toString();
        final phone = (data?['phone'] ?? '').toString();
        final points = data?['loyalty_points'] ?? 0;
        final emailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.forest,
              child: Text(
                username.isNotEmpty ? username[0].toUpperCase() : '?',
                style: text.displaySmall?.copyWith(color: Colors.white, fontSize: 22),
              ),
            ),
            const SizedBox(height: 12),
            Text(username, style: text.titleMedium),
            if (email.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(email, style: text.bodySmall),
            ],
            if (phone.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(phone, style: text.bodySmall),
            ],
            if (!emailVerified) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mark_email_unread_outlined, color: Colors.orange.shade800, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Please verify your email',
                            style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _justSentVerification
                          ? 'Verification email sent \u2014 check your inbox, then reload this page.'
                          : 'We sent a link to $email when you signed up. Didn\u2019t get it?',
                      style: text.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: _sendingVerification ? null : _resendVerification,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.orange.shade900,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: _sendingVerification
                            ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Text('Resend verification email'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.gold),
              ),
              child: Column(
                children: [
                  Text('Loyalty points', style: text.bodySmall),
                  const SizedBox(height: 4),
                  Text('$points', style: text.displaySmall),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: widget.onLogout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.forest,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Log out', style: text.bodyLarge),
              ),
            ),
          ],
        );
      },
    );
  }
}