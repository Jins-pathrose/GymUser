import 'package:flutter/material.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';
import 'Widgets/header.dart';
import 'Widgets/live_clock_widget.dart';
import 'Widgets/check_in_button.dart';
import 'Widgets/location_badge.dart';
import 'Widgets/attendance_stats_row.dart';

class CheckinoutScreen extends StatefulWidget {
  const CheckinoutScreen({super.key});

  @override
  State<CheckinoutScreen> createState() => _CheckinoutScreenState();
}

class _CheckinoutScreenState extends State<CheckinoutScreen> {
  bool _isCheckedIn = false;
  String _checkInTime = '--:--';
  String _totalHours = '--:--';
  String _checkOutTime = '--:--';

  String _formattedNow() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _calcDuration(String from, String to) {
    try {
      final fParts = from.split(':');
      final tParts = to.split(':');
      final fMins = int.parse(fParts[0]) * 60 + int.parse(fParts[1]);
      final tMins = int.parse(tParts[0]) * 60 + int.parse(tParts[1]);
      final diff = tMins - fMins;
      if (diff < 0) return '--:--';
      final h = (diff ~/ 60).toString().padLeft(2, '0');
      final m = (diff % 60).toString().padLeft(2, '0');
      return '$h:$m';
    } catch (_) {
      return '--:--';
    }
  }

  Future<void> _handleCheckInOut() async {
    final result = await Navigator.push<bool>(
      context,
      PageRouteBuilder<bool>(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, _, _) => VerificationScreen(
          userName: 'Hariharan S',
          userAvatar: '',
          isCheckIn: !_isCheckedIn,
        ),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );

    if (result == true && mounted) {
      setState(() {
        if (!_isCheckedIn) {
          _isCheckedIn = true;
          _checkInTime = _formattedNow();
          _checkOutTime = '--:--';
          _totalHours = '--:--';
        } else {
          _isCheckedIn = false;
          _checkOutTime = _formattedNow();
          _totalHours = _calcDuration(_checkInTime, _checkOutTime);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeHeader(userName: 'Hariharan S'),

              const SizedBox(height: 40),

              const LiveClockWidget(),

              const SizedBox(height: 50),

              CheckInButton(
                isCheckedIn: _isCheckedIn,
                onTap: _handleCheckInOut,
              ),

              const SizedBox(height: 30),

              const LocationBadge(
                locationName: 'Techfifo Innovations, Palakkad',
              ),

              const SizedBox(height: 44),

              AttendanceStatsRow(
                checkInTime: _checkInTime,
                totalHours: _totalHours,
                checkOutTime: _checkOutTime,
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}