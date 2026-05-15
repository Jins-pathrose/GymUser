import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.label = "Log in ",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyle.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,

          padding: EdgeInsets.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: Text(
          label,
          style: AppStyle.text(size: 18, weight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}