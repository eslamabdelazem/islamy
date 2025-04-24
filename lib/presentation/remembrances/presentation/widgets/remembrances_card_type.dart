import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/app_text.dart';

class RemembrancesCard extends StatelessWidget {

  final String type;
  const RemembrancesCard({super.key,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Row(
        children: [
          AppText(type),
          const Spacer(),
          const Icon(Icons.arrow_forward)
        ],
      ).paddingAll(12),
    );
  }
}
