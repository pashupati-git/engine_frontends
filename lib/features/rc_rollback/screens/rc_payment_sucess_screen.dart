import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/screens/rc_customer_details_screen.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_section_label.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_task_item.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RcPaymentSuccessScreen extends StatefulWidget {
  final String customerName;
  final String package;
  final String period;
  final int amount;

  const RcPaymentSuccessScreen({
    super.key,
    required this.customerName,
    required this.package,
    required this.period,
    required this.amount,
  });

  @override
  State<RcPaymentSuccessScreen> createState() => _RcPaymentSuccessScreenState();
}

class _RcPaymentSuccessScreenState extends State<RcPaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ringAnim;
  late final Animation<double> _scaleAnim;
  bool _phoneEditorOpen = false;
  final _phoneController = TextEditingController();
  bool _phoneSaved = false;

  //TODO:Task done states - wire to Bloc/Provider later
  final Map<String, bool> _taskDone = {
    't1': false,
    't2': false,
    't3': false,
    't4': false,
  };

  String get _validUntil {
    final d = DateTime.now();
    final end = widget.period == '12 Months'
        ? DateTime(d.year + 1, d.month, d.day)
        : DateTime(d.year, d.month + 1, d.day);
    return '${end.day.toString().padLeft(2, '0')} ${_monthName(end.month)} ${end.year}';
  }

  String _monthName(int m) => [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m];

  String _formatNum(int n) => n.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  void initState() {
    super.initState();
    _ringAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnim = CurvedAnimation(parent: _ringAnim, curve: Curves.elasticOut);
    _ringAnim.forward();
  }

  @override
  void dispose() {
    _ringAnim.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _tapTask(String id) {
    if (id == 't1') {
      setState(() => _phoneEditorOpen = !_phoneEditorOpen);
      return;
    }
    if (id == 't3') {
      _pickPhoto();
      return;
    }
    setState(() => _taskDone[id] = !(_taskDone[id] ?? false));
  }

  void _savePhone() {
    if (_phoneController.text.trim().isEmpty) return;
    setState(() {
      _phoneSaved = true;
      _taskDone['t1'] = true;
      _phoneEditorOpen = false;
    });
    //TODO: call Api to update phone number.---------------------------------
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => _taskDone['t3'] = true);
      //TODO: upload photo via API:------------------------------------------
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RcColors.bg,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: RcColors.g8,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: RcColors.g8,
            child: SafeArea(
              bottom: false,
              child: RcTopBar(
                title: 'Payment Complete',
                backIcon: Icons.close_rounded,
                onBack: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const RcCustomerDetailsScreen(),
                  ),
                  (route) => false,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 32.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Success hero-------------------------------------------
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Column(
                      children: [
                        ScaleTransition(
                          scale: _scaleAnim,
                          child: Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: const BoxDecoration(
                              color: RcColors.g1,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check_rounded,
                                color: RcColors.g8,
                                size: 36.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Payment Successful!',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: RcColors.g8,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              color: RcColors.mid,
                              height: 1.6,
                            ),
                            children: [
                              const TextSpan(text: 'Recharge complete for\n'),
                              TextSpan(
                                text:
                                    '${widget.customerName} · #${dummyCustomer.id}',

                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Summary card-------------------------------------------------
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: RcColors.card,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: RcColors.line),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Column(
                        children: [
                          _SummaryRow(
                            'Transaction ID',
                            'TXN-${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
                            valueColor: RcColors.g8,
                          ),
                          _SummaryRow('Package', widget.package),
                          _SummaryRow('Period', widget.period),
                          _SummaryRow(
                            'Amount Paid',
                            'Rs ${_formatNum(widget.amount)}',
                            valueColor: RcColors.g8,
                          ),
                          _SummaryRow('Valid Until', _validUntil, isLast: true),
                        ],
                      ),
                    ),
                  ),

                  //Task section---------------------------------------------------
                  RcSectionLabel('Complete remaining Tasks'),

                  //Task 1; Phone update
                  RcTaskItem(
                    emoji: '📞',
                    title: 'Mobile Number Correction',
                    subtitle: _phoneSaved
                        ? 'Updated to: ${_phoneController.text}'
                        : 'Tap to update contact number',
                    done: _taskDone['t1'] ?? false,
                    onTap: () => _tapTask('t1'),
                  ),

                  // Inline phone editor
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _phoneEditorOpen
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: RcColors.g1,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: RcColors.g2,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UPDATE MOBILE NUMBER',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: RcColors.g8,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Current Number',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: RcColors.mid,
                                  ),
                                ),
                                SizedBox(height:10.h),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;
  const _SummaryRow(
    this.label,
    this.value, {
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: RcColors.bg)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
