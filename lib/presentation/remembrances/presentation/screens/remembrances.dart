import 'package:flutter/material.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/remembrances/presentation/widgets/remembrances_element.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/status_builder.dart';
import '../../data/data_source.dart';
import '../provider/provider.dart';
import '../widgets/remembrances_card_type.dart';

class Remembrances extends StatelessWidget {

  final RemembrancesType type;
  const Remembrances({super.key,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // appBar: CustomAppBar(title: ),
      body: ChangeNotifierProvider(
          create: (context) => RemembrancesProvider()..getRemembrances(type),
          child: RemembrancesBody(type: type)
      ),
    );
  }
}

class RemembrancesBody extends StatelessWidget {
  final RemembrancesType type;
  const RemembrancesBody({super.key,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RemembrancesProvider>(
        builder: (context, value, child) => StatusBuilder(
          status: value.baseStatus,
          placeHolder: '  ',
          builder: (placeHolder, isLoading) => isLoading? CustomLoading.showLoadingView() :
          ListView.separated(
            itemBuilder: (context, index) => RemembrancesElement(
                remembrancesText: value.remembrances[index]
            ),
            separatorBuilder: (context, index) => 12.szH,
            itemCount: value.remembrances.length,
          ),
        ).defaultAppScreenPadding(),
    );
  }
}
