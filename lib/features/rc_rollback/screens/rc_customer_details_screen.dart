import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../rc_theme.dart';
import '../widgets/rc_widgets.dart';
import 'rc_recharge_screen.dart';
import 'rc_no_reason_screen.dart';

class RcCustomerDetailsScreen extends StatelessWidget {
  const RcCustomerDetailsScreen({super.key});

  Future<void> _openMaps(String coords) async {
    final parts = coords.split(',');
    final lat = parts[0].trim();
    final lng = parts[1].trim();
    final uri = Uri.parse('https://maps.google.com/?q=$lat,$lng');
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  void _showRechargeModal(BuildContext context) {
    RcRechargeModal.show(
      context,
      customerName: dummyCustomer.name,
      packageName: dummyCustomer.package,
      customerId: dummyCustomer.id,
      onYes: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RcRechargeScreen()),
      ),
      onNo: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RcNoReasonScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RcColors.bg,
      body: Column(
        children: [
          // Status bar area
          Container(
            color: RcColors.g8,
            child: SafeArea(
              bottom: false,
              child: RcTopBar(
                title: 'RC Customer Details',
                onBack: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero card
                  RcHeroCard(
                    initials: dummyCustomer.initials,
                    name: dummyCustomer.name,
                    customerId: dummyCustomer.id,
                    location: 'Laka Chowk',
                    package: 'Tachyon',
                    speed: dummyCustomer.speed,
                    subscription: dummyCustomer.subscription,
                  ),

                  // Contact & Location
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(14.w, 20.h, 14.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RcSectionLabel('Contact & Location'),
                        RcInfoCard(children: [
                          RcInfoRow(
                            emoji: '📍',
                            label: 'Address',
                            value: dummyCustomer.address,
                          ),
                          RcInfoRow(
                            emoji: '📞',
                            label: 'Phone No.',
                            value: dummyCustomer.phone,
                            trailing: GestureDetector(
                              onTap: () => _callPhone(dummyCustomer.phone),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.w, vertical: 7.h),
                                decoration: BoxDecoration(
                                  color: RcColors.g8,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.call_rounded,
                                        color: Colors.white, size: 13.sp),
                                    SizedBox(width: 5.w),
                                    Text('Call',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          RcInfoRow(
                            emoji: '🗺',
                            label: 'GPS (Current)',
                            value: dummyCustomer.gpsCurrent,
                            trailing: GestureDetector(
                              onTap: () =>
                                  _openMaps(dummyCustomer.gpsCurrent),
                              child: _mapButton(),
                            ),
                          ),
                          RcInfoRow(
                            emoji: '📌',
                            label: 'GPS (Registered)',
                            value: dummyCustomer.gpsRegistered,
                            isLast: true,
                            trailing: GestureDetector(
                              onTap: () =>
                                  _openMaps(dummyCustomer.gpsRegistered),
                              child: _mapButton(),
                            ),
                          ),
                        ]),

                        SizedBox(height: 20.h),

                        // Package Details
                        RcSectionLabel('Package Details'),
                        RcInfoCard(children: [
                          RcInfoRow(
                            emoji: '📦',
                            label: 'Package',
                            value: dummyCustomer.package,
                            valueColor: RcColors.g8,
                          ),
                          RcInfoRow(
                            emoji: '📅',
                            label: 'Subscription',
                            value: dummyCustomer.subscription,
                            isLast: true,
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom action bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 16.h + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: RcColors.card,
          border: Border(top: BorderSide(color: RcColors.line)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: RcButton(
          label: 'Proceed',
          onTap: () => _showRechargeModal(context),
        ),
      ),
    );
  }

  Widget _mapButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: RcColors.g2, width: 1.5),
      ),
      child: Text(
        'Maps ↗',
        style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: RcColors.g8),
      ),
    );
  }
}