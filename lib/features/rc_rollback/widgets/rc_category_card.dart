// ─────────────────────────────────────────
// CATEGORY CARD (non-recharge reasons container)
// ─────────────────────────────────────────
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_pill_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcCategoryCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String badgeText;
  final Color badgeBg;
  final Color badgeFg;
  final List<String> pills;
  final RcPillColor pillColor;

  const RcCategoryCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.badgeBg,
    required this.badgeFg,
    required this.pills,
    required this.pillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: RcColors.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: RcColors.line)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: badgeBg.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: RcColors.ink,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          color: RcColors.mid,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: badgeFg,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Pills
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Wrap(
              spacing: 7.w,
              runSpacing: 7.h,
              children: pills
                  .map((p) => RcPill(label: p, color: pillColor))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}