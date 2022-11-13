import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/layout/home/cubit/cubit.dart';
import 'package:teacher_app/modules/forgotPassword/cubit/cubit.dart';
import 'package:teacher_app/modules/login/cubit/cubit.dart';
import 'package:teacher_app/modules/profile/cubit/cubit.dart';
import 'package:teacher_app/modules/signUp/cubit/cubit.dart';
import 'package:teacher_app/shared/cubit/cubit.dart';
import 'package:teacher_app/shared/network/repository_imp.dart';
import 'package:teacher_app/shared/local/cache_helper.dart';
import 'package:teacher_app/shared/network/cubit/cubit.dart';
import 'package:teacher_app/shared/network/remote/api_endpoints.dart';
import 'package:teacher_app/shared/network/remote/dio/dio_helper.dart';
import 'package:teacher_app/shared/network/remote/dio/wrapper.dart';
import 'package:teacher_app/shared/network/repository.dart';

import 'package:teacher_app/shared/theme/cubit/cubit.dart';


import '../../modules/homeFeed/cubit/cubit.dart';


GetIt di = GetIt.I;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      di<SharedPreferences>(),
    ),
  );
  di.registerLazySingleton<NetworkCubit>(
    () => NetworkCubit(),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImpl(
      baseURL: EndPoints.baseUrl,
      onRequest: di<NetworkCubit>().onRequestCallback,
      onError: di<NetworkCubit>().onErrorCallback,
    ),
  );

  di.registerLazySingleton<Repository>(
    () => RepoImpl(
      dioHelper: di<DioHelper>(),
    ),
  );

  di.registerFactory<LoginCubit>(
    () => LoginCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<SignUpCubit>(
    () => SignUpCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<HomeLayoutCubit>(
    () => HomeLayoutCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<SharedCubit>(
    () => SharedCubit(),
  );
  di.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(),
  );

  di.registerFactory<ProfileScreenCubit>(
    () => ProfileScreenCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<HomeFeedScreenCubit>(
    () => HomeFeedScreenCubit(
      di<Repository>(),
    ),
  );


  di.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(
      di<Repository>(),
    ),
  );
}
