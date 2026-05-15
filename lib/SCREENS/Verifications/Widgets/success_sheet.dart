import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class SuccessSheet extends StatelessWidget {
  final VoidCallback onContinue;

  const SuccessSheet({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Success icon + text ──
        Text(
          'Success 🎉',
          style: AppStyle.text(
            size: 22,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "You're checked in.",
          style: AppStyle.text(
            size: 14,
            weight: FontWeight.w400,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 20),

        // ── Continue button ──
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
            onPressed: onContinue,
            child: Text(
              'Continue',
              style: AppStyle.text(
                size: 17,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}