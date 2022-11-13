import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/modules/profile/cubit/cubit.dart';
import 'package:teacher_app/modules/profile/cubit/states.dart';
import 'package:teacher_app/modules/profile/widgets/result_row.dart';
import 'package:teacher_app/shared/components/error_screen.dart';
import 'package:teacher_app/shared/components/loader_indecator.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/conditional_builder.dart';
import '../../shared/di/di.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> phoneNumbers = const ["+201023119304", "+201023221830"];

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<ProfileScreenCubit>()..getProfile(),
      child: BlocConsumer<ProfileScreenCubit, ProfileScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => ProfileScreenCubit.get(context).getProfile(),
            child: ConditionalBuilder(
              condition: state is! LoadingGetProfileState,
              fallback: (context) => const LoadingIndecator(),
              builder: (context) => ConditionalBuilder(
                condition: state is! ErrorGetProfileState,
                fallback: (context) => ErrorScreen(),
                builder: (context) => SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 38,
                            child: SvgPicture.asset(
                                ProfileScreenCubit.get(context)
                                            .profileModel
                                            .data!
                                            .profile!
                                            .gender ==
                                        'm'
                                    ? 'assets/images/male_avatar.svg'
                                    : 'assets/images/female_avatar.svg')),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .profile!
                                    .name!),
                                Text(ProfileScreenCubit.get(context)
                                        .profileModel
                                        .data!
                                        .profile!
                                        .classroom_name ??
                                    ""),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Mobile : ${ProfileScreenCubit.get(context).profileModel.data!.profile!.phone}",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  "Email : ${ProfileScreenCubit.get(context).profileModel.data!.profile!.email}",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).backgroundColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(36, 48, 78, 0.10),
                                    offset: Offset(0.4, 0.5),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    translate(LocalKeys.userExp.code),
                                  ),
                                  Text(
                                    ProfileScreenCubit.get(context)
                                            .profileModel
                                            .data!
                                            .profile!
                                            .code ??
                                        '0',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary1Color,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(36, 48, 78, 0.10),
                                offset: Offset(0.4, 0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .profile!
                                    .wallet
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                translate(LocalKeys.userExp.currentBalance),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(36, 48, 78, 0.10),
                                offset: Offset(0.4, 0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(translate(LocalKeys.userExp.exams),
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                if (ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .quizzes!
                                    .isEmpty)
                                  Text(
                                      translate(
                                        LocalKeys.userExp.noProfileExam,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppColors.neutral2Color)),
                                if (ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .quizzes!
                                    .isNotEmpty)
                                  ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          ResultsDataRow(
                                            quizze:
                                                ProfileScreenCubit.get(context)
                                                    .profileModel
                                                    .data!
                                                    .quizzes![index],
                                            index: (index + 1).toString(),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 12,
                                          ),
                                      itemCount: ProfileScreenCubit.get(context)
                                          .profileModel
                                          .data!
                                          .quizzes!
                                          .length)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(36, 48, 78, 0.10),
                                offset: Offset(0.4, 0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(translate(LocalKeys.userExp.questionsBank),
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                if (ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .assignments!
                                    .isEmpty)
                                  Text(
                                      translate(LocalKeys
                                          .userExp.noProfileAssignments),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppColors.neutral2Color)),
                                if (ProfileScreenCubit.get(context)
                                    .profileModel
                                    .data!
                                    .assignments!
                                    .isNotEmpty)
                                  ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          ResultsDataRow(
                                            quizze:
                                                ProfileScreenCubit.get(context)
                                                    .profileModel
                                                    .data!
                                                    .assignments![index],
                                            index: (index + 1).toString(),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 12,
                                          ),
                                      itemCount: ProfileScreenCubit.get(context)
                                          .profileModel
                                          .data!
                                          .assignments!
                                          .length)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(36, 48, 78, 0.10),
                                offset: Offset(0.4, 0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(translate(LocalKeys.userExp.contactWithUs),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      launch(
                                        "https://www.facebook.com/infinityapp.online",
                                      );
                                    },
                                    child: SvgPicture.asset(
                                        'assets/icons/facebook_2.svg'),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        launch(
                                          "https://www.youtube.com/channel/UCh2twZskV5xfFcAaRqI-6cg",
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          'assets/icons/youtube.svg')),
                                  InkWell(
                                      onTap: (){
                                        launch(
                                          "https://wa.me/+201023574423",
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          'assets/icons/whatsapp.svg')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
