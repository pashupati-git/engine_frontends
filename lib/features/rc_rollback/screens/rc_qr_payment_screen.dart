import 'dart:async';

import 'package:engine_frontends/features/rc_rollback/screens/rc_payment_sucess_screen.dart';
import 'package:flutter/material.dart';

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

  /// QR data - replace with real payment gateway QR URL/payload
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
    //TODO: Replace with real API call to verify payment status
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _checking = false;
      _confirmed = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) _navigateToSuccess();
  }

  void _navigateToSuccess() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
    RcPaymentSuccessScreen(
      customerName:widget.customerName,
      package:widget.package,
      period:widget.period,
      amount:widget.amount,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('QR Payment Screen')));
  }
}
