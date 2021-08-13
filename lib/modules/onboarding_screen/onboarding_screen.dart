import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:fitness/shared/cubit/onboarding_cubit/onboarding_cubit.dart';
import 'package:fitness/shared/cubit/onboarding_cubit/onboarding_states.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var OBcubit = OnBoardingCubit.get(context);
          return Scaffold(
            body: IntroductionScreen(
              pages: OBcubit.screens,
              onDone: () {
                OBcubit.submit(context);
              },
              onSkip: () {
                OBcubit.submit(context);
              },
              showSkipButton: true,
              skip: const Icon(Icons.skip_next),
              next: const Icon(Icons.arrow_forward_ios),
              done: const Text(
                "Done",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
              skipColor: Colors.white,
              nextColor: Colors.white,
              doneColor: Colors.orange,
              globalBackgroundColor: const Color(0xFF192A56),
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Colors.orange,
                color: Colors.white,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
