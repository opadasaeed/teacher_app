import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/layout/home/cubit/cubit.dart';
import 'package:teacher_app/layout/home/cubit/states.dart';
import 'package:teacher_app/modules/homeFeed/home_feed_screen.dart';

import 'package:teacher_app/modules/profile/profile_screen.dart';
import 'package:teacher_app/modules/settings/settings_screen.dart';
import 'package:teacher_app/shared/components/dialogs/dev_mode_dialog.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/di/di.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/components/app-version-text.dart';
import '../../shared/components/dialogs/need_update_dialog.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List screens = [
    const HomeFeedScreen(),

    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    BuildContext myContext = context;
    return BlocProvider(
      create: (context) => di<HomeLayoutCubit>()
        ..init(myContext)
        ..checkDevMode()..getVersion(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
          listener: (BuildContext context, state) {
        if (state is NeedUpdate) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => NeedUpdateDialog(),
          );
        }
        if (state is DevModeEnabledState) {
          if(!kDebugMode)
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DevModeDialog(),
          );
        }
      }, builder: (BuildContext context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                radius: 44,
                                backgroundImage: AssetImage(
                                  'assets/images/logo.png',
                                ),
                              ),
                              Text(
                                'Infinity Academy',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),



                        // DrawerItem(
                        //     title: translate(LocalKeys.userExp.chooseCompetitions),
                        //     icon: LineAwesomeIcons.chess_queen,
                        //     onTap: () {
                        //       navigateTo(
                        //           context: context,
                        //           route: const SelectCompetitionScreen());
                        //     }),
                        // DrawerItem(
                        //     title: translate(LocalKeys.userExp.competitions),
                        //     icon: LineAwesomeIcons.brain,
                        //     onTap: () {
                        //       navigateTo(
                        //           context: context, route: const CompetitionScreen());
                        //     }),
                        // DrawerItem(
                        //     title: translate(LocalKeys.userExp.purchaseList),
                        //     icon: LineAwesomeIcons.shopping_cart,
                        //     onTap: () {
                        //       navigateTo(context: context, route: const MyBooking());
                        //     }),



                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 12,
                      top: 12,
                    ),
                    child: const AppVersionText(),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Infinity Academy',
              style: Theme.of(context).textTheme.headline5,
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/More.svg',
                color: ThemeCubit.get(context).isDark! ? Colors.white : null,
                matchTextDirection: true,
              ),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            ),
          ),
          body: screens[HomeLayoutCubit.get(context).currentIndex],
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, -5),
                  blurRadius: 20,
                  color: const Color(0xFF24304E).withOpacity(0.09),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SalomonBottomBar(
                itemPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                unselectedItemColor: const Color(0xFF9D9B9C),
                items: [
                  SalomonBottomBarItem(
                    icon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: CustomShowCase(
                          title: translate(
                            LocalKeys.userExp.home,
                          ),
                          sKey: HomeLayoutCubit.get(context).one,
                          child: Icon(
                            Icons.home_filled,
                            color: ThemeCubit.get(context).isDark!
                                ? Colors.white
                                : null,
                          ),
                          description:
                              'هنا تجد اخر الأشعارات المهمة و الحصص الاكثر مشاهدة',
                        )),
                    title: Text(
                      translate(
                        LocalKeys.userExp.home,
                      ),
                      style: ThemeCubit.get(context).isDark!
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.primary1Color),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: CustomShowCase(
                        title: translate(
                          LocalKeys.userExp.home,
                        ),
                        sKey: HomeLayoutCubit.get(context).two,
                        description: 'من هنا تقدر تلاقي كل المواد و المدرسين',
                        child: Icon(
                          Icons.shopping_bag,
                          color: ThemeCubit.get(context).isDark!
                              ? Colors.white
                              : null,
                        ),
                      ),
                    ),
                    title: Text(
                      translate(
                        LocalKeys.userExp.myBookings,
                      ),
                      style: ThemeCubit.get(context).isDark!
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.primary1Color),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: CustomShowCase(
                      title: translate(
                        LocalKeys.userExp.profile,
                      ),
                      child: Icon(
                        Icons.person,
                        color: ThemeCubit.get(context).isDark!
                            ? Colors.white
                            : null,
                      ),
                      sKey: HomeLayoutCubit.get(context).three,
                      description:
                          'من هنا تقدر تعرف رصيد محفظتك وتقارير الامتحنات',
                    ),
                    title: Text(
                      translate(
                        LocalKeys.userExp.profile,
                      ),
                      style: ThemeCubit.get(context).isDark!
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.primary1Color),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: CustomShowCase(
                            child: Icon(
                              Icons.settings,
                              color: ThemeCubit.get(context).isDark!
                                  ? Colors.white
                                  : null,
                            ),
                            title: translate(
                              LocalKeys.userExp.settings,
                            ),
                            sKey: HomeLayoutCubit.get(context).four,
                            description:
                                'هنا تقدر تغير اللغة وتفعل الوضع الليلي')),
                    title: Text(
                      translate(
                        LocalKeys.userExp.settings,
                      ),
                      style: ThemeCubit.get(context).isDark!
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.primary1Color),
                    ),
                  ),
                ],
                selectedItemColor: AppColors.primary1Color,
                selectedColorOpacity:
                    ThemeCubit.get(context).isDark! ? 0.4 : null,
                currentIndex: HomeLayoutCubit.get(context).currentIndex,
                onTap: (value) {
                  HomeLayoutCubit.get(context).changeIndex(index: value);
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

Widget CustomShowCase(
        {required Widget child,
        required GlobalKey sKey,
        String? description,
        String? title}) =>
    Showcase(
        overlayPadding: const EdgeInsets.all(8),
        showcaseBackgroundColor: AppColors.primary1Color,
        textColor: Colors.white,
        key: sKey,
        title: title,
        description: description,
        child: child);
