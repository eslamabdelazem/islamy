import 'package:flutter/material.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/core/widgets/exeption_view.dart';

enum ProviderStateBuilderLoadingStyle {defaultLoading, customLoading}
class ProviderStateBuilder<T> extends StatelessWidget {

  final ProviderStateBuilderLoadingStyle style;
  final AsyncSnapshot<T> snapshot;
  final Widget Function(bool isLoading)? builderWithCustomLoading;
  final Widget Function()? builder;

  const ProviderStateBuilder({super.key,
    required this.snapshot,
    required this.builderWithCustomLoading,
    required this.builder,
    required this.style,
  });

  const ProviderStateBuilder.customLoading({super.key,
    required this.snapshot,
    required this.builderWithCustomLoading,
  }) : style = ProviderStateBuilderLoadingStyle.customLoading, builder = null;

  const ProviderStateBuilder.defaultLoading({super.key,
    required this.snapshot,
    required this.builder,
  }) : builderWithCustomLoading = null, style = ProviderStateBuilderLoadingStyle.defaultLoading;

  Widget _buildLoadingView(){
    switch(style){
      case ProviderStateBuilderLoadingStyle.defaultLoading:
        return CustomLoading.showLoadingView();

      case ProviderStateBuilderLoadingStyle.customLoading:
        return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting);
    }
  }

  Widget _buildSuccessView(){
    switch(style){
      case ProviderStateBuilderLoadingStyle.defaultLoading:
        return builder!();

      case ProviderStateBuilderLoadingStyle.customLoading:
        return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting);
    }
  }

  @override
  Widget build(BuildContext context) {
    return snapshot.hasError || snapshot.connectionState == ConnectionState.none? const ExceptionView() :
        snapshot.connectionState == ConnectionState.waiting? _buildLoadingView() : _buildSuccessView();
  }

  // @override
  // Widget build(BuildContext context) {
  //   if(snapshot.hasError){
  //     return const ExceptionView();
  //   }
  //   else if(snapshot.hasData){
  //     switch(style){
  //       case ProviderStateBuilderLoadingStyle.defaultLoading:
  //         return builder!();
  //
  //       case ProviderStateBuilderLoadingStyle.customLoading:
  //         return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting);
  //     }
  //   } else {
  //     switch(snapshot.connectionState){
  //       case ConnectionState.none:
  //         return const ExceptionView();
  //
  //       case ConnectionState.waiting:
  //         switch(style){
  //           case ProviderStateBuilderLoadingStyle.defaultLoading:
  //             return CustomLoading.showLoadingView();
  //
  //           case ProviderStateBuilderLoadingStyle.customLoading:
  //             return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting);
  //         }
  //
  //       case ConnectionState.active:
  //       case ConnectionState.done:
  //         switch(style){
  //           case ProviderStateBuilderLoadingStyle.defaultLoading:
  //             return builder!();
  //
  //           case ProviderStateBuilderLoadingStyle.customLoading:
  //             return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting);
  //         }
  //
  //     }
  //   }
  //
  // }
}