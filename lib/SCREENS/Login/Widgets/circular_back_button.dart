import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class CircularBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CircularBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.maybePop(context),
      child: Container(
        width: 42,
        height: 42,
        decoration:  BoxDecoration(
          color: AppStyle.primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white , 
          size: 30 ,
        ),
      ),
    );
  }
}