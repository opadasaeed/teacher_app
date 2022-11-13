import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/cache_helper.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/theme/cubit/states.dart';


class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(InitialThemeState());

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  bool? isDark;
  bool showQr = false;

  ThemeMode currentTheme() {
    if (isDark != null) {
      return isDark! ? ThemeMode.dark : ThemeMode.light;
    } else {
      return ThemeMode.light;
    }
  }

  getCurrentTheme() async {
    await di<CacheHelper>().has("theme").then((hasToken) async {
      if (hasToken) {
        await di<CacheHelper>().get("theme").then((value) async {
          isDark = value;
        });
      } else {
        isDark = false;
      }
    });
    emit(ChangeState());
  }

  void switchTheme() async {
    isDark = !isDark!;
    await di<CacheHelper>().put("theme", isDark);
    emit(ChangeState());
  }

  Future<void> changlang(context, String code) async {
    await UserHelper.putAppLanguage(code);
    changeLocale(context, code);
  }

  void showQrTopSheet(bool value) {
    showQr = value;
    emit(ChangeState());
  }

  void secureApp() async {
    if (Platform.isAndroid)
      if(!kDebugMode)
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  // void initSensors() {
  //   try {
  //     accelerometerEvents.listen((AccelerometerEvent event) async {
  //       if (event.y < -1 && showQr == false) {
  //         showQrTopSheet(true);
  //       }
  //       if (event.y > -1 && showQr == true) {
  //         showQrTopSheet(false);
  //       }
  //     });
  //   } catch (ex) {
  //     print(ex.toString());
  //   }
  // }
}
