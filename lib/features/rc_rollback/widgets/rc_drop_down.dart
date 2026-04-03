// ─────────────────────────────────────────
// DROPDOWN FIELD
// ─────────────────────────────────────────`
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String hint;
  final ValueChanged<String?> onChanged;

  const RcDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: RcColors.line, width: 1.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: RcColors.soft,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: RcColors.mid,
            size: 20.sp,
          ),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: RcColors.ink,
          ),
          dropdownColor: RcColors.card,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}