import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/layout/home/cubit/states.dart';
import 'package:teacher_app/modules/login/login_screen.dart';
import 'package:teacher_app/shared/components/loading_dialog.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();
  final Repository? repository;
  Widget currentWidget = LoginScreen();
  int currentIndex = 0;

  HomeLayoutCubit(this.repository) : super(InitialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  changeDrawer({required Widget widget}) {
    emit(LoadingHomeLayoutState());
    currentWidget = widget;
    emit(SuccessHomeLayoutState());
  }

  changeIndex({required int index}) {
    currentIndex = index;
    emit(SuccessHomeLayoutState());
  }

  logOut(context) async {
    LoadingDialog().show();

    bool clear = await UserHelper.clearUserToken();
    if (clear) {
      showToast(msg: 'Loged Out ');
      navigateAndFinish(context: context, route: LoginScreen());
    }
  }

  getVersion() async {
    final f = await repository!.getVersion();
    f.fold(
      (l) async {
        print('Response Error => $l');
      },
      (r) async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String versionName = packageInfo.version;
        if (r.success == true) {
          debugPrint('Ios Min Version ==> ' + r.data!.latestIosVersion!.toString());
          debugPrint('Android Min Version ==> ' + r.data!.latestAndroidVersion!.toString());
          debugPrint('Current Version ==> ' + versionName);
          if (Platform.isAndroid) {
            if (needUpdate(versionName, r.data!.latestAndroidVersion!))
              emit(NeedUpdate());
          }
          if (Platform.isIOS) {
            if (needUpdate(versionName, r.data!.latestIosVersion!))
              emit(NeedUpdate());
          }

        }
      },
    );
  }

  checkDevMode() async {
    bool result = await initPlatformState();
    if (result == true) {
      emit(DevModeEnabledState());
    }
  }

  init(context) {
    UserHelper.getShowCases().then((value) {
      if (value == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            ShowCaseWidget.of(context).startShowCase([one, two, three, four]));
      }
    });
  }
}
