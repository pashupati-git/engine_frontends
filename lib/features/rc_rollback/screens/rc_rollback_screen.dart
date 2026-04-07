import 'package:flutter/material.dart';

class RcRollbackScreen extends StatefulWidget {
  const RcRollbackScreen({super.key});

  @override
  State<RcRollbackScreen> createState() => _RcRollbackScreenState();
}

class _RcRollbackScreenState extends State<RcRollbackScreen> {
  String? _uninstallReason;
  String? _detailReason;
  String? _nextIsp;


  final _onuSerialCtrl=TextEditingController(text:'NBELFBBA2FE2');
  final _onuQtyCtrl=TextEditingController(text:'1');
  final _depositCtrl=TextEditingController(text:'500');
  final _wire100Ctrl=TextEditingController(text:'100');
  final _wire150Ctrl=TextEditingController(text:'100');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Rollback Screen.')),
    );
  }
}