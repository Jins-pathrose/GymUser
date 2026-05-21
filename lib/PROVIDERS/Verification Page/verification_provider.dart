import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum VerificationStatus { scanning, success, failed }

class VerificationProvider with ChangeNotifier {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  VerificationStatus _status = VerificationStatus.scanning;
  bool _isProcessing = false;
  String? _errorMessage;

  CameraController? get cameraController => _cameraController;
  bool get isCameraInitialized => _isCameraInitialized;
  VerificationStatus get status => _status;
  bool get isProcessing => _isProcessing;
  String? get errorMessage => _errorMessage;

  /// Initialize Camera
  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCam = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCam,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Camera Error: $e');
    }
  }

  /// Get Device Location
  Future<Position?> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint('Location Error: $e');
      return null;
    }
  }

  /// Capture Face + Call Check-In API
  Future<void> performCheckIn() async {
    if (_isProcessing) return;

    _isProcessing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. Capture face image
      if (_cameraController == null || !_isCameraInitialized) {
        throw Exception('Camera not ready');
      }

      final XFile imageFile = await _cameraController!.takePicture();

      // 2. Get location
      final position = await _getLocation();
      final latitude  = position?.latitude.toString()  ?? '10.523698';
      final longitude = position?.longitude.toString() ?? '76.258789';

print("$latitude $longitude");
print("suiiiiiii");
      // 3. Get auth token
      final token = await SharedPrefService.getAccessToken();

      // 4. Build multipart request
      final uri = Uri.parse(
        'https://gymsoftware.archanastones.in/api/user/checkin/',
      );

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['latitude']  = latitude
        ..fields['longitude'] = longitude
        ..files.add(
          await http.MultipartFile.fromPath(
            'face_image',
            imageFile.path,
          ),
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('CheckIn Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _status = VerificationStatus.success;
        } else {
          _errorMessage = data['message'] ?? 'Check-in failed.';
          _status = VerificationStatus.failed;
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
        _status = VerificationStatus.failed;
      }
    } catch (e) {
      debugPrint('CheckIn Error: $e');
      _errorMessage = 'Something went wrong. Please try again.';
      _status = VerificationStatus.failed;
    }

    _isProcessing = false;
    notifyListeners();
  }

  void setStatus(VerificationStatus status) {
    _status = status;
    notifyListeners();
  }

  void resetVerification() {
    _status = VerificationStatus.scanning;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> disposeCamera() async {
    await _cameraController?.dispose();
  }
}