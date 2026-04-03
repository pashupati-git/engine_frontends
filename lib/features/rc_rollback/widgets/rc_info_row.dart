import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcInfoRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;
  final bool isLast;

  const RcInfoRow({
    super.key,
    required this.emoji,
    required this.label,
    required this.value,
    this.valueColor,
    this.trailing,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: RcColors.bg, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // ← center all items vertically
        children: [
          // Emoji icon box
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: RcColors.g1,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 14.sp)),
            ),
          ),
          SizedBox(width: 12.w),

          // Label
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: RcColors.mid,
            ),
          ),

          const Spacer(),

          // Value + trailing in a Row together
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (value.isNotEmpty)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 130.w,
                  ), // ← prevents overflow
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? RcColors.ink,
                    ),
                  ),
                ),
              if (trailing != null) ...[
                if (value.isNotEmpty) SizedBox(width: 8.w),
                trailing!,
              ],
            ],
          ),
        ],
      ),
    );
  }
}