import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:engine_frontends/features/rc_rollback/screens/rc_customer_details_screen.dart';
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
  final _wire150Ctrl = TextEditingController(text: '100');

  String? _uploadedFileName;
  bool _signatureCaptured = false;

  //Gps from location plugin - populate via Geolocator in real implementation
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
    //TODO: integrate a signature pad widget (e.g. hand_signature package)
    setState(() => _signatureCaptured = true);
  }

  void _submit() {
    if (_uninstallReason == null || _detailReason == null || _nextIsp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields.',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: RcColors.red,
        ),
      );
      return;
    }
    //TODO: submit rollback via API
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text('Rollback Submitted', style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const RcCustomerDetailsScreen(),
                ),
                (r) => false,
              );
            },
            child: Text(
              'OK',
              style: GoogleFonts.plusJakartaSans(
                color: RcColors.g8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Rollback Screen.')));
  }
}
