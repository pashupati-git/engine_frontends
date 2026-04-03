import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────
// SECTION LABEL
// ─────────────────────────────────────────

class RcSectionLabel extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;
  const RcSectionLabel(this.text, {super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(
            text.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: RcColors.g8,
              letterSpacing: 0.9,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(child: Container(height: 1, color: RcColors.g2)),
        ],
      ),
    );
  }
}