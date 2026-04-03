// ─────────────────────────────────────────
// TOGGLE ROW
// ─────────────────────────────────────────

import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcToggleRow extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const RcToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<RcToggleRow> createState() => _RcToggleRowState();
}

class _RcToggleRowState extends State<RcToggleRow> {
  late bool _on;

  @override
  void initState() {
    super.initState();
    _on = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _on = !_on);
        widget.onChanged?.call(_on);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: RcColors.card,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: _on ? RcColors.g2 : RcColors.line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: RcColors.ink,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: RcColors.mid,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: _on ? RcColors.g8 : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: _on ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(3.w),
                  width: 18.w,
                  height: 18.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}