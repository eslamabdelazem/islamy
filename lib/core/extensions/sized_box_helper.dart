import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxHelper on num {
  SizedBox get szH => SizedBox(height: toDouble().h);

  SizedBox get szW => SizedBox(width: toDouble().w);
}