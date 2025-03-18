import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullScreenLoadingManager extends StatefulWidget {
  final Widget child;
  const FullScreenLoadingManager({super.key, required this.child});

  @override
  State<FullScreenLoadingManager> createState() =>
      _FullScreenLoadingManagerState();

  static void show() {
    _FullScreenLoadingManagerState._isLoading.value = true;
  }

  static void hide() {
    _FullScreenLoadingManagerState._isLoading.value = false;
  }
}

class _FullScreenLoadingManagerState extends State<FullScreenLoadingManager> {
  static final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        widget.child,
        ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (context, value, child) {
              return Visibility(
                  visible: _isLoading.value,
                  child: Container(
                      height: 1.sh,
                      width: 1.sw,
                      color: Colors.grey.withValues(alpha: 0.3),
                      child: Center(
                          child: CupertinoActivityIndicator(radius: 15.sp))));
            }),
      ],
    );
  }
}
