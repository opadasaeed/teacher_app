import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedUpdateDialog extends StatelessWidget {
  const NeedUpdateDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: Directionality(
              textDirection: TextDirection.rtl, child: Text("خطأ")),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'من فضلك قم بتحديث التطبيق',
            ),
          ),
          actions: [
            TextButton(
              child: Text("تحديث"),
              onPressed: () async {
                final packageInfo = await PackageInfo.fromPlatform();
                if (Platform.isAndroid) {
                  final String packageName = packageInfo.packageName;
                  launchURL(
                    "https://play.google.com/store/apps/details?id=$packageName",
                  );
                } else {
                 // final appleAppID = await const MethodChannel('turbo_core_kit')
                //      .invokeMethod<String>('getAppleAppID');
                //  launchURL(
                 //   "https://apps.apple.com/eg/app/turbo-eg/id$appleAppID",
                //  );
                }//todo
              },
            )
          ],
        ));
  }

  void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
