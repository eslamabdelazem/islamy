import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/remembrances/presentation/screens/remembrances.dart';
import '../../../fav/screens/fav_screen.dart';
import '../../data/data_source.dart';
import '../widgets/remembrances_card_type.dart';

class ChooseRemembrancesType extends StatelessWidget {
  const ChooseRemembrancesType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Remembrances.tr(),
        actions: [
          IconButton(
              onPressed: () => Go.to(const FavScreen()),
              icon: const Icon(Icons.favorite_border)
          )
        ],
      ),
      body: _ChooseRemembrancesTypeBody(),
    );
  }
}

class _ChooseRemembrancesTypeBody extends StatelessWidget {

  _ChooseRemembrancesTypeBody({super.key});

  final List<String> remembrancesTypes = RemembrancesType.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
          remembrancesTypes.length,
              (index) => InkWell(
                  onTap: () => Go.to(Remembrances(type: RemembrancesType.values[index])),
                  child: RemembrancesCard(type: remembrancesTypes[index].tr())
              )
      ),
    );
  }
}