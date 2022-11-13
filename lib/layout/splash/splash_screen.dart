import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teacher_app/layout/home/home_layout.dart';
import 'package:teacher_app/modules/login/login_screen.dart';
import 'package:teacher_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 3500), () async {
      String? userAccessToken = await UserHelper.getUserToken();
      bool? isOnBoarding = await UserHelper.getIsOnBoarding();
      // print(isOnBoarding);
      setState(() {
        // if (SharedCubit.get(context).isLogin) {
        //   navigateAndFinish(HomeLayout(), context);
        // } else {
        //   navigateAndFinish(LoginScreen(), context);
        // }
        if (isOnBoarding == null) {
          navigateAndFinish(context: context, route: OnBoardingScreen());
        } else if (userAccessToken != null) {
          navigateAndFinish(
              context: context,
              route: ShowCaseWidget(
                onFinish: () async => await UserHelper.putShowCases(true),
                builder: Builder(builder: (context) => HomeLayout()),
              ));
        } else {
          navigateAndFinish(context: context, route: LoginScreen());
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Lottie.asset(
        'assets/animations/splash_screen.json',
      ),
    );
  }
}
