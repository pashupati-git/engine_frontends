// ─────────────────────────────────────────
// TASK ITEM
// ─────────────────────────────────────────
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcTaskItem extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool done;
  final VoidCallback? onTap;

  const RcTaskItem({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.done = false,
    this.onTap,
  });

  @override
  State<RcTaskItem> createState() => _RcTaskItemState();
}

class _RcTaskItemState extends State<RcTaskItem> {
  late bool _done;

  @override
  void initState() {
    super.initState();
    _done = widget.done;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _done = !_done);
        widget.onTap?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _done ? RcColors.g1 : RcColors.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _done ? RcColors.g8 : RcColors.line,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: _done ? RcColors.g8 : RcColors.bg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(widget.emoji, style: TextStyle(fontSize: 18.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                color: _done ? RcColors.g8 : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _done ? RcColors.g8 : RcColors.line,
                  width: 2,
                ),
              ),
              child: _done
                  ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}