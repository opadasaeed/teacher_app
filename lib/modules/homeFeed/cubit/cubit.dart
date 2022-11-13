import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/modules/homeFeed/cubit/states.dart';
import 'package:teacher_app/modules/homeFeed/model/home_model.dart';

import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';
import 'package:teacher_app/shared/network/repository.dart';

import '../../../shared/components/default_button.dart';
import '../../../shared/local/localization/local_keys.dart';
import '../../../shared/network/remote/api_endpoints.dart';

class HomeFeedScreenCubit extends Cubit<HomeFeedScreenStates> {
  final Repository? repository;
  HomeFeedScreenCubit(this.repository) : super(InitHomeFeedScreenState());
  static HomeFeedScreenCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  Future getHomeFeed() async {
    emit(LoadingGetHomeFeedState());
    final f = await repository!.getHomeFeed();
    f.fold((l) async {
      emit(ErrorGetHomeFeedState(error: l));
    }, (r) async {
      homeModel = r;
      emit(SuccessGetHomeFeedState());
    });
  }

  checkSameDevice() async {
    String? id;
    await UserHelper.getUserModel().then((value) {
      Map map = value;
      if (map['data'] != null) {
        id = map['data']['email'];
      }
    });
    storeDeviceUid(id!);
    bool result = await isSameDeviceUid(id!);
    if (result == false) {
      emit(BackHomeFeedState());
    }
  }

  }
   checkExceedPrecentage( {context,
      int? id,
      int? exceed_percentage,
     }){
   if(exceed_percentage == 0)
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              translate(
                                  LocalKeys.userExp.precentageNotExceedMsg),
                              style: Theme.of(context).textTheme.headline5),
                          const SizedBox(
                            height: 12,
                          ),
                          DefaultButton(
                              function: () {

                              },
                              title: translate(LocalKeys.userExp.startTheExam)),
                        ],
                      ),
                    ),
                  ));
                });
  }


