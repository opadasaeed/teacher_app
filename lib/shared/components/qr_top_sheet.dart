import 'package:flutter/material.dart';

class QrTopSheet extends StatelessWidget {
  const QrTopSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 32, top: 24),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: Text(
                '! Scan Me',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset(
              'assets/images/qr-code.png',
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .4,
            )),
          ],
        ));
  }
}
