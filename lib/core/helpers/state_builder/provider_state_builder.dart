import 'package:flutter/material.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/core/widgets/exeption_view.dart';
enum ProviderStateBuilderLoadingStyle {defaultLoading, customLoading}
class ProviderStateBuilder<T> extends StatelessWidget {

  final ProviderStateBuilderLoadingStyle style;
  final Future<T> Function() asyncCall;
  final Widget Function(bool isLoading, AsyncSnapshot snapshot)? builderWithCustomLoading;
  final Widget Function(AsyncSnapshot snapshot)? builder;

  const ProviderStateBuilder({super.key,
    required this.builderWithCustomLoading,
    required this.asyncCall,
    required this.builder,
    required this.style,
  });

  const ProviderStateBuilder.customLoading({super.key,
    required this.asyncCall,
    required this.builderWithCustomLoading,
  }) : style = ProviderStateBuilderLoadingStyle.customLoading, builder = null;

  const ProviderStateBuilder.defaultLoading({super.key,
    required this.asyncCall,
    required this.builder,
  }) : builderWithCustomLoading = null, style = ProviderStateBuilderLoadingStyle.defaultLoading;

  Widget _buildLoadingView(AsyncSnapshot snapshot){
    switch(style){
      case ProviderStateBuilderLoadingStyle.defaultLoading:
        return CustomLoading.showLoadingView();

      case ProviderStateBuilderLoadingStyle.customLoading:
        return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting, snapshot);
    }
  }

  Widget _buildSuccessView(AsyncSnapshot snapshot){
    switch(style){
      case ProviderStateBuilderLoadingStyle.defaultLoading:
        return builder!(snapshot);

      case ProviderStateBuilderLoadingStyle.customLoading:
        return builderWithCustomLoading!(snapshot.connectionState == ConnectionState.waiting, snapshot);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asyncCall(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.none? const ExceptionView() :
          snapshot.hasError? const ExceptionView():
            snapshot.connectionState == ConnectionState.waiting?
            _buildLoadingView(snapshot) : _buildSuccessView(snapshot),
    );
  }
}