import 'dart:async';

import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/user_helper_keys.dart';

import 'cache_helper.dart';

abstract class UserHelper {
  static Future<String?> getUserToken() async {
    return await (di<CacheHelper>().get(UserHelperKeys.USER_ACCESS_TOKEN_KEY));
  }

  static Future<bool> putUserToken(String? userAccessToken) {
    return di<CacheHelper>()
        .put(UserHelperKeys.USER_ACCESS_TOKEN_KEY, userAccessToken);
  }

  static Future<bool> clearUserToken() {
    return di<CacheHelper>().clear(UserHelperKeys.USER_ACCESS_TOKEN_KEY);
  }

  static Future<bool?> getIsOnBoarding() async {
    return await (di<CacheHelper>().get(UserHelperKeys.isOnBoarding));
  }

  static Future<bool> putIsOnBoarding(bool boolean) {
    return di<CacheHelper>().put(UserHelperKeys.isOnBoarding, boolean);
  }

  static Future<String?> getAppLanguage() async {
    return await (di<CacheHelper>().get(UserHelperKeys.appLanguage));
  }

  static Future<bool> putAppLanguage(String code) {
    return di<CacheHelper>().put(UserHelperKeys.appLanguage, code);
  }

  static Future getUserModel() async {
    return await di<CacheHelper>().get(UserHelperKeys.userModel);
  }

  static Future<bool> putUserModel(dynamic model) {
    return di<CacheHelper>().put(UserHelperKeys.userModel, model);
  }
static Future getUserId() async {
    return await di<CacheHelper>().get(UserHelperKeys.userId);
  }

  static Future<bool> putUserId(String? id) {
    return di<CacheHelper>().put(UserHelperKeys.userId, id);
  }
  static Future getWallet() async {
    return await di<CacheHelper>().get(UserHelperKeys.wallet);
  }

  static Future<bool> putWallet(String? wallet) {
    return di<CacheHelper>().put(UserHelperKeys.wallet, wallet);
  }

  static Future getShowCases() async {
    return await di<CacheHelper>().get(UserHelperKeys.showCases);
  }

  static Future<bool> putShowCases(bool isShowCases) {
    return di<CacheHelper>().put(UserHelperKeys.showCases, isShowCases);
  }
}
