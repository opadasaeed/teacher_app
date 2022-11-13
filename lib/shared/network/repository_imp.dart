import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teacher_app/shared/network/remote/api_endpoints.dart';
import 'package:teacher_app/shared/network/remote/dio/dio_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';

import '../../layout/home/model/app_version_model.dart';
import '../../modules/forgotPassword/models/forget_password_model.dart';
import '../../modules/homeFeed/model/home_model.dart';
import '../../modules/login/models/login_model.dart';
import '../../modules/profile/model/profile_model.dart';
import '../../modules/signUp/models/sign_up_model.dart';
import '../components/toasts.dart';

class RepoImpl extends Repository {
  final DioHelper? dioHelper;

  RepoImpl({
    required this.dioHelper,
  }) {
    // if we want to cache
  }

  @override
  Future<Either<String, LoginModel>> login({
    String? email,
    String? password,
  }) async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final f = await dioHelper!.postMultiPart(
          EndPoints.loginEndPoint,
          data: FormData.fromMap(
            {
              'phone': email,
              'password': password,
            },
          ),
        );

        return LoginModel.fromJson(f.data);
      },
    );
  }

  @override
  Future<Either<String, SignUpModel>> signUp({
    String? name,
    String? phone,
    String? parentPhone,
    String? nationalId,
    String? address,
    String? email,
    String? password,
    String? gender,
    int? classRoom,
    int? devisionId,
  }) {
    return _basicErrorHandling<SignUpModel>(
      onSuccess: () async {
        final f = await dioHelper!.postMultiPart(
          EndPoints.signUpEndPoint,
          data: FormData.fromMap(
            {
              'name': name,
              'password': password,
              'password_confirmation': password,
              'email': email,
              'phone': phone,
              'national_id': nationalId,
              'parent_phone': parentPhone,
              'address': address,
              'gender': gender,
              'classroom_id': classRoom,
            },
          ),
        );

        return SignUpModel.fromJson(f.data);
      },
    );
  }

  @override
  Future<Either<String, UserCredential>> loginWithGoogle() {
    return _basicErrorHandling<UserCredential>(
      onSuccess: () async {
        GoogleSignInAccount? googleUser;
        await GoogleSignIn().signIn().then((value) {
          googleUser = value;
        }).onError((dynamic error, stackTrace) {
          // print(error.toString());
        });
        GoogleSignInAuthentication? googleAuth;
        if (googleUser != null) {
          await googleUser!.authentication.then((value) {
            googleAuth = value;
          }).catchError((e) {
            showToast(msg: e);
          });
        }
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
        final f = await FirebaseAuth.instance.signInWithCredential(credential);

        return f;
      },
    );
  }

  @override
  Future<Either<String, UserCredential>> loginWithFacebook() {
    return _basicErrorHandling<UserCredential>(
      onSuccess: () async {
        final fb = FacebookLogin();
        final res = await fb.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);
        final FacebookAccessToken accessToken = res.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final f = await FirebaseAuth.instance.signInWithCredential(credential);

        return f;
      },
    );
  }

  @override
  Future<Either<String, String?>> logOut() {
    return _basicErrorHandling<String?>(
      onSuccess: () async {
        final f = await dioHelper!.postMultiPart(EndPoints.logOutEndPoint);
        // debugPrint(f.toString());

        return f.data; //toDo
      },
    );
  }

  @override
  Future<Either<String, ProfileModel>> getProfile() {
    return _basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final f = await dioHelper!.getMultiPart(EndPoints.profileEndPoint);
        return ProfileModel.fromJson(f.data);
      },
    );
  }

  @override
  Future<Either<String, HomeModel>> getHomeFeed() {
    return _basicErrorHandling<HomeModel>(
      onSuccess: () async {
        final f = await dioHelper!.getMultiPart(EndPoints.homeEndPoint);
        return HomeModel.fromJson(f.data);
      },
    );
  }

  @override
  Future<Either<String, Uint8List?>> getPdf({String? url}) {
    return _basicErrorHandling<Uint8List?>(
      onSuccess: () async {
        final f = await dioHelper!.getFile(url);
        return f;
      },
    );
  }

  @override
  Future<Either<String, ForgetPasswordModel>> resetPassword({String? email}) {
    return _basicErrorHandling<ForgetPasswordModel>(
      onSuccess: () async {
        final f =
            await dioHelper!.postMultiPart(EndPoints.resetPassword, data: {
          'email': email,
        });
        return ForgetPasswordModel.fromJson(f.data);
      },
    );
  }

  @override
  Future<Either<String, AppVersionModel>> getVersion() {
    return _basicErrorHandling<AppVersionModel>(
      onSuccess: () async {
        final f = await dioHelper!.getMultiPart(
          EndPoints.checkVersionAndroid,
        );
        return AppVersionModel.fromJson(f.data);
      },
    );
  }
}

extension on Repository {
  dynamic onServerErrorBase(dynamic e) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.response:
          Object? msg;
          msg = e.response?.data['message'];
          msg ??= e.response?.data['message'];
          return msg ?? e.error;
        case DioErrorType.other:
          return 'تحقق من إتصالك بالإنترنت ثم أعد المحاولة';
        default:
          return e.error;
      }
    }
    return e;
  }

  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(Exception exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on SocketException {
      return const Left('تحقق من إتصالك بالإنترنت ثم أعد المحاولة');
    } on Exception catch (e) {
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f.toString());
      }
      final f = onServerErrorBase(e);
      return Left(f.toString());
    }
  }
}
