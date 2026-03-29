import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RcColors {
  // Greens
  static const g9 = Color(0xFF0D4020);
  static const g8 = Color(0xFF1A6B2F);
  static const g7 = Color(0xFF206035);
  static const g6 = Color(0xFF2D8A47);
  static const g2 = Color(0xFFC3E6CD);
  static const g1 = Color(0xFFE8F5EC);
  static const g0 = Color(0xFFF2FAF4);

  // Gold
  static const gd = Color(0xFFD4A843);
  static const gd2 = Color(0xFFC8982A);
  static const gd0 = Color(0xFFFDF6E3);

  // Red
  static const red = Color(0xFFB91C1C);
  static const red0 = Color(0xFFFEF2F2);
  static const redLight = Color(0xFFFCA5A5);

  // Amber
  static const amber = Color(0xFFB45309);
  static const amber0 = Color(0xFFFFFBEB);

  // Blue
  static const blue = Color(0xFF1D4ED8);
  static const blue0 = Color(0xFFEFF6FF);

  // Neutrals
  static const ink = Color(0xFF111827);
  static const ink2 = Color(0xFF374151);
  static const mid = Color(0xFF6B7280);
  static const soft = Color(0xFF9CA3AF);
  static const line = Color(0xFFE5E7EB);
  static const bg = Color(0xFFF9FAFB);
  static const card = Colors.white;
}

class RcTextStyles {
  static TextStyle heading(double size, {Color? color, FontWeight weight = FontWeight.w800}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color ?? RcColors.ink,
      );

  static TextStyle body(double size, {Color? color, FontWeight weight = FontWeight.w500}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color ?? RcColors.ink2,
      );

  static TextStyle label({Color? color}) => GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: color ?? RcColors.g8,
        letterSpacing: 0.9,
      );
}

/// Dummy data models — swap with real API models later
class RcCustomer {
  final String id;
  final String name;
  final String initials;
  final String address;
  final String phone;
  final String gpsRegistered;
  final String gpsCurrent;
  final String package;
  final String speed;
  final String subscription;
  final String username;

  const RcCustomer({
    required this.id,
    required this.name,
    required this.initials,
    required this.address,
    required this.phone,
    required this.gpsRegistered,
    required this.gpsCurrent,
    required this.package,
    required this.speed,
    required this.subscription,
    required this.username,
  });
}

const dummyCustomer = RcCustomer(
  id: '362047',
  name: 'Puja Maharjan',
  initials: 'PM',
  address: 'Laka Chowk, Lalitpur',
  phone: '9860369715',
  gpsRegistered: '27.6355, 85.3193',
  gpsCurrent: '27.6354, 85.3192',
  package: 'Tachyon-100Mbps',
  speed: '100 Mbps',
  subscription: '12 Months',
  username: 'puja.maharjan_362047',
);

class RcPackage {
  final String label;
  final String value;
  final int basePrice;
  const RcPackage({required this.label, required this.value, required this.basePrice});
}

final rcPackages = [
  const RcPackage(label: 'Tachyon-100Mbps', value: '100', basePrice: 1200),
  const RcPackage(label: 'Tachyon-200Mbps', value: '200', basePrice: 1800),
  const RcPackage(label: 'Tachyon-300Mbps', value: '300', basePrice: 2400),
];

const rcSubscriptionPeriods = ['1 Month', '12 Months'];
const rcOnuTypes = ['Dual Band ONU', 'WiFi 6 ONU'];

const rcUninstallReasons = [
  'Service Dissatisfaction',
  'Switching ISP',
  'Financial Constraint',
  'Relocation',
  'Business Closure',
];

const rcDetailReasons = [
  'Frequent Disconnection',
  'Slow Speed',
  'High Latency',
  'Poor Support',
  'Price Too High',
  'Other',
];

const rcNextIsps = ['Worldlink', 'Vianet', 'Classic Tech', 'Subisu', 'Not Switching'];

// Non-recharge reason pills
const rcTechReasons = [
  'Frequent Internet Down',
  'Slow Speed',
  'High Latency / Gaming Issue',
  'WiFi Coverage Issue',
  'ONU / Router Problem',
];
const rcPaymentReasons = [
  'Too Expensive',
  'Waiting for Offer / Discount',
  'Financial Difficulty',
  'Wants Cheaper Package',
];
const rcPersonalReasons = [
  'Out of Town / Temporary',
  'Relocating / Moving',
  'Switching to Other ISP',
  'Not Interested',
];