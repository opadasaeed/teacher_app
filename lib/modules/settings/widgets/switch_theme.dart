import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';
import 'package:teacher_app/shared/theme/cubit/states.dart';

class SwitchDarkTheme extends StatelessWidget {
  const SwitchDarkTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeStates>(
      listener: (BuildContext context, ThemeStates state) {},
      builder: (BuildContext context, ThemeStates state) {
        return CupertinoSwitch(
          value: ThemeCubit.get(context).isDark!,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            ThemeCubit.get(context).switchTheme();
          },
        );
      },
    );
  }
}