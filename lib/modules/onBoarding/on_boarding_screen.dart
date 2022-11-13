import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/modules/login/login_screen.dart';
import 'package:teacher_app/modules/onBoarding/widgets/navigation_dot.dart';
import 'package:teacher_app/modules/onBoarding/widgets/oage_viewer_image.dart';
import 'package:teacher_app/shared/components/default_button.dart';
import 'package:teacher_app/shared/config/colors.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/local/useCases/shared_use_cases.dart';
import 'package:teacher_app/shared/local/user_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> onBoardingContent = [
    {
      "text": translate(
        LocalKeys.userExp.onBoardingDesc1,
      ),
      "title": translate(
        LocalKeys.userExp.onBoardingTitle1,
      ),
      "image": "assets/images/learning.svg"
    },
    {
      "text": translate(
        LocalKeys.userExp.onBoardingDesc2,
      ),
      "title": translate(
        LocalKeys.userExp.onBoardingTitle2,
      ),
      "image": "assets/images/learning2.svg"
    },
    {
      "text": translate(
        LocalKeys.userExp.onBoardingDesc3,
      ),
      "title": translate(
        LocalKeys.userExp.onBoardingTitle3,
      ),
      "image": "assets/images/downloads.svg"
    }
  ];
  final PageController controller = PageController();
  int currentPage = 0;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    UserHelper.putIsOnBoarding(true);
                    navigateAndFinish(context: context, route: LoginScreen());
                  },
                  child: Text(
                    (widget.currentPage != 2)
                        ? translate(
                            LocalKeys.userExp.skip,
                          )
                        : '',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppColors.primary1Color,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
                child: PageView.builder(
              controller: widget.controller,
              onPageChanged: (value) {
                setState(() {
                  widget.currentPage = value;
                });
              },
              itemCount: widget.onBoardingContent.length,
              itemBuilder: (BuildContext context, int index) => PageViewerImage(
                title: widget.onBoardingContent[index]['title'],
                textContent: widget.onBoardingContent[index]['text'],
                image: widget.onBoardingContent[index]['image'],
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: List.generate(
                widget.onBoardingContent.length,
                (index) => NavigationDot(
                  index: index,
                  currentPage: widget.currentPage,
                ),
              ),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            const SizedBox(
              height: 40,
            ),
            DefaultButton(
              function: () {
                (widget.controller.page != 2)
                    ? widget.controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn)
                    : {
                        UserHelper.putIsOnBoarding(true),
                        navigateAndFinish(
                          context: context,
                          route: LoginScreen(),
                        )
                      };
              },
              title: translate(
                LocalKeys.userExp.next,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
