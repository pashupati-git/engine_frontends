import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/screens/rc_qr_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RcRechargeScreen extends StatefulWidget {
  const RcRechargeScreen({super.key});

  @override
  State<RcRechargeScreen> createState() => _RcRechargeScreenState();
}

class _RcRechargeScreenState extends State<RcRechargeScreen> {
  //-----State (wire these to your ViewModel/Bloc later)--------
  String? _selectedPackage;
  String? _selectedPeriod;
  String? _selectedOnu;
  bool _amountVisible = false;
  int _totalAmount = 0;
  String _breakdown = '';

  final _packageMap = <String, int>{
    'Tachyon-100Mbps': 1200,
    'Tachyon-200Mbps': 1800,
    'Tachyon-300Mbps': 2400,
  };

  void _onPackageChanged(String? val) {
    setState(() {
      _selectedPackage = val;
      _selectedPeriod = null;
      _amountVisible = false;
    });
  }

  void _onPeriodOrOnuChanged() {
    setState(() => _amountVisible = false);
  }

  void _calculateAmount() {
    if (_selectedPackage == null ||
        _selectedPeriod == null ||
        _selectedOnu == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'please select Package,Period and ONU Type.',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: RcColors.red,
        ),
      );
      return;
    }

    final base = _packageMap[_selectedPackage!] ?? 0;
    final onuFee = _selectedOnu == 'Wifi 6 ONU' ? 500 : 0;
    final is12 = _selectedPeriod == '12 Months';
    final total = (is12 ? base * 10 : base) + onuFee;
    final onuLabel = _selectedOnu == 'Wifi 6 ONU'
        ? 'Wifi 6 ONU (+Rs 500)'
        : 'Dual Band ONU';
    final periodLabel = is12 ? '12 Months(2 free)' : '1 Month';
    final breakdown = '$_selectedPackage * $periodLabel · $onuLabel';

    setState(() {
      _totalAmount = total;
      _breakdown = breakdown;
      _amountVisible = true;
    });
  }

  void _proceed() {
    if (!_amountVisible) {
      _calculateAmount();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RcQrPaymentScreen(
          customerName: dummyCustomer.name,
          package: _selectedPackage!,
          period: _selectedPeriod!,
          amount: _totalAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Recharge Screen')));
  }
}
