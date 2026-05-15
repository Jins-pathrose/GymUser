import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? avatarImagePath;

  const HomeHeader({
    super.key,
    required this.userName,
    this.avatarImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Welcome Back,',
              
              style: AppStyle.text(size: 14, color: Color(0xFF232323), weight: FontWeight.w400),
            ),
            const SizedBox(height: 2),
            Text(
              userName,
              
              style: AppStyle.text(size: 22, weight: FontWeight.w600, color: Color(0xFFFF6A00)),
            ),
          ],
        ),
        // Avatar circle
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
            image: avatarImagePath != null
                ? DecorationImage(
                    image: AssetImage(avatarImagePath!),
                    fit: BoxFit.cover,
                  )
                : null,
            color: avatarImagePath == null ? const Color(0xFFFF6B00) : null,
          ),
          child: avatarImagePath == null
              ? Center(
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                   
                    style: AppStyle.text(size: 18, color: Colors.white, weight: FontWeight.bold),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}