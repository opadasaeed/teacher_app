import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../layout/home/model/app_version_model.dart';
import '../../modules/forgotPassword/models/forget_password_model.dart';
import '../../modules/homeFeed/model/home_model.dart';
import '../../modules/login/models/login_model.dart';
import '../../modules/profile/model/profile_model.dart';
import '../../modules/signUp/models/sign_up_model.dart';


abstract class Repository {
  // Future<Either<String, VersionModel>> getVersion();
  //
  // Future<Either<String, GenericModel>> registerFirebaseToken({
  //   String firebaseToken,
  // });

  Future<Either<String, LoginModel>> login({
    String? email,
    String? password,
  });

  Future<Either<String, AppVersionModel>> getVersion();

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
    int? devisionId, // 3lmy aw adaby ryada w 3loom
  });

  Future<Either<String, UserCredential>> loginWithGoogle();

  Future<Either<String, UserCredential>> loginWithFacebook();





  Future<Either<String, ProfileModel>> getProfile();



  Future<Either<String, HomeModel>> getHomeFeed();

  Future<Either<String, ForgetPasswordModel>> resetPassword({String? email});



  Future<Either<String, Uint8List?>> getPdf({String? url});

  Future<Either<String, String?>> logOut();
}
