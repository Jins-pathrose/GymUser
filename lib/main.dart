import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/LOGIN%20PAGE/authentication.dart';
import 'package:gym_user/SCREENS/Checkinout/checkinout.dart';
import 'package:gym_user/SCREENS/Login/login_screen.dart';
// import 'package:gym_user/SCREENS/Checkinout/checkinout.dart';
// import 'package:gym_user/SCREENS/Login/login%20_screen.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => CheckinoutProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B00)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // home: const VerificationScreen(
      //       // ✅
      //       userName: '',
      //       userAvatar:  '',
      //       isCheckIn: true,
      //     ),
      home: CheckinoutScreen(),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginScreen(),
        // '/checkinout': (context) => const CheckinoutScreen(),
        '/verification': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return VerificationScreen(
            // ✅
            userName: args?['userName'] as String? ?? '',
            userAvatar: args?['userAvatar'] as String? ?? '',
            isCheckIn: args?['isCheckIn'] as bool? ?? true,
          );
        },
      },
    );
  }
}
