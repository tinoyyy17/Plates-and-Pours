import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // PH mobile numbers: 09XXXXXXXXX (11 digits) or +639XXXXXXXXX.
  static final _phRegex = RegExp(r'^(09\d{9}|\+639\d{9})$');

  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isRegisterMode = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateRegisterFields() {
    if (_usernameController.text.trim().isEmpty) {
      return 'Please enter a username.';
    }
    final phone = _phoneController.text.trim();
    if (!_phRegex.hasMatch(phone)) {
      return 'Enter a valid PH mobile number, e.g. 09171234567 or +639171234567.';
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Passwords don\u2019t match.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_isRegisterMode) {
      final validationError = _validateRegisterFields();
      if (validationError != null) {
        setState(() => _errorMessage = validationError);
        return;
      }
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      if (_isRegisterMode) {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        final username = _usernameController.text.trim();
        await credential.user?.updateDisplayName(username);

        await FirebaseFirestore.instance
            .collection('customers')
            .doc(credential.user!.uid)
            .set({
          'username': username,
          'phone': _phoneController.text.trim(),
          'email': _emailController.text.trim(),
          'loyalty_points': 0,
          'created_at': FieldValue.serverTimestamp(),
        });
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(); // back to WelcomePage, which routes to the menu
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _friendlyError(e.code));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _friendlyError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'That email already has an account — try logging in instead.';
      case 'invalid-email':
        return 'That doesn\u2019t look like a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      default:
        return 'Something went wrong ($code). Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.forest,
        elevation: 0,
        title: Text(_isRegisterMode ? 'Create account' : 'Log in', style: text.titleMedium),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _ModeTab(label: 'Log in', selected: !_isRegisterMode, onTap: () => setState(() { _isRegisterMode = false; _errorMessage = null; }))),
                      Expanded(child: _ModeTab(label: 'Sign up', selected: _isRegisterMode, onTap: () => setState(() { _isRegisterMode = true; _errorMessage = null; }))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_isRegisterMode) ...[
                  TextField(
                    controller: _usernameController,
                    style: text.bodyMedium,
                    decoration: _fieldDecoration('Username'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: text.bodyMedium,
                    decoration: _fieldDecoration('Phone number').copyWith(
                      hintText: '09171234567',
                      hintStyle: TextStyle(color: AppColors.forestMuted),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: text.bodyMedium,
                  decoration: _fieldDecoration('Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: text.bodyMedium,
                  decoration: _fieldDecoration('Password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.forestMuted,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                if (_isRegisterMode) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: text.bodyMedium,
                    decoration: _fieldDecoration('Confirm password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.forestMuted,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                  ),
                ],
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(_errorMessage!, style: text.bodySmall?.copyWith(color: Colors.red.shade700)),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.forest),
                  )
                      : Text(_isRegisterMode ? 'Create account' : 'Log in', style: text.labelLarge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.forestMuted),
      filled: true,
      fillColor: AppColors.cardBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.forest : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: text.bodyMedium?.copyWith(
            color: selected ? Colors.white : AppColors.forest,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
