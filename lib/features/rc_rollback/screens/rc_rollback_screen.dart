
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/screens/rc_customer_details_screen.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_button_style.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_drop_down.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_form_label.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_section_label.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_text_field.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_top_bar.dart';
import 'package:engine_frontends/features/rc_rollback/widgets/rc_upload_zone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';




class RcRollbackScreen extends StatefulWidget {
  const RcRollbackScreen({super.key});

  @override
  State<RcRollbackScreen> createState() => _RcRollbackScreenState();
}

class _RcRollbackScreenState extends State<RcRollbackScreen> {
  String? _uninstallReason;
  String? _detailReason;
  String? _nextIsp;

  final _onuSerialCtrl = TextEditingController(text: 'NBELFBBA2FE2');
  final _onuQtyCtrl = TextEditingController(text: '1');
  final _depositCtrl = TextEditingController(text: '500');
  final _wire100Ctrl = TextEditingController(text: '100');
  final _wire150Ctrl = TextEditingController(text: '150');

  String? _uploadedFileName;
  bool _signatureCaptured = false;

  // GPS from location plugin — populate via Geolocator in real implementation
  final String _clientGps = '27.6822271724521186, 85.32817073529863';

  @override
  void dispose() {
    _onuSerialCtrl.dispose();
    _onuQtyCtrl.dispose();
    _depositCtrl.dispose();
    _wire100Ctrl.dispose();
    _wire150Ctrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => _uploadedFileName = img.name);
    }
  }

  void _captureSignature() {
    // TODO: integrate a signature pad widget (e.g. hand_signature package)
    setState(() => _signatureCaptured = true);
  }

  void _submit() {
    if (_uninstallReason == null || _detailReason == null || _nextIsp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields.',
              style: GoogleFonts.plusJakartaSans()),
          backgroundColor: RcColors.red,
        ),
      );
      return;
    }
    // TODO: submit rollback via API
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Rollback Submitted',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800)),
        content: Text(
            'Equipment recovery ticket created successfully.',
            style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => const RcCustomerDetailsScreen()),
                (r) => false,
              );
            },
            child: Text('OK',
                style: GoogleFonts.plusJakartaSans(
                    color: RcColors.g8, fontWeight: FontWeight.w700)),
          ),
        ],
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
              child: RcTopBar(title: 'RC Rollback'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 40.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GPS
                  RcFormLabel('Client GPS', required: true),
                  RcTextField(initialValue: _clientGps, readOnly: true),
                  SizedBox(height: 14.h),

                  // Reason for uninstallation
                  RcFormLabel('Reason for Uninstallation', required: true),
                  RcDropdown(
                    items: rcUninstallReasons,
                    value: _uninstallReason,
                    hint: 'Select Item',
                    onChanged: (v) =>
                        setState(() => _uninstallReason = v),
                  ),
                  SizedBox(height: 14.h),

                  // Detail reason
                  RcFormLabel('Detail Uninstallation Reason',
                      required: true),
                  RcDropdown(
                    items: rcDetailReasons,
                    value: _detailReason,
                    hint: 'Select Item',
                    onChanged: (v) => setState(() => _detailReason = v),
                  ),
                  SizedBox(height: 14.h),

                  // Switching to next ISP
                  RcFormLabel('Switching to Next ISP', required: true),
                  RcDropdown(
                    items: rcNextIsps,
                    value: _nextIsp,
                    hint: 'Select Item',
                    onChanged: (v) => setState(() => _nextIsp = v),
                  ),
                  SizedBox(height: 16.h),

                  // Equipment Recovery header
                  RcSectionLabel('Equipment Recovery'),

                  // ONU row
                  RcFormLabel('ONU – Single Band Nokia', required: true),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: RcColors.card,
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: RcColors.line, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Text('Sl.No:',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.sp,
                                      color: RcColors.mid,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: TextFormField(
                                  controller: _onuSerialCtrl,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 90.w,
                        child: TextFormField(
                          controller: _onuQtyCtrl,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp, fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            hintText: 'Qty',
                            hintStyle: GoogleFonts.plusJakartaSans(
                                color: RcColors.soft),
                            contentPadding: EdgeInsets.all(12.w),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: RcColors.line, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: RcColors.line, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  BorderSide(color: RcColors.g8, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // ONU Deposit
                  RcFormLabel('ONU Deposit', required: true),
                  _PrefixField(
                    prefix: 'Rs',
                    controller: _depositCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 14.h),

                  // Drop wire 100m
                  RcFormLabel('DROP WIRE – 100 MTR', required: true),
                  _QtyField(
                    label: 'Qty:',
                    controller: _wire100Ctrl,
                  ),
                  SizedBox(height: 14.h),

                  // Drop wire 150m
                  RcFormLabel('DROP WIRE – 150 MTR', required: true),
                  _QtyField(
                    label: 'Qty:',
                    controller: _wire150Ctrl,
                  ),
                  SizedBox(height: 14.h),

                  // Upload form image
                  RcFormLabel('Upload Uninstallation Form Image',
                      required: true),
                  RcUploadZone(
                    onTap: _pickImage,
                    fileName: _uploadedFileName,
                  ),
                  SizedBox(height: 14.h),

                  // Signature
                  RcFormLabel('Customer Signature', required: true),
                  GestureDetector(
                    onTap: _captureSignature,
                    child: Container(
                      height: 90.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: RcColors.bg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: _signatureCaptured
                                ? RcColors.g8
                                : RcColors.line,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              _signatureCaptured ? '✅' : '✍️',
                              style: TextStyle(fontSize: 22.sp)),
                          SizedBox(height: 4.h),
                          Text(
                            _signatureCaptured
                                ? 'Signature Captured'
                                : 'Tap to capture signature',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                color: _signatureCaptured
                                    ? RcColors.g8
                                    : RcColors.mid,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  RcButton(
                    label: 'Submit Rollback ✓',
                    onTap: _submit,
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

class _PrefixField extends StatelessWidget {
  final String prefix;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _PrefixField({
    required this.prefix,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: RcColors.line, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: RcColors.bg,
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(7.r)),
              border: Border(
                  right: BorderSide(color: RcColors.line, width: 1.5)),
            ),
            child: Text(prefix,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: RcColors.mid)),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp, color: RcColors.ink),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _QtyField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: RcColors.line, width: 1.5),
      ),
      child: Row(
        children: [
          Text(label,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: RcColors.mid)),
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: RcColors.ink),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}