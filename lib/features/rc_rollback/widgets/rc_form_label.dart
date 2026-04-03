import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────
// FORM LABEL
// ─────────────────────────────────────────
class RcFormLabel extends StatelessWidget {
  final String text;
  final bool required;
  final bool isDark;
  const RcFormLabel(
    this.text, {
    super.key,
    this.required = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text(
            text.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? RcColors.mid : RcColors.red,
              letterSpacing: 0.4,
            ),
          ),
          if (required)
            Text(
              ' *',
              style: TextStyle(
                color: RcColors.red,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}