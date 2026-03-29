import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rc_theme.dart';

// ─────────────────────────────────────────
// RC TOP BAR
// ─────────────────────────────────────────
class RcTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onRefresh;

  const RcTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RcColors.g8,
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 14.h),
      child: Row(
        children: [
          _TopBarButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack ?? () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: RcColors.gd,
                letterSpacing: 0.1,
              ),
            ),
          ),
          _TopBarButton(
            icon: Icons.refresh_rounded,
            onTap: onRefresh ?? () {},
          ),
        ],
      ),
    );
  }
}

class _TopBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopBarButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: RcColors.gd, size: 16.sp),
      ),
    );
  }
}

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

// ─────────────────────────────────────────
// INFO ROW (icon + label + value)
// ─────────────────────────────────────────
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
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: RcColors.g1,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 14.sp))),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: RcColors.mid,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? RcColors.ink,
              ),
            ),
          ),
          if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// INFO CARD CONTAINER
// ─────────────────────────────────────────
class RcInfoCard extends StatelessWidget {
  final List<Widget> children;

  const RcInfoCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(children: children),
      ),
    );
  }
}

// ─────────────────────────────────────────
// MAIN CTA BUTTON
// ─────────────────────────────────────────
enum RcButtonStyle { green, outline, red, gold }

class RcButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final RcButtonStyle style;
  final Widget? icon;
  final bool isSmall;

  const RcButton({
    super.key,
    required this.label,
    this.onTap,
    this.style = RcButtonStyle.green,
    this.icon,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    Border? border;

    switch (style) {
      case RcButtonStyle.green:
        bg = RcColors.g8;
        fg = RcColors.gd;
        break;
      case RcButtonStyle.outline:
        bg = RcColors.card;
        fg = RcColors.g8;
        border = Border.all(color: RcColors.g8, width: 2);
        break;
      case RcButtonStyle.red:
        bg = RcColors.red0;
        fg = RcColors.red;
        border = Border.all(color: RcColors.redLight, width: 2);
        break;
      case RcButtonStyle.gold:
        bg = RcColors.gd;
        fg = RcColors.g9;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: onTap != null ? 1.0 : 0.98,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: isSmall ? null : double.infinity,
          padding: isSmall
              ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h)
              : EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(isSmall ? 8.r : 12.r),
            border: border,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (icon != null) ...[icon!, SizedBox(width: 8.w)],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isSmall ? 13.sp : 15.sp,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

// ─────────────────────────────────────────
// TEXT FIELD
// ─────────────────────────────────────────
class RcTextField extends StatelessWidget {
  final String? initialValue;
  final String? hint;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const RcTextField({
    super.key,
    this.initialValue,
    this.hint,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: readOnly ? RcColors.mid : RcColors.ink,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14.sp,
          color: RcColors.soft,
        ),
        filled: true,
        fillColor: readOnly ? RcColors.bg : RcColors.card,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: RcColors.line, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: RcColors.line, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: RcColors.g8, width: 1.5),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// DROPDOWN FIELD
// ─────────────────────────────────────────
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
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: RcColors.mid, size: 20.sp),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: RcColors.ink,
          ),
          dropdownColor: RcColors.card,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// BANNER (info / error)
// ─────────────────────────────────────────
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
        border: Border.all(
          color: isSuccess ? RcColors.g2 : RcColors.redLight,
        ),
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
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isSuccess ? RcColors.g8 : RcColors.red,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// TOGGLE ROW
// ─────────────────────────────────────────
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
                      BoxShadow(color: Colors.black26, blurRadius: 3)
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

// ─────────────────────────────────────────
// PILL CHIP (for non-recharge reasons)
// ─────────────────────────────────────────
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

// ─────────────────────────────────────────
// CATEGORY CARD (non-recharge reasons container)
// ─────────────────────────────────────────
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
                      child: Text(emoji,
                          style: TextStyle(fontSize: 16.sp))),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: RcColors.ink)),
                      Text(subtitle,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              color: RcColors.mid)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(badgeText,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: badgeFg,
                          letterSpacing: 0.4)),
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

