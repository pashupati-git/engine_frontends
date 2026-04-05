import 'package:flutter/material.dart';

class RcQrPaymentScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('QR Payment Screen')));
  }
}