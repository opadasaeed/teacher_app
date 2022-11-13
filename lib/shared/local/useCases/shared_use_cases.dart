import 'dart:convert' as ConvertPack;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart' as CryptoPack;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as EncryptPack;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/layout/home/home_layout.dart';

import '../../components/toasts.dart';
import '../../config/colors.dart';
import '../../network/remote/api_endpoints.dart';
import '../localization/local_keys.dart';
import '../user_helper.dart';

void navigateTo({
  required context,
  required route,
}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => route));
}

void navigateAndFinish({
  required context,
  required route,
}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => route,
        ),
        (Route<dynamic> route) => false);

Future<void> myBackgroundMessageHandler(BuildContext context) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  await _firebaseMessaging.getToken();
  // debugPrint('Firebase token => ' + token);

  await _firebaseMessaging.requestPermission(
    sound: true,
    badge: true,
    alert: true,
    provisional: true,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    MaterialPageRoute(
      builder: (_) => HomeLayout(),
    );
  });
}

saveDeviceToken() async {
  // Get the current user
  String? uid = await UserHelper.getUserToken();

  // Get the token for this device
  String? fcmToken = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.instance.subscribeToTopic('all');
  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.set({
      'token': fcmToken,
      'createdAt': FieldValue.serverTimestamp(), // optional
      'platform': Platform.operatingSystem // optional
    });
  }
}

Future<int?> checkWallet({
  required context,
  double? price,
  double? wallet,
  String? type,
  int? id,
}) async {
  int x = -1;

  return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (ctx) => AlertDialog(
              title: Text(translate(LocalKeys.userExp.pleaseConfirm)),
              content: Text(
                  '${translate(LocalKeys.userExp.confirmMessage)} ${type == EndPoints.sectionEndPoint ? translate(LocalKeys.userExp.section) : translate(LocalKeys.userExp.lesson)} $price ${translate(LocalKeys.userExp.le)}'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary2Color),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      showToast(msg: translate(LocalKeys.userExp.cancel));
                    },
                    child: Text(
                      translate(LocalKeys.userExp.cancel),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.primary1Color),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary1Color),
                    ),
                    onPressed: () async {
                      cheakWallet2(wallet, price) ? x = 1 : x = 0;
                      print(wallet.toString());
                      print(price.toString());
                      print(x);
                      Navigator.of(ctx).pop(x);
                    },
                    child: Text(
                      translate(LocalKeys.userExp.confirm),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColors.primary2Color),
                    ))
              ]));
}

cheakWallet2(wallet, price) {
  return wallet < price ? false : true;
}

bool needUpdate(String existingVersion, String minVersion) {
  existingVersion = existingVersion.replaceAll(".", "");
  minVersion = minVersion.replaceAll(".", "");
  return num.parse(minVersion) > num.parse(existingVersion);
}

Future<bool> initPlatformState() async {
  // bool jailbroken;
  bool developerMode;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    // jailbroken = await FlutterJailbreakDetection.jailbroken;
    developerMode = await FlutterJailbreakDetection.developerMode;
  } on PlatformException {
    developerMode = true;
  }
  return developerMode;
}

String extractPayload(String payload) {
  String strPwd = "Cb9eGT2s#~";
  String strIv = "3#t;fV._N[";
  var iv = CryptoPack.sha256
      .convert(ConvertPack.utf8.encode(strIv))
      .toString()
      .substring(0, 16); // Consider the first 16 bytes of all 64 bytes
  var key = CryptoPack.sha256
      .convert(ConvertPack.utf8.encode(strPwd))
      .toString()
      .substring(0, 32); // Consider the first 32 bytes of all 64 bytes
  EncryptPack.IV ivObj = EncryptPack.IV.fromUtf8(iv);
  EncryptPack.Key keyObj = EncryptPack.Key.fromUtf8(key);
  final encrypter = EncryptPack.Encrypter(
      EncryptPack.AES(keyObj, mode: EncryptPack.AESMode.cbc)); // Apply CBC mode
  String firstBase64Decoding = new String.fromCharCodes(
      ConvertPack.base64.decode(payload)); // First Base64 decoding
  final decrypted = encrypter.decrypt(
      EncryptPack.Encrypted.fromBase64(firstBase64Decoding),
      iv: ivObj); // Second Base64 decoding (during decryption)
  // print(decrypted);
  return decrypted;
}

Future<bool> isSameDeviceUid(String id) async {
  bool result;
  String? data = await deviceUid();
  var doc = await FirebaseFirestore.instance
      .collection('devices')
      .doc(id.replaceAll('"', '').trim())
      .get();
  if (doc.data() != null) {
    result = doc.data()!['deviceUID'].toString() == data ? true : false;
  } else {
    result = true;
  }
  return result;
}

Future<void> storeDeviceUid(String email) async {
  await FirebaseFirestore.instance
      .collection('devices')
      .doc(email.replaceAll('"', '').trim())
      .get()
      .then((value) async {
    if (value.data() == null) {
      String? deviceId = await deviceUid();
      await FirebaseFirestore.instance
          .collection('devices')
          .doc(email.replaceAll('"', '').trim())
          .set({"deviceUID": deviceId});
    }
  });
}

Future<String?> deviceUid() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.id;
}
