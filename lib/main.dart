import 'package:bloc/bloc.dart';
import 'package:fitness/modules/home_screen/home_screen.dart';
import 'package:fitness/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:fitness/modules/onboarding_screen/onboarding_screen.dart';
import 'package:fitness/shared/bloc_observer.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isBoarding = CacheHelper.getData(key: 'onBoarding');
  late Widget widget;
  if(isBoarding != null){
    widget = HomeScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MainApp(widget));
}

class MainApp extends StatelessWidget {
  final Widget widget;
  MainApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF192A56),
        ),
      ),
      home: widget,
      builder: (context, widget) => ResponsiveWrapper.builder(
        widget,
        maxWidth: 2460,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
    );
  }
}
