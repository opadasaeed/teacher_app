import 'package:flutter/material.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: ThemeCubit.get(context).isDark! ? Colors.white : Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: Icon(
        icon,
        color: ThemeCubit.get(context).isDark! ? Colors.white : Colors.black,
      ),
      onTap: onTap,
    );
  }
}
