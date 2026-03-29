import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../exit_theme.dart';
import '../widgets/exit_widgets.dart';

class ExitPageSignature extends StatelessWidget {
  final bool signed;
  final VoidCallback onSign;
  final bool submitted;

  const ExitPageSignature({
    super.key,
    required this.signed,
    required this.onSign,
    this.submitted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (submitted) {
      return ExitSuccessView(employeeName: dummyEmployee.name);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExitSectionHeader(badge: '✏', title: 'Acknowledgement & Signature'),
          ExitCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee Signature',
                  style: GoogleFonts.dmSans(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                    color: ExitColors.textMuted,
                  ),
                ),
                SizedBox(height: 5.h),
                ExitSignatureArea(signed: signed, onTap: onSign),
                if (!signed) ...[
                  SizedBox(height: 12.h),
                  Text(
                    'By signing, you confirm that the information provided in this exit interview is accurate and reflects your genuine experience.',
                    style: GoogleFonts.dmSans(
                      fontSize: 12.sp,
                      color: ExitColors.textHint,
                      height: 1.55,
                    ),
                  ),
                ],
                if (signed) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: ExitColors.greenLight,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: ExitColors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_outlined,
                            color: ExitColors.green, size: 18),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Signature recorded. You may now submit the form.',
                            style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                              color: ExitColors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}