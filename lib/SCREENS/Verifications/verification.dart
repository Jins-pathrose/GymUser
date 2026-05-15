import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gym_user/SCREENS/Verifications/Widgets/camera_card.dart';
import 'package:gym_user/SCREENS/Verifications/Widgets/location_row.dart';
import 'package:gym_user/SCREENS/Verifications/Widgets/verification_header.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';
import 'widgets/success_sheet.dart';
import 'widgets/failed_sheet.dart';
import 'widgets/stats_row.dart';

enum VerificationStatus { scanning, success, failed }

class VerificationScreen extends StatefulWidget {
  final String userName;
  final String userAvatar;
  final bool isCheckIn;

  const VerificationScreen({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.isCheckIn,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  VerificationStatus _status = VerificationStatus.scanning;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
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
    if (mounted) setState(() => _isCameraInitialized = true);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _setStatus(VerificationStatus status) =>
      setState(() => _status = status);

  void _onContinue() => Navigator.pop(context, true);
  void _onTryAgain() => setState(() => _status = VerificationStatus.scanning);
  void _onBack() => Navigator.pop(context, false);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // ── Fully transparent so the page behind shows through ──
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // ── Camera Card ──
              CameraCard(
                controller: _cameraController,
                isInitialized: _isCameraInitialized,
                status: _status,
                cameraHeight: screenHeight * 0.48,
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 20),

              SuccessSheet(onContinue: _onContinue),

              const SizedBox(height: 24),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanningState() {
    return Column(
      children: [
        Center(
          child: Text(
            'Scanning face...',
            style: AppStyle.text(
              size: 14,
              weight: FontWeight.w400,
              color: Colors.white54,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // ── DEV buttons — replace with your real API call ──
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _setStatus(VerificationStatus.success),
                child: const Text(
                  'Simulate Success',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _setStatus(VerificationStatus.failed),
                child: const Text(
                  'Simulate Fail',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}