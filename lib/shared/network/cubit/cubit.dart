import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/shared/extensions/cubit_extension.dart';



import '../../local/user_helper.dart';
import 'state.dart';

class NetworkCubit extends Cubit<NetworkStates> {
  NetworkCubit() : super(NoErrorState());

  static NetworkCubit get(BuildContext context) => BlocProvider.of(context);

  Future<Map<String, dynamic>> onRequestCallback() async {
    String? userAccessToken = await UserHelper.getUserToken();
    return {
      if (userAccessToken != null) 'Authorization': 'Bearer $userAccessToken',
      'mobile_version': '1.0.1',
    };
  }

  Future<void> onErrorCallback(DioError error) async {
    final response = error.response;
    if (response != null) {
      if ((response.statusCode == 500 &&
          response.data['error_msg'].toString().contains('Unauthenticated') || response.statusCode == 401)) {
        safeEmit(
          UnauthenticatedState(
            "قد تم تسجيل خروجك تلقائيًا من فضلك قم بتسجبل دخولك.",
          ),
        );
      } else {
        safeEmit(
          ErrorState(
            response.data['message'] ?? "حدث خطأ ما من فضلك حاول مرة اخرى",
          ),
        );
      }
    }
  }
}
