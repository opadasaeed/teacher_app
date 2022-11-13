import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../shared/config/colors.dart';

class DiscountContainer extends StatelessWidget {
  const DiscountContainer({
    Key? key,
    this.discount,
    this.fromUnits,
    this.height,
  }) : super(key: key);

  final String? discount;
  final String? fromUnits;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: height ?? 50,
        decoration: BoxDecoration(
            borderRadius: fromUnits != null
                ? BorderRadius.circular(50)
                : BorderRadiusDirectional.only(
                    topEnd: Radius.circular(12),
                    bottomStart: Radius.circular(12),
                  ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.0, 0.4),
                color: Color.fromRGBO(36, 48, 78, 0.80),
                blurRadius: 5,
              ),
            ],
            color: AppColors.kRedColor),
        child: Center(
          child: Text(
            translate(
              '${discount}%',
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
          ),
        ));
  }
}
