// checkin_provider.dart

import 'package:flutter/material.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';

class CheckinProvider with ChangeNotifier {
  bool _isCheckedIn = false;

  String _checkInTime = '--:--';
  String _checkOutTime = '--:--';
  String _totalHours = '--:--';

  Map<String, dynamic>? _memberData;

  /// Getters
  bool get isCheckedIn => _isCheckedIn;

  String get checkInTime => _checkInTime;

  String get checkOutTime => _checkOutTime;

  String get totalHours => _totalHours;

  Map<String, dynamic>? get memberData =>
      _memberData;

  /// User Name
  String get userName {
    if (_memberData == null) {
      return 'User';
    }

    final firstName =
        _memberData?['first_name'] ?? '';

    final lastName =
        _memberData?['last_name'] ?? '';

    return '$firstName $lastName';
  }

  /// Gym Name
  String get gymName {
    if (_memberData == null) {
      return 'Gym';
    }

    return _memberData?['gym_name'] ??
        'Gym';
  }

  /// Load User Data
  Future<void> loadUserData() async {
    _memberData =
        await SharedPrefService
            .getMemberData();

    notifyListeners();
  }

  /// Current Time
  String _formattedNow() {
    final now = DateTime.now();

    final h = now.hour
        .toString()
        .padLeft(2, '0');

    final m = now.minute
        .toString()
        .padLeft(2, '0');

    return '$h:$m';
  }

  /// Calculate Duration
  String _calcDuration(
    String from,
    String to,
  ) {
    try {
      final fParts = from.split(':');

      final tParts = to.split(':');

      final fMins =
          int.parse(fParts[0]) * 60 +
              int.parse(fParts[1]);

      final tMins =
          int.parse(tParts[0]) * 60 +
              int.parse(tParts[1]);

      final diff = tMins - fMins;

      if (diff < 0) {
        return '--:--';
      }

      final h = (diff ~/ 60)
          .toString()
          .padLeft(2, '0');

      final m = (diff % 60)
          .toString()
          .padLeft(2, '0');

      return '$h:$m';
    } catch (_) {
      return '--:--';
    }
  }

  /// Check In / Out
  void updateAttendance() {
    if (!_isCheckedIn) {
      _isCheckedIn = true;

      _checkInTime = _formattedNow();

      _checkOutTime = '--:--';

      _totalHours = '--:--';
    } else {
      _isCheckedIn = false;

      _checkOutTime = _formattedNow();

      _totalHours = _calcDuration(
        _checkInTime,
        _checkOutTime,
      );
    }

    notifyListeners();
  }

  /// Logout
  Future<void> logout() async {
    await SharedPrefService.clearData();

    _memberData = null;

    _isCheckedIn = false;

    _checkInTime = '--:--';

    _checkOutTime = '--:--';

    _totalHours = '--:--';

    notifyListeners();
  }
}