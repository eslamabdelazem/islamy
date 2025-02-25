import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/presentation/resources/color_manager.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';

class OnBoardingView extends StatefulWidget {
  OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageControler = PageController();
  int _pageIndex = 0;
  List<Model> model = [
    Model(
        image: ImageAssets.onBoardingLogo1,
        title: AppStrings.onBoardingTitle1,
        description: AppStrings.onBoardingSubTitle1),
    Model(
        image: ImageAssets.onBoardingLogo2,
        title: AppStrings.onBoardingTitle2,
        description: AppStrings.onBoardingSubTitle2),
    Model(
        image: ImageAssets.onBoardingLogo3,
        title: AppStrings.onBoardingTitle3,
        description: AppStrings.onBoardingSubTitle3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: PageView.builder(
          itemBuilder: (context, index) {
            return PageViewMethod(model[index]);
          },
          itemCount: model.length,
          onPageChanged: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
        ));
  }
}

class Model {
  String image;
  String title;
  String description;
  Model({required this.image, required this.title, required this.description});
}

class PageViewMethod extends StatelessWidget {
  Model model;
  PageViewMethod(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 375.w,
            height: 481.h,
            child: Image.asset(
              model.image,
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            Text(
              "scholar",
              style: TextStyle(color: ColorManager.blueTeal22,fontSize: 32,fontWeight: FontWeight.bold),
            ),
            Text(
              model.description,
              style: getRegularStyle(
                  color: ColorManager.blueTeal222, fontSize: FontSize.s24),
            ),
          ],
        ),

      ],
    );
  }
}
