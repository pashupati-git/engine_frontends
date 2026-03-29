import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rc_theme.dart';
import '../widgets/rc_widgets.dart';
import 'rc_qr_payment_screen.dart';

class RcRechargeScreen extends StatefulWidget {
  const RcRechargeScreen({super.key});

  @override
  State<RcRechargeScreen> createState() => _RcRechargeScreenState();
}

class _RcRechargeScreenState extends State<RcRechargeScreen> {
  // --- State (wire these to your ViewModel/Bloc later) ---
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
    if (_selectedPackage == null || _selectedPeriod == null || _selectedOnu == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select Package, Period and ONU Type.',
              style: GoogleFonts.plusJakartaSans()),
          backgroundColor: RcColors.red,
        ),
      );
      return;
    }

    final base = _packageMap[_selectedPackage!] ?? 0;
    final onuFee = _selectedOnu == 'WiFi 6 ONU' ? 500 : 0;
    final is12 = _selectedPeriod == '12 Months';
    final total = (is12 ? base * 10 : base) + onuFee;
    final onuLabel = _selectedOnu == 'WiFi 6 ONU'
        ? 'WiFi 6 ONU (+Rs 500)'
        : 'Dual Band ONU';
    final periodLabel = is12 ? '12 Months (2 free)' : '1 Month';
    final breakdown = '$_selectedPackage × $periodLabel · $onuLabel';

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
    return Scaffold(
      backgroundColor: RcColors.bg,
      body: Column(
        children: [
          Container(
            color: RcColors.g8,
            child: SafeArea(
              bottom: false,
              child: RcTopBar(title: 'Recharge'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 120.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RcBanner(
                    'Customer confirmed for recharge — ${dummyCustomer.name}',
                  ),

                  RcSectionLabel('Account',
                      margin: EdgeInsets.only(bottom: 10.h)),
                  const RcFormLabel('Username', isDark: true),
                  RcTextField(
                    initialValue: dummyCustomer.username,
                    readOnly: true,
                  ),

                  SizedBox(height: 16.h),
                  RcSectionLabel('Recharge Details',
                      margin: EdgeInsets.only(bottom: 10.h)),

                  // Package
                  RcFormLabel('Recharge Package', required: true),
                  RcDropdown(
                    items: _packageMap.keys.toList(),
                    value: _selectedPackage,
                    hint: 'Select Package',
                    onChanged: _onPackageChanged,
                  ),
                  SizedBox(height: 14.h),

                  // Subscription (visible after package)
                  if (_selectedPackage != null) ...[
                    RcFormLabel('Subscription Period', required: true),
                    RcDropdown(
                      items: rcSubscriptionPeriods,
                      value: _selectedPeriod,
                      hint: 'Select Period',
                      onChanged: (v) {
                        setState(() => _selectedPeriod = v);
                        _onPeriodOrOnuChanged();
                      },
                    ),
                    SizedBox(height: 14.h),
                  ],

                  // ONU Type
                  RcFormLabel('ONU Type', required: true),
                  RcDropdown(
                    items: rcOnuTypes,
                    value: _selectedOnu,
                    hint: 'Select ONU Type',
                    onChanged: (v) {
                      setState(() => _selectedOnu = v);
                      _onPeriodOrOnuChanged();
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Calculate button
                  RcButton(
                    label: 'Calculate Amount',
                    style: RcButtonStyle.gold,
                    onTap: _calculateAmount,
                  ),
                  SizedBox(height: 12.h),

                  // Amount card
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _amountVisible
                        ? _AmountCard(
                            key: const ValueKey('amount-card'),
                            amount: 'Rs ${_formatNum(_totalAmount)}',
                            breakdown: _breakdown,
                          )
                        : const SizedBox.shrink(),
                  ),

                  if (_amountVisible) ...[
                    RcButton(
                      label: 'Proceed with Payment →',
                      onTap: _proceed,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    return n.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}

class _AmountCard extends StatelessWidget {
  final String amount;
  final String breakdown;

  const _AmountCard({super.key, required this.amount, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [RcColors.g8, RcColors.g6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
              color: RcColors.g8.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Text(
            'TOTAL PAYABLE',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10.sp,
                letterSpacing: 0.8,
                color: Colors.white.withOpacity(0.75),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Text(
            amount,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 38.sp,
                fontWeight: FontWeight.w800,
                color: RcColors.gd,
                letterSpacing: -0.5),
          ),
          SizedBox(height: 5.h),
          Text(
            breakdown,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}