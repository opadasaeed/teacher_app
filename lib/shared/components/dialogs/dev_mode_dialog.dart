
import 'package:flutter/material.dart';

class DevModeDialog extends StatelessWidget {
  const DevModeDialog({
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'من فضلك قم باغلاق وضع المطور',
                ),
                SizedBox(height: 20,),
                 Text(
                  '1- افتح اعدادات جهازك',
                ),
                SizedBox(height: 10,),
                 Text(
                  '2- ابحث عن developer options',
                ),
                SizedBox(height: 10,),
                 Text(
                  '3- اقفل التفعيل',
                ),
                SizedBox(height: 10,),
                 Text(
                  '4- ارجع تاني واحنا في انتظارك ❤️',
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ));
  }

 
}
