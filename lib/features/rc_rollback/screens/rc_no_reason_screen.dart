import 'package:flutter/material.dart';

class RcNoReasonScreen extends StatefulWidget {
  const RcNoReasonScreen({super.key});

  @override
  State<RcNoReasonScreen> createState() => _RcNoReasonScreenState();
}

class _RcNoReasonScreenState extends State<RcNoReasonScreen> {
  final _notesController = TextEditingController();
  final _remarksController=TextEditingController();
  DateTime? _revisitDate;


  //toggle states - wire to Bloc/Provider later
  final Map<String,bool> _toggles={
    'offer':false,
    'escalate':false,
    'partial':false,
    'churned':false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('No Reason Screen.')));
  }
}
