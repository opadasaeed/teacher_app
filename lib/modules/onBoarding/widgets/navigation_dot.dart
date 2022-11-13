import 'package:flutter/material.dart';

import '../../../shared/config/colors.dart';

class NavigationDot extends StatelessWidget {
  final int? index;
  final int? currentPage;

  const NavigationDot({
    Key? key,
    this.index,
    this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 6.0,
      width: currentPage == index ? 30.0 : 6.0,
      margin: const EdgeInsetsDirectional.only(end: 5.0),
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.primary1Color : Colors.grey[300],
        borderRadius: BorderRadius.circular(3.0),
      ),
      duration: const Duration(milliseconds: 250),
    );
  }
}
