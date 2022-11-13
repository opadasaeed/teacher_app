import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:teacher_app/shared/cubit/cubit.dart';
import 'package:teacher_app/shared/cubit/states.dart';
import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/cubit/cubit.dart';
import 'package:teacher_app/shared/network/cubit/state.dart';
import 'package:teacher_app/shared/network/remote/api_endpoints.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';

import 'layout/splash/splash_screen.dart';

import 'modules/homeFeed/cubit/cubit.dart';
import 'modules/login/login_screen.dart';

import 'shared/theme/cubit/states.dart';
import 'shared/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  var langCode = await UserHelper.getAppLanguage();
  if (!Platform.isWindows) {

  }
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'ar',
      supportedLocales: [
        'en',
        'ar',
      ]);
  delegate.changeLocale(Locale(langCode ?? 'ar'));
  await SentryFlutter.init((options) {
    options.dsn = EndPoints.sentryToken;
  }, appRunner: () async {
    runApp(
      LocalizedApp(
        delegate,
        const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myBackgroundMessageHandler(context);

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(
          create: (BuildContext context) => di<NetworkCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => di<SharedCubit>(),
        ),
        BlocProvider(
          create: (context) => di<HomeFeedScreenCubit>() /* ..getHomeFeed() */,
        ),


        BlocProvider(
          create: (BuildContext context) => di<ThemeCubit>()
            ..getCurrentTheme()
            ..secureApp(),
        ),
      ],
      child: BlocListener<NetworkCubit, NetworkStates>(
        listenWhen: (previous, current) => previous != current,
        listener: (BuildContext context, NetworkStates state) {
          switch (state.runtimeType) {
            case UnauthenticatedState:
              // SharedCubit.get(context).logout();//toDo
              navigateAndFinish(
                  context: navigatorKey.currentContext!, route: LoginScreen());
              return;
            default:
          }
        },
        child: BlocConsumer<ThemeCubit, ThemeStates>(
          listener: (BuildContext themeContext, state) {},
          builder: (BuildContext themeContext, state) {
            return BlocConsumer<SharedCubit, SharedStates>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                return LocalizationProvider(
                  state: LocalizationProvider.of(context).state,
                  child: MaterialApp(
                    navigatorKey: navigatorKey,
                    home: SplashScreen(),
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeCubit.get(themeContext).currentTheme(),
                    theme: CustomTheme.lightTheme,
                    darkTheme: CustomTheme.dartTheme,
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      localizationDelegate
                    ],
                    supportedLocales: localizationDelegate.supportedLocales,
                    locale: localizationDelegate.currentLocale,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
