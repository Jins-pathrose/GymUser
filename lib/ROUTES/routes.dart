import 'package:flutter/material.dart';
import 'package:gym_user/SCREENS/Login/login_screen.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';

class RoutesClass {
  static const String login = '/';
  static const String verification = '/verification';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),

    verification: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

      return VerificationScreen(
        userName: args?['userName'] as String? ?? '',
        userAvatar: args?['userAvatar'] as String? ?? '',
        isCheckIn: args?['isCheckIn'] as bool? ?? true,
      );
    },
  };
}