import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/modules/forgotPassword/cubit/states.dart';

import 'package:teacher_app/modules/forgotPassword/models/forget_password_model.dart';

import 'package:teacher_app/shared/network/repository.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final Repository? repository;
  ForgetPasswordCubit(this.repository) : super(InitForgetPasswordState());
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  late ForgetPasswordModel forgetPasswordModel;
  Future resetPassword({required String email}) async {
    emit(LoadingForgetPasswordState());
    final f = await repository!.resetPassword(email: email);
    f.fold((l) async {
      emit(ErrorForgetPasswordState(error: l));
    }, (r) async {
      forgetPasswordModel = r;
      forgetPasswordModel.success == true
          ? emit(SuccessForgetPasswordState())
          : emit(ErrorForgetPasswordState());
    });
  }
}
