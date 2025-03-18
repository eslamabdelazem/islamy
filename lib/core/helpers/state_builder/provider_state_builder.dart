import 'package:flutter/material.dart';
import 'package:islamy/core/helpers/state_builder/status.dart';
import 'package:islamy/core/widgets/exeption_view.dart';


class ProviderStateBuilder extends StatelessWidget {

  final Status currentState;
  final Widget Function(bool isLoading) builder;
  const ProviderStateBuilder({super.key,
    this.currentState = Status.initial,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return currentState.when<Widget>(
      onSuccess: () => builder(currentState == Status.loading),
      onError: () => const ExceptionView(),
    );
  }
}