import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/Login%20Page/authentication.dart';
import 'package:gym_user/SCREENS/Login/Widgets/circular_back_button.dart';
import 'package:gym_user/SCREENS/Login/Widgets/continue_button.dart';
import 'package:gym_user/SCREENS/Login/Widgets/custom_text_field.dart';
import 'package:gym_user/SCREENS/Login/Widgets/footer_links.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';
import 'package:provider/provider.dart';

import '../Checkinout/checkinout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  /// Form Key
  final _formKey =
      GlobalKey<FormState>();

  /// Controllers
  final TextEditingController
  emailController =
      TextEditingController();

  final TextEditingController
  passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 150),

                /// Back Button
                CircularBackButton(
                  onPressed: () =>
                      Navigator.maybePop(
                    context,
                  ),
                ),

                const SizedBox(height: 15),

                /// Welcome Title
                Text(
                  'Welcome Back,',

                  style: AppStyle.text(
                    size: 30,
                    weight:
                        FontWeight.w800,
                    color:
                        AppStyle.primaryColor,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  'Login to your Account',

                  style: AppStyle.text(
                    size: 16,
                    weight:
                        FontWeight.w400,
                    color:
                        const Color(
                      0xFF888888,
                    ),
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 40),

                /// Email Field
                CustomTextField(
                  label: 'Email Id',

                  hintText:
                      'Enter your email',

                  prefixIcon:
                      Icons.mail_outline,

                  controller:
                      emailController,

                  keyboardType:
                      TextInputType
                          .emailAddress,

                  validator: (
                    value,
                  ) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter email';
                    }

                    final emailRegex =
                        RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex
                        .hasMatch(
                      value,
                    )) {
                      return 'Enter valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 10),

                /// Password Field
                CustomTextField(
                  label: 'Password',

                  hintText:
                      'Enter your password',

                  prefixIcon:
                      Icons.lock_outline,

                  controller:
                      passwordController,

                  obscureText: true,

                  validator: (
                    value,
                  ) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter password';
                    }

                    if (value.length <
                        6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// Login Button
                ContinueButton(
                  isLoading:
                      authProvider
                          .isLoading,

                  onPressed: () async {
                    /// Validate Form
                    if (!_formKey
                        .currentState!
                        .validate()) {
                      return;
                    }

                    /// Login API
                    bool success =
                        await authProvider
                            .login(
                      emailController
                          .text
                          .trim(),

                      passwordController
                          .text
                          .trim(),
                    );

                    /// Success
                    if (success) {
                      if (!mounted) {
                        return;
                      }

                      Navigator
                          .pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder:
                              (
                                context,
                              ) =>
                                  const CheckinoutScreen(),
                        ),
                      );
                    }

                    /// Failed
                    else {
                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            authProvider
                                    .errorMessage ??
                                'Login failed',
                          ),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 39),

                /// Footer Links
                FooterLinks(
                  onForgotPassword: () {
                    debugPrint(
                      'Contact Admin tapped',
                    );
                  },

                  onTermsOfService: () {
                    debugPrint(
                      'Terms of Service tapped',
                    );
                  },

                  onPrivacyPolicy: () {
                    debugPrint(
                      'Privacy Policy tapped',
                    );
                  },
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}