// ─────────────────────────────────────────
// TASK ITEM
// ─────────────────────────────────────────
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
                  child: Text(widget.emoji,
                      style: TextStyle(fontSize: 18.sp))),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: RcColors.ink)),
                  SizedBox(height: 2.h),
                  Text(widget.subtitle,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp, color: RcColors.mid)),
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

// ─────────────────────────────────────────
// UPLOAD ZONE
// ─────────────────────────────────────────
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
                  color: RcColors.line, width: 2, style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(icon, style: TextStyle(fontSize: 28.sp)),
                SizedBox(height: 6.h),
                Text(text,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: RcColors.mid)),
                SizedBox(height: 3.h),
                Text(hint,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp, color: RcColors.soft)),
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
                color: RcColors.g8),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────
// RECHARGE DECISION BOTTOM SHEET
// ─────────────────────────────────────────
class RcRechargeModal extends StatelessWidget {
  final String customerName;
  final String packageName;
  final String customerId;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const RcRechargeModal({
    super.key,
    required this.customerName,
    required this.packageName,
    required this.customerId,
    required this.onYes,
    required this.onNo,
  });

  static Future<void> show(
    BuildContext context, {
    required String customerName,
    required String packageName,
    required String customerId,
    required VoidCallback onYes,
    required VoidCallback onNo,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => RcRechargeModal(
        customerName: customerName,
        packageName: packageName,
        customerId: customerId,
        onYes: onYes,
        onNo: onNo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 36.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 14.h),
            width: 36.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: RcColors.line,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Icon
          Container(
            margin: EdgeInsets.only(top: 18.h),
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
                color: RcColors.g1, shape: BoxShape.circle),
            child: Center(
                child: Text('💳', style: TextStyle(fontSize: 28.sp))),
          ),
          // Title
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 6.h),
            child: Text(
              'Recharge Today?',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: RcColors.ink),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(28.w, 0, 28.w, 20.h),
            child: Text(
              'Does the customer want to recharge their internet package right now?',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp, color: RcColors.mid, height: 1.6),
            ),
          ),
          // Customer info
          Container(
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: RcColors.bg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: RcColors.line),
            ),
            child: Column(
              children: [
                _SheetRow('Customer', customerName),
                SizedBox(height: 7.h),
                _SheetRow('Package', packageName,
                    valueColor: RcColors.g8),
                SizedBox(height: 7.h),
                _SheetRow('Customer ID', customerId),
              ],
            ),
          ),
          // Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: RcButton(
                    label: '✓  Yes, Recharge',
                    style: RcButtonStyle.green,
                    onTap: () {
                      Navigator.of(context).pop();
                      onYes();
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RcButton(
                    label: '✗  No',
                    style: RcButtonStyle.red,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNo();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SheetRow(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp, color: RcColors.mid)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: valueColor ?? RcColors.ink)),
      ],
    );
  }
}

// ─────────────────────────────────────────
// HERO CUSTOMER CARD
// ─────────────────────────────────────────
class RcHeroCard extends StatelessWidget {
  final String initials;
  final String name;
  final String customerId;
  final String location;
  final String package;
  final String speed;
  final String subscription;

  const RcHeroCard({
    super.key,
    required this.initials,
    required this.name,
    required this.customerId,
    required this.location,
    required this.package,
    required this.speed,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [RcColors.g9, RcColors.g7, RcColors.g6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.6, 1],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: RcColors.gd,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.2), width: 3),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: RcColors.g9,
                        letterSpacing: -0.5),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.2)),
                    SizedBox(height: 3.h),
                    Text('Customer ID: $customerId · $location',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.65),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: RcColors.gd.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: RcColors.gd.withOpacity(0.45), width: 1.5),
                ),
                child: Text(
                  'RC Rollback',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: RcColors.gd,
                      letterSpacing: 0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Stats row
          Row(
            children: [
              _HeroStat(label: 'Package', value: package),
              SizedBox(width: 8.w),
              _HeroStat(label: 'Speed', value: speed),
              SizedBox(width: 8.w),
              _HeroStat(label: 'Subscription', value: subscription),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(8.r),
          border:
              Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Text(value,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 2.h),
            Text(label.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.sp,
                    color: Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6)),
          ],
        ),
      ),
    );
  }
}