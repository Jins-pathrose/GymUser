import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class AttendanceStatItem extends StatelessWidget {
  final String svgPath;
  final String value;
  final String label;

  const AttendanceStatItem({
    super.key,
    required this.svgPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 34,
          height: 34,
          colorFilter: const ColorFilter.mode(
            Color(0xFFFF6B00),
            BlendMode.srcIn,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value,
          style:AppStyle.text(size: 18, weight: FontWeight.w700, color: Color(0xFF232323)),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: AppStyle.text(size: 12, color: Color(0xFF333B69)),
        ),
      ],
    );
  }
}

class AttendanceStatsRow extends StatelessWidget {
  final String checkInTime;
  final String totalHours;
  final String checkOutTime;

  const AttendanceStatsRow({
    super.key,
    required this.checkInTime,
    required this.totalHours,
    required this.checkOutTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttendanceStatItem(
          svgPath: 'assets/svg/Vector.svg',
          value: checkInTime,
          label: 'Check in',
        ),
        // const SizedBox(width: 1),
        AttendanceStatItem(
          svgPath: 'assets/svg/clock-arrow-down.svg',
          value: totalHours,
          label: 'Total Hours',
        ),

        // const SizedBox(width: 2),
        AttendanceStatItem(
          svgPath: 'assets/svg/clock-check.svg',
          value: checkOutTime,
          label: 'Check out',
        ),
      ],
    );
  }
}
