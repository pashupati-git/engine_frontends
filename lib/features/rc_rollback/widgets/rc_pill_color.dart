// ─────────────────────────────────────────
// PILL CHIP (for non-recharge reasons)
// ─────────────────────────────────────────
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum RcPillColor { green, red, amber }

class RcPill extends StatefulWidget {
  final String label;
  final RcPillColor color;
  final ValueChanged<bool>? onToggled;

  const RcPill({
    super.key,
    required this.label,
    this.color = RcPillColor.green,
    this.onToggled,
  });

  @override
  State<RcPill> createState() => _RcPillState();
}

class _RcPillState extends State<RcPill> {
  bool _selected = false;

  Color get _activeColor {
    switch (widget.color) {
      case RcPillColor.green:
        return RcColors.g8;
      case RcPillColor.red:
        return RcColors.red;
      case RcPillColor.amber:
        return RcColors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _selected = !_selected);
        widget.onToggled?.call(_selected);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _selected ? _activeColor : RcColors.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _selected ? _activeColor : RcColors.line,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                color: _selected ? Colors.white.withOpacity(0.8) : _activeColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              widget.label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _selected ? Colors.white : RcColors.ink2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}