import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/layout/home/cubit/cubit.dart';
import 'package:teacher_app/layout/home/cubit/states.dart';
import 'package:teacher_app/modules/settings/widgets/switch_theme.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  translate(LocalKeys.userExp.generalSettings),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => showModalBottomSheet(
                      backgroundColor: Theme.of(context).backgroundColor,
                      clipBehavior: Clip.antiAlias,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          height: MediaQuery.of(context).size.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Text(
                                    'العربية',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  onTap: () {
                                    ThemeCubit.get(context)
                                        .changlang(context, 'ar');
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  child: Text(
                                    'English',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  onTap: () {
                                    ThemeCubit.get(context)
                                        .changlang(context, 'en');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        translate(
                          LocalKeys.userExp.changeLanguage,
                        ),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const Spacer(),
                      Text(
                        LocalizedApp.of(context)
                                    .delegate
                                    .currentLocale
                                    .toString() ==
                                'ar'
                            ? 'العربية'
                            : 'English',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      translate(LocalKeys.userExp.darkMode),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const Spacer(),
                    const SwitchDarkTheme(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // GestureDetector(
                //   onTap: () {
                //     showDialog(
                //         context: context,
                //         builder: (context) => Dialog(child: QrTopSheet()));
                //   },
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 32,
                //         height: 32,
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).primaryColor,
                //           borderRadius: BorderRadius.circular(7),
                //         ),
                //         child: const Icon(
                //           Icons.share,
                //           color: Colors.white,
                //           size: 15,
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         translate(LocalKeys.userExp.shareApp),
                //         style: Theme.of(context).textTheme.subtitle2,
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                DefaultButton(
                    function: () {
                      HomeLayoutCubit.get(context).logOut(context);
                    },
                    title: translate(LocalKeys.userExp.logOut)),
              ],
            ),
          ),
        );
      },
    );
  }
}
