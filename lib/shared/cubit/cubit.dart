import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/shared/cubit/states.dart';

class SharedCubit extends Cubit<SharedStates> {
  // LoginModel loginModel = LoginModel();
  // bool isLogin = false;
  //
  // int notificationCount = 0;
  // int notificationChatCount = 0;
  //
  SharedCubit() : super(InitialSharedState());

  static SharedCubit get(BuildContext context) => BlocProvider.of(context);
  // Future<void> secureScreen() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //   emit(SuccessSharedState());
  // }

//
  // SharedStates get initialState => InitialSharedState();
  //
  // getNotificationCount() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>()
  //       .has('notificationCount')
  //       .then((hasNotificationCount) async {
  //     if (hasNotificationCount) {
  //       await di<CacheHelper>().get('notificationCount').then((value) async {
  //         notificationCount = value;
  //       });
  //     } else {
  //       di<CacheHelper>().put('notificationCount', 0);
  //     }
  //   });
  //   await di<CacheHelper>()
  //       .has('notificationChatCount')
  //       .then((hasNotificationChatCount) async {
  //     if (hasNotificationChatCount) {
  //       await di<CacheHelper>()
  //           .get('notificationChatCount')
  //           .then((value) async {
  //         notificationChatCount = value;
  //       });
  //     } else {
  //       di<CacheHelper>().put('notificationChatCount', 0);
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // increaseNotificationCount() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>()
  //       .has('notificationCount')
  //       .then((hasNotificationCount) async {
  //     if (hasNotificationCount) {
  //       await di<CacheHelper>().get('notificationCount').then((value) async {
  //         di<CacheHelper>().put('notificationCount', value + 1);
  //       });
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // increaseNotificationChatCount() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>()
  //       .has('notificationChatCount')
  //       .then((notificationChatCount) async {
  //     if (notificationChatCount) {
  //       await di<CacheHelper>()
  //           .get('notificationChatCount')
  //           .then((value) async {
  //         di<CacheHelper>().put('notificationChatCount', value + 1);
  //       });
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // clearNotificationCount() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>()
  //       .has('notificationCount')
  //       .then((hasNotificationCount) async {
  //     if (hasNotificationCount) {
  //       await di<CacheHelper>().get('notificationCount').then((value) async {
  //         di<CacheHelper>().put('notificationCount', 0);
  //         notificationCount = 0;
  //         print('Clear notificationCount DONE');
  //       });
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // clearNotificationChatCount() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>()
  //       .has('NotificationChatCount')
  //       .then((hasNotificationCount) async {
  //     if (hasNotificationCount) {
  //       await di<CacheHelper>()
  //           .get('NotificationChatCount')
  //           .then((value) async {
  //         di<CacheHelper>().put('NotificationChatCount', 0);
  //         notificationCount = 0;
  //         print('Clear NotificationChatCount DONE');
  //       });
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // getUser() async {
  //   emit(LoadingSharedState());
  //   await di<CacheHelper>().has('userData').then((user) async {
  //     if (user) {
  //       isLogin = true;
  //       await di<CacheHelper>().get('userData').then((value) async {
  //         loginModel = LoginModel.fromJson(value);
  //       });
  //     }
  //   });
  //   emit(SuccessUserSharedState());
  // }
  //
  // logout() async {
  //   print("Captain Logout");
  //   await FirebaseMessaging.instance.deleteToken();
  //   di<CacheHelper>().clear('userData');
  //   di<CacheHelper>().clear('accessToken');
  //   di<CacheHelper>().clear('notificationCount');
  //   // clear user access token after logout
  //   di<CacheHelper>().clear(UserHelperKeys.USER_ACCESS_TOKEN_KEY);
  //   if(Platform.isAndroid)CallLogChannel.logoutCaptain();
  // }
}