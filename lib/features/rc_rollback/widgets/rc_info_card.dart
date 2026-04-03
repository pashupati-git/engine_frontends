
import 'package:engine_frontends/features/rc_rollback/rc_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ─────────────────────────────────────────
// INFO CARD CONTAINER
// ─────────────────────────────────────────
class RcInfoCard extends StatelessWidget {
  final List<Widget> children;
  const RcInfoCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RcColors.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: RcColors.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(children: children),
      ),
    );
  }
}