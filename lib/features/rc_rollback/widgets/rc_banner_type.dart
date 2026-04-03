//----------------------------------------
//Banner (indo/error)
//----------------------------------------

import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum RcBannerType { success, error }

class RcBanner extends StatelessWidget {
  final String text;
  final RcBannerType type;
  const RcBanner(this.text, {super.key, this.type = RcBannerType.success});

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == RcBannerType.success;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: isSuccess ? RcColors.g1 : RcColors.red0,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: isSuccess ? RcColors.g2 : RcColors.redLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSuccess ? '✓' : '✗',
            style: TextStyle(
              color: isSuccess ? RcColors.g8 : RcColors.red,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: isSuccess ? RcColors.g8 : RcColors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
