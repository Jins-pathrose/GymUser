import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/Checkin%20Page/checkinprovider.dart';
import 'package:gym_user/PROVIDERS/Login%20Page/authentication.dart';
import 'package:gym_user/ROUTES/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CheckinProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesClass.login,
      routes: RoutesClass.routes,
    );
  }
}