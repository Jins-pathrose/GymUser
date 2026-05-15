import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/LOGIN%20PAGE/authentication.dart';
import 'package:gym_user/SCREENS/Checkinout/checkinout.dart';
import 'package:gym_user/SCREENS/Login/login%20_screen.dart';
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // home: const LoginScreen(),
       initialRoute: '/checkinout',
      routes: {
        // '/login': (context) => const LoginScreen(),
        '/checkinout': (context) => const CheckinoutScreen(),
      },
    );
  }
}                                                                                       