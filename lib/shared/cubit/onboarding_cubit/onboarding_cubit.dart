import 'package:fitness/modules/home_screen/home_screen.dart';
import 'package:fitness/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:fitness/shared/cubit/onboarding_cubit/onboarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
    );
  }

  var screens = [
    PageViewModel(
      title: "Welcome to \"Fitness\"",
      body:
          "Keep fit and flexible from home, Exercises will make you on top. Use \"Fitness\" daily to see the result.",
      image: Center(
        child: Image.asset("assets/screen1.png", height: 175.0),
      ),
      decoration: const PageDecoration(
        pageColor: Color(0xFF192A56),
        titleTextStyle: TextStyle(
          color: Colors.orange,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        bodyTextStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
      ),
    ),
    PageViewModel(
      title: "What is the \"Bodybuilding\"?",
      body:
          "Bodybuilding is much like any other sport. To be successful, you must dedicate yourself 100% to your training, diet and mental approach.",
      image: Center(
        child: Image.asset("assets/screen2.png", height: 175.0),
      ),
      decoration: const PageDecoration(
        pageColor: Color(0xFF192A56),
        titleTextStyle: TextStyle(
          color: Colors.orange,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        bodyTextStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
      ),
    ),
    PageViewModel(
      title: "Let's go to the first training...",
      body:
          "Share \"Fitness\" app with your family and friends.",
      image: Center(
        child: Image.asset("assets/screen3.png", height: 175.0),
      ),
      decoration: const PageDecoration(
        pageColor: Color(0xFF192A56),
        titleTextStyle: TextStyle(
          color: Colors.orange,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        bodyTextStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
      ),
    ),
  ];
}
