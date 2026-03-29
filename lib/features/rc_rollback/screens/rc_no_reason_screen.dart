import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rc_theme.dart';
import '../widgets/rc_widgets.dart';
import 'rc_rollback_screen.dart';
import 'rc_customer_details_screen.dart';

class RcNoReasonScreen extends StatefulWidget {
  const RcNoReasonScreen({super.key});

  @override
  State<RcNoReasonScreen> createState() => _RcNoReasonScreenState();
}

class _RcNoReasonScreenState extends State<RcNoReasonScreen> {
  final _notesController = TextEditingController();
  final _remarksController = TextEditingController();
  DateTime? _revisitDate;

  // toggle states — wire to Bloc/Provider later
  final Map<String, bool> _toggles = {
    'offer': false,
    'escalate': false,
    'partial': false,
    'churned': false,
  };

  @override
  void dispose() {
    _notesController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: RcColors.g8),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _revisitDate = picked);
  }

  String get _dateLabel {
    if (_revisitDate == null) return 'Select Date';
    return '${_revisitDate!.day.toString().padLeft(2, '0')} '
        '${_monthName(_revisitDate!.month)} '
        '${_revisitDate!.year}';
  }

  String _monthName(int m) => [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m];

  void _saveAndClose() {
    // TODO: submit form via API
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RcCustomerDetailsScreen()),
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RcColors.bg,
      body: Column(
        children: [
          Container(
            color: RcColors.g8,
            child: SafeArea(
              bottom: false,
              child: RcTopBar(title: 'Non-Recharge Reason'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 40.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RcBanner(
                    'Customer declined recharge — please log all applicable reasons below.',
                    type: RcBannerType.error,
                  ),

                  // Technical Issues
                  RcCategoryCard(
                    emoji: '🔧',
                    title: 'Technical Issues',
                    subtitle: 'Service quality & connectivity problems',
                    badgeText: 'Technical',
                    badgeBg: RcColors.amber0,
                    badgeFg: RcColors.amber,
                    pills: rcTechReasons,
                    pillColor: RcPillColor.amber,
                  ),

                  // Payment & Pricing
                  RcCategoryCard(
                    emoji: '💳',
                    title: 'Payment & Pricing',
                    subtitle: 'Financial & offer-related reasons',
                    badgeText: 'Payment',
                    badgeBg: RcColors.red0,
                    badgeFg: RcColors.red,
                    pills: rcPaymentReasons,
                    pillColor: RcPillColor.red,
                  ),

                  // Personal / Situational
                  RcCategoryCard(
                    emoji: '🏠',
                    title: 'Personal / Situational',
                    subtitle: 'Customer availability & circumstances',
                    badgeText: 'Personal',
                    badgeBg: RcColors.blue0,
                    badgeFg: RcColors.blue,
                    pills: rcPersonalReasons,
                    pillColor: RcPillColor.green,
                  ),

                  // Additional Notes
                  RcFormLabel('Additional Notes (optional)', isDark: true),
                  RcTextField(
                    controller: _notesController,
                    hint: 'Describe any other reason in detail...',
                    maxLines: 3,
                  ),
                  SizedBox(height: 18.h),

                  // Follow-up actions
                  RcSectionLabel('Follow-Up Actions Taken'),
                  RcToggleRow(
                    title: 'Explained Current Offer',
                    subtitle: 'Presented available packages & discounts',
                    onChanged: (v) => setState(() => _toggles['offer'] = v),
                  ),
                  RcToggleRow(
                    title: 'Escalated to Technical Team',
                    subtitle: 'Logged technical complaint for resolution',
                    onChanged: (v) =>
                        setState(() => _toggles['escalate'] = v),
                  ),
                  RcToggleRow(
                    title: 'Collected Partial Payment',
                    subtitle: 'Customer made a partial recharge',
                    onChanged: (v) =>
                        setState(() => _toggles['partial'] = v),
                  ),
                  RcToggleRow(
                    title: 'Customer Not Interested',
                    subtitle: 'Mark as churned / non-convertible',
                    onChanged: (v) =>
                        setState(() => _toggles['churned'] = v),
                  ),

                  SizedBox(height: 18.h),

                  // Schedule revisit
                  RcSectionLabel('Schedule Follow-Up Visit'),
                  RcFormLabel('Revisit Date', isDark: true),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 13.h),
                      decoration: BoxDecoration(
                        color: RcColors.card,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: RcColors.line, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 16.sp, color: RcColors.mid),
                          SizedBox(width: 10.w),
                          Text(
                            _dateLabel,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                              color: _revisitDate != null
                                  ? RcColors.ink
                                  : RcColors.soft,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  RcFormLabel('Remarks', isDark: true),
                  RcTextField(
                    controller: _remarksController,
                    hint: 'Additional notes for follow-up...',
                    maxLines: 3,
                  ),
                  SizedBox(height: 12.h),

                  // Divider
                  Container(height: 1, color: RcColors.line, margin: EdgeInsets.symmetric(vertical: 12.h)),

                  // RC Rollback Banner
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const RcRollbackScreen()),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [RcColors.g9, RcColors.g7],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: RcColors.g7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46.w,
                            height: 46.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                                child: Text('↩',
                                    style: TextStyle(fontSize: 22.sp))),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Proceed with RC Rollback',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                SizedBox(height: 2.h),
                                Text(
                                    'Customer equipment recovery & uninstallation',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        color:
                                            Colors.white.withOpacity(0.65))),
                              ],
                            ),
                          ),
                          Text('›',
                              style: TextStyle(
                                  color: RcColors.gd, fontSize: 22.sp)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  RcButton(
                    label: 'Save & Close Visit',
                    style: RcButtonStyle.outline,
                    onTap: _saveAndClose,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}