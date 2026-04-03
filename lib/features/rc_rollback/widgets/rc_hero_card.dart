// ─────────────────────────────────────────
// HERO CUSTOMER CARD
// ─────────────────────────────────────────
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RcHeroCard extends StatelessWidget {
  final String initials;
  final String name;
  final String customerId;
  final String location;
  final String package;
  final String speed;
  final String subscription;

  const RcHeroCard({
    super.key,
    required this.initials,
    required this.name,
    required this.customerId,
    required this.location,
    required this.package,
    required this.speed,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [RcColors.g9, RcColors.g7, RcColors.g6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.6, 1],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // ← key fix
            children: [
              // Avatar
              Container(
                width: 68.w,
                height: 68.w,
                decoration: BoxDecoration(
                  color: RcColors.gd,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: RcColors.g9,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              // Name + Customer ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Customer ID: $customerId · $location',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.65),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // RC Rollback Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: RcColors.gd.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: RcColors.gd.withOpacity(0.45),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'RC Rollback',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: RcColors.gd,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Stats row
          Row(
            children: [
              _HeroStat(label: 'Package', value: package),
              SizedBox(width: 8.w),
              _HeroStat(label: 'Speed', value: speed),
              SizedBox(width: 8.w),
              _HeroStat(label: 'Subscription', value: subscription),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.sp,
                color: Colors.white.withOpacity(0.55),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}