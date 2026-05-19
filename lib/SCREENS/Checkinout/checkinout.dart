import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/Checkin%20Page/checkinprovider.dart';
import 'package:provider/provider.dart';

import 'package:gym_user/SCREENS/Login/login_screen.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';

import 'Widgets/header.dart';
import 'Widgets/live_clock_widget.dart';
import 'Widgets/check_in_button.dart';
import 'Widgets/location_badge.dart';
import 'Widgets/attendance_stats_row.dart';

class CheckinoutScreen extends StatefulWidget {
  const CheckinoutScreen({super.key});

  @override
  State<CheckinoutScreen> createState() =>
      _CheckinoutScreenState();
}

class _CheckinoutScreenState
    extends State<CheckinoutScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CheckinProvider>().loadUserData();
    });
  }

  Future<void> _handleCheckInOut() async {
    final provider =
        context.read<CheckinProvider>();

    final result = await Navigator.push<bool>(
      context,
      PageRouteBuilder<bool>(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, _, __) =>
            VerificationScreen(
          userName: provider.userName,
          userAvatar: '',
          isCheckIn: !provider.isCheckedIn,
        ),
        transitionsBuilder:
            (context, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );

    if (result == true && mounted) {
      provider.updateAttendance();
    }
  }

  Future<void> _handleLogout() async {
    await context.read<CheckinProvider>().logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckinProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0F0F0),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 35,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  HomeHeader(
                    userName: provider.userName,
                    onLogout: _handleLogout,
                  ),

                  const SizedBox(height: 40),

                  const LiveClockWidget(),

                  const SizedBox(height: 50),

                  CheckInButton(
                    isCheckedIn:
                        provider.isCheckedIn,
                    onTap: _handleCheckInOut,
                  ),

                  const SizedBox(height: 30),

                  const LocationBadge(
                    locationName:
                        'Techfifo Innovations, Palakkad',
                  ),

                  const SizedBox(height: 44),

                  AttendanceStatsRow(
                    checkInTime:
                        provider.checkInTime,
                    totalHours:
                        provider.totalHours,
                    checkOutTime:
                        provider.checkOutTime,
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}