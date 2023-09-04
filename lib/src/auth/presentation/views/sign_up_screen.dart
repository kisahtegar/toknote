import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toknote/core/common/widgets/custom_painter/login_custom_pointer.dart';
import 'package:toknote/core/common/widgets/rounded_button.dart';
import 'package:toknote/core/res/fonts.dart';
import 'package:toknote/core/utils/core_utils.dart';
import 'package:toknote/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:toknote/src/auth/presentation/views/sign_in_screen.dart';
import 'package:toknote/src/auth/presentation/widgets/sign_up_form.dart';

/// A screen for user sign-up.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  /// The route name for this screen.
  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            CoreUtils.showSnackBar(
              context,
              'An email has been sent to your registered email. To activate it '
              'please check your email box',
            );
            Navigator.pushReplacementNamed(
              context,
              SignInScreen.routeName,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomPaint(
                    size: Size(size.width, 300 * 0.3125),
                    painter: LoginTopCustomPainter(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: Fonts.aeonik,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please Sign Up to your account',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SignUpForm(
                          emailController: _emailController,
                          fullNameController: _fullNameController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          formKey: _formKey,
                        ),
                        const SizedBox(height: 30),
                        if (state is AuthLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          RoundedButton(
                            label: 'Sign Up',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              FirebaseAuth.instance.currentUser?.reload();
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpEvent(
                                        email: _emailController.text.trim(),
                                        name: _fullNameController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                          ),
                        const SizedBox(height: 90),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have a account?',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  SignInScreen.routeName,
                                );
                              },
                              child: const Text('Sign In!'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
