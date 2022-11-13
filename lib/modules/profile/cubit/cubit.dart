import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/modules/profile/cubit/states.dart';
import 'package:teacher_app/modules/profile/model/profile_model.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  final Repository? repository;
  ProfileScreenCubit(this.repository) : super(InitProfileScreenState());
  static ProfileScreenCubit get(context) => BlocProvider.of(context);
  late ProfileModel profileModel;
  String? wallet;
  Future getProfile() async {
    emit(LoadingGetProfileState());
    final f = await repository!.getProfile();
    f.fold(
      (l) {
        emit(ErrorGetProfileState(error: l));
      },
      (r) async {
        wallet = await (UserHelper.getWallet() );
        profileModel = r;

        if ('${double.parse(wallet!).round()}' !=
            profileModel.data!.profile!.wallet) {
          await UserHelper.putWallet(profileModel.data!.profile!.wallet.toString());
        }
        emit(SuccessGetProfileState());
      },
    );
  }
}
