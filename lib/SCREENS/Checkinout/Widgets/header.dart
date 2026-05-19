import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? avatarImagePath;
  final VoidCallback? onLogout;

  const HomeHeader({
    super.key,
    required this.userName,
    this.avatarImagePath,
    this.onLogout,
  });

  Future<void> _showLogoutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Logout Icon Circle ──
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF6A00).withOpacity(0.12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFFF6A00),
                  size: 32,
                ),
              ),

              const SizedBox(height: 20),

              // ── Title ──
              Text(
                'Logout',
                style: AppStyle.text(
                  size: 22,
                  weight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 10),

              // ── Subtitle ──
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: AppStyle.text(
                  size: 14,
                  weight: FontWeight.w400,
                  color: const Color(0xFF888888),
                ),
              ),

              const SizedBox(height: 28),

              // ── Buttons Row ──
              Row(
                children: [
                  // ── No Button ──
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, false),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'No',
                            style: AppStyle.text(
                              size: 16,
                              weight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // ── Yes Button ──
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, true),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6A00),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: AppStyle.text(
                              size: 16,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && onLogout != null) {
      onLogout!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Welcome Text ──
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back,',
              style: AppStyle.text(
                size: 14,
                color: const Color(0xFF232323),
                weight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              userName,
              style: AppStyle.text(
                size: 22,
                weight: FontWeight.w600,
                color: const Color(0xFFFF6A00),
              ),
            ),
          ],
        ),

        // ── Avatar + Logout ──
        Row(
          children: [
            // ── Avatar Circle ──
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
                        style: AppStyle.text(
                          size: 18,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            // ── Logout Button ──
            GestureDetector(
              onTap: () => _showLogoutDialog(context),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEEE5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFD5B8), width: 1),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFFF6A00),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
