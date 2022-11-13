import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({Key? key}) : super(key: key);

  Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: getPackageInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String versionName = snapshot.data!.version;
          String versionNumber = snapshot.data!.buildNumber;
          return Text(
            'v.$versionName ($versionNumber)',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black,
              fontSize: 12,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
