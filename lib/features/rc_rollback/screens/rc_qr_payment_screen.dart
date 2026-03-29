import 'dart:async';
import 'package:engine_frontends/features/rc_rollback/screens/rc_payment_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../rc_theme.dart';
import '../widgets/rc_widgets.dart';

class RcQrPaymentScreen extends StatefulWidget {
  final String customerName;
  final String package;
  final String period;
  final int amount;

  const RcQrPaymentScreen({
    super.key,
    required this.customerName,
    required this.package,
    required this.period,
    required this.amount,
  });

  @override
  State<RcQrPaymentScreen> createState() => _RcQrPaymentScreenState();
}

class _RcQrPaymentScreenState extends State<RcQrPaymentScreen> {
  int _secondsLeft = 299;
  Timer? _timer;
  bool _expired = false;
  bool _checking = false;
  bool _confirmed = false;

  // QR data — replace with real payment gateway QR URL/payload
  String get _qrData =>
      'RC_PAYMENT|customer:${widget.customerName}|pkg:${widget.package}|period:${widget.period}|amount:${widget.amount}|ts:${DateTime.now().millisecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft <= 0) {
        _timer?.cancel();
        setState(() => _expired = true);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _timerLabel {
    if (_expired) return 'Expired';
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _checkPayment() async {
    setState(() => _checking = true);
    // TODO: Replace with real API call to verify payment status
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _checking = false;
      _confirmed = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) _navigateToSuccess();
  }

  void _navigateToSuccess() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RcPaymentSuccessScreen(
          customerName: widget.customerName,
          package: widget.package,
          period: widget.period,
          amount: widget.amount,
        ),
      ),
    );
  }

  String _formatNum(int n) => n.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RcColors.bg,
      body: Column(
        children: [
          Container(
            color: RcColors.g8,
            child: SafeArea(bottom: false, child: RcTopBar(title: 'Payment')),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Payment info box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: RcColors.g1,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: RcColors.g2, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        _QrInfoRow('Customer', widget.customerName),
                        SizedBox(height: 7.h),
                        _QrInfoRow('Package', widget.package),
                        SizedBox(height: 7.h),
                        _QrInfoRow('Period', widget.period),
                        SizedBox(height: 7.h),
                        _QrInfoRow(
                          'Amount',
                          'Rs ${_formatNum(widget.amount)}',
                          valueBig: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Scan hint
                  Text(
                    'Scan via eSewa · Khalti · Bank QR',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: RcColors.mid,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // QR Box — uses qr_flutter to generate real QR
                  Container(
                    width: 220.w,
                    height: 220.w,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: RcColors.g8, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 40,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: _expired
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer_off_outlined,
                                  color: RcColors.red,
                                  size: 36.sp,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'QR Expired',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: RcColors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : QrImageView(
                            data: _qrData,
                            version: QrVersions.auto,
                            gapless: false,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: RcColors.g8,
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: RcColors.g8,
                            ),
                          ),
                  ),
                  SizedBox(height: 14.h),

                  // Timer badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: RcColors.gd0,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: RcColors.gd, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14.sp,
                          color: RcColors.amber,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          _expired ? 'QR Expired' : 'Expires in  $_timerLabel',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: RcColors.amber,
                            fontFeatures: [const FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Check payment button
                  if (!_expired)
                    RcButton(
                      label: _confirmed
                          ? '✓  Payment Confirmed!'
                          : _checking
                          ? '⏳  Checking...'
                          : '↻  Check Payment Status',
                      style: _confirmed
                          ? RcButtonStyle.outline
                          : RcButtonStyle.outline,
                      onTap: _checking || _confirmed ? null : _checkPayment,
                    ),

                  if (_expired) ...[
                    SizedBox(height: 4.h),
                    RcButton(
                      label: 'Regenerate QR',
                      style: RcButtonStyle.gold,
                      onTap: () {
                        setState(() {
                          _expired = false;
                          _secondsLeft = 299;
                        });
                        _startTimer();
                      },
                    ),
                  ],

                  SizedBox(height: 10.h),
                  // Demo skip button
                  RcButton(
                    label: 'Continue (Demo)',
                    style: RcButtonStyle.green,
                    onTap: _navigateToSuccess,
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

class _QrInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool valueBig;

  const _QrInfoRow(this.label, this.value, {this.valueBig = false});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            fontSize: valueBig ? 16.sp : 13.sp,
            fontWeight: FontWeight.w700,
            color: valueBig ? RcColors.g8 : RcColors.ink,
          ),
        ),
      ],
    );
  }
}
