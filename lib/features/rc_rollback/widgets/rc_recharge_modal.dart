// ─────────────────────────────────────────
// RECHARGE DECISION BOTTOM SHEET
// ─────────────────────────────────────────

import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        bottom: MediaQuery.of(context).viewInsets.bottom + 36.h, //drawer height
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle------------------------
          Container(
            margin: EdgeInsets.only(top: 14.h),
            width: 36.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: RcColors.line,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Icon----------------------------
          Container(
            margin: EdgeInsets.only(top: 18.h),
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: RcColors.g1,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('💳', style: TextStyle(fontSize: 28.sp)),
            ),
          ),
          // Title---------------------------
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 6.h),
            child: Text(
              'Recharge Today?',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: RcColors.ink,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(28.w, 0, 28.w, 20.h),
            child: Text(
              'Does the customer want to recharge their internet package right now?',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: RcColors.mid,
                height: 1.6,
              ),
            ),
          ),
          // Customer info--------------------------------------
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
                _SheetRow('Package', packageName, valueColor: RcColors.g8),
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
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            color: RcColors.mid,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ?? RcColors.ink,
          ),
        ),
      ],
    );
  }
}
