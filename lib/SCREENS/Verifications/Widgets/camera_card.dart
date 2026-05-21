import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gym_user/PROVIDERS/VERIFICATION%20PAGE/verification_provider.dart';
import 'package:gym_user/PROVIDERS/VERIFICATION PAGE/verification_provider.dart';

class CameraCard extends StatelessWidget {
  final CameraController? controller;
  final bool isInitialized;
  final VerificationStatus status;
  final double cameraHeight;

  const CameraCard({
    super.key,
    required this.controller,
    required this.isInitialized,
    required this.status,
    required this.cameraHeight,
  });

  Color get _borderColor {
    switch (status) {
      case VerificationStatus.success:
        return Colors.green;
      case VerificationStatus.failed:
        return Colors.red;
      case VerificationStatus.scanning:
        return Colors.white24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 292,
        height: 406,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _borderColor,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: isInitialized && controller != null
              ? CameraPreview(controller!)
              : Container(
                  color: const Color(0xFF2A2A2A),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white38,
                      strokeWidth: 2,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}