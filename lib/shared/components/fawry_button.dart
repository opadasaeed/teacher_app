import 'package:flutter/material.dart';

class FawryButton extends StatelessWidget {
  const FawryButton({
    Key? key, required this.function, required this.title,
  }) : super(key: key);
  final Function function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.amber,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: TextButton(
        onPressed: function as void Function()?,
        child: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}