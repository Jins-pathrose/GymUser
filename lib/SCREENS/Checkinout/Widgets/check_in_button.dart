import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class CheckInButton extends StatelessWidget {
  final bool isCheckedIn;
  final VoidCallback onTap;

  const CheckInButton({
    super.key,
    required this.isCheckedIn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Layer 1: Outer grey circle ──
          Container(
            width: 230,
            height: 230,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFCECECE),
            ),
          ),

          // ── Layer 2: White gap ──
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
          ),

          // ── Layer 3: Green / Red button ──
          Container(
            width: 198,
            height: 198,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isCheckedIn
                    ? [const Color(0xFFFF6A00), const Color(0xFFFF6A00)]
                    : [const Color(0xFF56C568), const Color(0xFF1E7E34)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (isCheckedIn
                              ? const Color(0xFFEF5350)
                              : const Color(0xFF43A047))
                          .withOpacity(0.45),
                  blurRadius: 22,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/Vector (3).svg',
                  width: 44,
                  height: 44,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),

                const SizedBox(height: 6),
                Text(
                  isCheckedIn ? 'Check Out' : 'Check In',
                  style: AppStyle.text(size: 18, weight: FontWeight.w700, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
