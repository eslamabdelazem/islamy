import 'package:flutter/material.dart';
import 'package:islamy/presentation/resources/color_manager.dart';
import 'package:islamy/presentation/resources/styles_manager.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageControler = PageController();
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
  void dispose() {
  _pageControler.dispose();
    super.dispose();
  }
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child:
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              model.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ),
          SizedBox(height: 20),
          Text(
            model.title,
            style: getSemiBoldStyle(color: ColorManager.blueTeal22),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              model.description,
              textAlign: TextAlign.center,
              style: getRegularStyle(color: ColorManager.blueTeal222),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Color(0xFF025B56),
                  onPressed: () {},
                  child: Icon(Icons.arrow_back_ios),
                ),
                Row(
                  children: [
                    buildDot(true),
                    buildDot(false),
                    buildDot(false),
                  ],
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF025B56) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}