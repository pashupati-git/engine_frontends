import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────
// RC TOP BAR
// ─────────────────────────────────────────

class RcTopBar extends StatefulWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onRefresh;
  final IconData? backIcon;
  const RcTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.onRefresh,
    this.backIcon,
  });

  @override
  State<RcTopBar> createState() => _RcTopBarState();
}

class _RcTopBarState extends State<RcTopBar> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // white icons on Android
        statusBarBrightness: Brightness.dark, // white icons on iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RcColors.g8,
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 14.h),
      child: Row(
        children: [
          _TopBarButton(
            icon: widget.backIcon ?? Icons.arrow_back_ios_new_rounded,
            onTap: widget.onBack ?? () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: RcColors.gd,
                letterSpacing: 0.1,
              ),
            ),
          ),
          _TopBarButton(
            icon: Icons.refresh_rounded,
            onTap: widget.onRefresh ?? () {},
          ),
        ],
      ),
    );
  }
}

class _TopBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _TopBarButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16.sp, color: RcColors.gd),
      ),
    );
  }
}