import 'package:flutter/material.dart';
import 'package:teacher_app/shared/config/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.function,
    required this.title,
    this.btColor,
  }) : super(key: key);
  final void Function()? function;
  final String title;
  final Color? btColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(36, 0, 0, 0.4),
            offset: Offset(0.0, 0.5),
            blurRadius: 15,
          ),
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: btColor ?? AppColors.primary1Color,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: TextButton(
        onPressed: function,
        child: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
