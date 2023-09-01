import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toknote/core/common/app/providers/user_provider.dart';
import 'package:toknote/core/common/widgets/custom_painter/login_custom_pointer.dart';
import 'package:toknote/core/common/widgets/rounded_button.dart';
import 'package:toknote/core/res/fonts.dart';
import 'package:toknote/core/utils/core_utils.dart';
import 'package:toknote/src/auth/data/models/user_model.dart';
import 'package:toknote/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:toknote/src/auth/presentation/views/sign_up_screen.dart';
import 'package:toknote/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:toknote/src/dashboard/presentation/views/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                    // shrinkWrap: true,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: Fonts.aeonik,
                            fontWeight: FontWeight.w700,
                            fontSize: 60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please Sign in to your account',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SignInForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        formKey: _formKey,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/forgot-password',
                            );
                          },
                          child: const Text('Forgot password?'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (state is AuthLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        RoundedButton(
                          label: 'Sign In',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            FirebaseAuth.instance.currentUser?.reload();
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    SignInEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
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
                            "Don't have and account?",
                            style: TextStyle(fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUpScreen.routeName,
                              );
                            },
                            child: const Text('Sign Up!'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CustomPaint(
                  size: Size(size.width, 300 * 0.3125),
                  painter: LoginBottomCustomPainter(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
