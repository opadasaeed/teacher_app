import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/modules/homeFeed/cubit/cubit.dart';
import 'package:teacher_app/modules/homeFeed/cubit/states.dart';
import 'package:teacher_app/modules/login/login_screen.dart';
import 'package:teacher_app/shared/components/error_screen.dart';
import 'package:teacher_app/shared/components/loader_indecator.dart';
import 'package:teacher_app/shared/components/toasts.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';

import '../../shared/components/conditional_builder.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeFeedScreenCubit.get(context).getHomeFeed();
    // HomeFeedScreenCubit.get(context).checkSameDevice();
    return BlocConsumer<HomeFeedScreenCubit, HomeFeedScreenStates>(
      listener: (context, state) {
        if (state is BackHomeFeedState) {
          if (!kDebugMode) {
            navigateAndFinish(context: context, route: LoginScreen());
            Future.delayed(Duration(milliseconds: 500), () {
              showToast(msg: 'لا يمكن استخدام حسابك لاكثر من جهاز واحد');
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: RefreshIndicator(
          onRefresh: () => HomeFeedScreenCubit.get(context).getHomeFeed(),
          child: ConditionalBuilder(
            condition: state is! LoadingGetHomeFeedState,
            fallback: (context) => const LoadingIndecator(),
            builder: (context) => ConditionalBuilder(
              condition: state is! ErrorGetHomeFeedState &&
                  HomeFeedScreenCubit.get(context).homeModel != null,
              fallback: (context) => ErrorScreen(),
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    if (HomeFeedScreenCubit.get(context).homeModel != null)
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.shortestSide < 600
                              ? 280
                              : 380,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          reverse: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          aspectRatio: 2.0,
                        ),
                        items: HomeFeedScreenCubit.get(context)
                            .homeModel!
                            .data!
                            .sliders!
                            .map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? 350
                                        : 650,
                                clipBehavior: Clip.none,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(36, 48, 78, 0.10),
                                        offset: Offset(0.4, 0.5),
                                        blurRadius: 30,
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    i.image!,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: LoadingIndecator(),
                                      );
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        color: AppColors.kGrayColor,
                                        child: Image.asset(
                                          'assets/images/code.png',
                                          height: 150,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate(
                              LocalKeys.userExp.importantNotifications,
                            ),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          TextButton(
                            onPressed: () {

                            },
                            child: Text(
                              translate(
                                LocalKeys.userExp.more,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: AppColors.primary1Color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Text("notice"),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount: 2),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(
                                LocalKeys.userExp.teachers,
                              ),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          height: 230,
                          child: ListView.separated(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {

                                    },
                                    child: Text(""),
                                  ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12),
                              itemCount: 6),
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
