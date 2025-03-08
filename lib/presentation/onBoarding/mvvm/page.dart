import 'package:flutter/material.dart';
import 'package:islamy/presentation/onBoarding/mvvm/model.dart';

class OnBoardingPage extends StatelessWidget {
  final OnBoardingModel model;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onButtonPressed;

  const OnBoardingPage({
    Key? key,
    required this.model,
    required this.currentIndex,
    required this.totalPages,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          _buildImage(),
          SizedBox(height: 20),
          _buildTitle(context),
          SizedBox(height: 10),
          _buildDescription(context),
          Spacer(),
          _buildNavigationRow(),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
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
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      model.title,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        model.description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildNavigationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xFF025B56),
            onPressed: onButtonPressed,
            child: Icon(
                currentIndex == totalPages - 1
                    ? Icons.check
                    : Icons.arrow_back
            ),
          ),
          Row(
            children: [
              _buildDot(currentIndex == 2),
              _buildDot(currentIndex == 1),
              _buildDot(currentIndex == 0),
            ],
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
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