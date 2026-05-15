import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class FailedSheet extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback onBack;

  const FailedSheet({
    super.key,
    required this.onTryAgain,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Check-in Failed ❌',
          style: AppStyle.text(
            size: 20,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'You are outside the authorized area',
          style: AppStyle.text(
            size: 13,
            weight: FontWeight.w400,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 20),

        // ── Try Again ──
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            onPressed: onTryAgain,
            child: Text(
              'Try Again',
              style: AppStyle.text(
                size: 17,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ── Back ──
        SizedBox(
          width: double.infinity,
          height: 46,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
            onPressed: onBack,
            child: Text(
              'Back',
              style: AppStyle.text(
                size: 15,
                weight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}