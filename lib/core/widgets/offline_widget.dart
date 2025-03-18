import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'internet_exeption.dart';

class OfflineWidget extends StatefulWidget {
  final Widget child;
  const OfflineWidget({super.key, required this.child});

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget> {
  bool connected = false;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget item,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            item,
            if (!connected) const InternetExpetion(),
          ],
        );
      },
      builder: (BuildContext context) {
        return widget.child;
      },
      errorBuilder: (BuildContext context) => const InternetExpetion(),
      // child: const SizedBox.shrink(),
    );
  }
}
