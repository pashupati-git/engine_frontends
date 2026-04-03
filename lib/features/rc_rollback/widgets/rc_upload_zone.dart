// ─────────────────────────────────────────
// UPLOAD ZONE
// ─────────────────────────────────────────

import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcUploadZone extends StatelessWidget {
  final String icon;
  final String text;
  final String hint;
  final VoidCallback? onTap;
  final String? fileName;
  final double? height;

  const RcUploadZone({
    super.key,
    this.icon = '📄',
    this.text = 'Tap to upload image',
    this.hint = 'JPG, PNG · Max 10MB',
    this.onTap,
    this.fileName,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: RcColors.bg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: RcColors.line,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(icon, style: TextStyle(fontSize: 28.sp)),
                SizedBox(height: 6.h),
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: RcColors.mid,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  hint,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    color: RcColors.soft,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (fileName != null) ...[
          SizedBox(height: 5.h),
          Text(
            '✓ $fileName',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: RcColors.g8,
            ),
          ),
        ],
      ],
    );
  }
}