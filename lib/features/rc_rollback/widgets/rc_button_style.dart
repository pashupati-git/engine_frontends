import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum RcButtonStyle { green, outline, red, gold }

class RcButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final RcButtonStyle style;
  final Widget? icon;
  final bool isSmall;

  const RcButton({
    super.key,
    required this.label,
    this.onTap,
    this.style = RcButtonStyle.green,
    this.icon,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    Border? border;
    switch (style) {
      case RcButtonStyle.green:
        bg = RcColors.g8;
        fg = RcColors.gd;
        break;
      case RcButtonStyle.outline:
        bg = RcColors.card;
        fg = RcColors.g8;
        border = Border.all(color: RcColors.g8, width: 2);
        break;
      case RcButtonStyle.red:
        bg = RcColors.red0;
        fg = RcColors.red;
        break;
      case RcButtonStyle.gold:
        bg = RcColors.gd;
        fg = RcColors.g9;
        break;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: onTap != null ? 1.0 : 0.98,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: isSmall ? null : double.infinity,
          padding: isSmall
              ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h)
              : EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(isSmall ? 8.r : 12.r),
            border: border,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (icon != null) ...[icon!, SizedBox(width: 8.w)],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isSmall ? 13.sp : 15.sp,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}