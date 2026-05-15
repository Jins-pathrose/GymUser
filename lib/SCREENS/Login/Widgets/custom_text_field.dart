import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          // style: GoogleFonts.manrope(
          //   fontSize: 14,
          //   fontWeight: FontWeight.w500,
          //   color: const Color(0xFF6B7280),
          // ),
          style: AppStyle.text(size: 14, weight: FontWeight.w500, color: const Color(0xFF6B7280)),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            // style: GoogleFonts.manrope(
            //   fontSize: 14,
            //   fontWeight: FontWeight.w400,
            //   color: const Color(0xFF111827),
            // ), 
            style: AppStyle.text(size: 14, weight: FontWeight.w400, color: const Color(0xFF111827)),
            decoration: InputDecoration(
              hintText: hintText,

              // hintStyle: GoogleFonts.manrope(
              //   fontSize: 14,
              //   fontWeight: FontWeight.w400,
              //   color: const Color(0xFF9CA3AF),
              // ),
              hintStyle: AppStyle.text(size: 14, weight: FontWeight.w400, color: const Color(0xFF9CA3AF)),

              prefixIcon: Icon(
                prefixIcon,
                color: AppStyle.primaryColor,
                size: 20,
              ),

              filled: true,
              fillColor: const Color(0xFFFFFFFF),

              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppStyle.primaryColor,
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppStyle.primaryColor,
                  width: 1.2,
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppStyle.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}