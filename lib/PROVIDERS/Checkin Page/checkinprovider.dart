import 'package:flutter/material.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinProvider with ChangeNotifier {
  bool _isCheckedIn = false;

  String _checkInTime = '--:--';

  Map<String, dynamic>? _memberData;

  /// Getters
  bool get isCheckedIn => _isCheckedIn;

  String get checkInTime => _checkInTime;

  Map<String, dynamic>? get memberData => _memberData;

  /// User Name
  String get userName {
    if (_memberData == null) {
      return 'User';
    }

    final firstName = _memberData?['first_name'] ?? '';

    final lastName = _memberData?['last_name'] ?? '';

    return '$firstName $lastName';
  }

  /// Gym Name
  String get gymName {
    if (_memberData == null) {
      return 'Gym';
    }

    return _memberData?['gym_name'] ?? 'Gym';
  }

  /// Load User Data
  Future<void> loadUserData() async {
    _memberData = await SharedPrefService.getMemberData();

    await loadCheckInTime();

    notifyListeners();
  }

  /// Load Check-In Time From SharedPreferences
  Future<void> loadCheckInTime() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTime = prefs.getString('check_in_time');

    if (savedTime != null && savedTime.isNotEmpty) {
      final dateTime = DateTime.parse(savedTime);

      _checkInTime = DateFormat('hh:mm a').format(dateTime);

      _isCheckedIn = true;
    } else {
      _checkInTime = '--:--';

      _isCheckedIn = false;
    }

    notifyListeners();
  }

  /// Update After Successful Check-In
  Future<void> refreshCheckIn() async {
    await loadCheckInTime();
  }

  /// Logout
  Future<void> logout() async {
    await SharedPrefService.clearData();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('check_in_time');

    _memberData = null;

    _isCheckedIn = false;

    _checkInTime = '--:--';

    notifyListeners();
  }
}