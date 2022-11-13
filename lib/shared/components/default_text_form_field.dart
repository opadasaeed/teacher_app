import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:teacher_app/shared/local/localization/local_keys.dart';
import 'package:teacher_app/shared/theme/cubit/cubit.dart';


class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    Key? key,
    required this.focusNode,
    this.hasFocused = false,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    required this.hintTitle,
    this.isValidate = false,
    this.validator,
    required this.title,
  }) : super(key: key);
  final FocusNode focusNode;
  final bool hasFocused;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final String hintTitle;
  final String title;
  final bool isValidate;
  final Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: isValidate
            ? validator != null
                ? (String? value) => validator!(value)
                : (String? value) {
                    if (value == null || value.isEmpty) {
                      return '${translate(LocalKeys.userExp.youMustEnter)} $title';
                    }
                    return null;
                  }
            : null,
        decoration: InputDecoration(
          hintText: hintTitle,
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: ThemeCubit.get(context).isDark!
                    ? Colors.white
                    : const Color(
                        0xFF9196A8,
                      ),
                fontWeight: FontWeight.w100,
              ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          fillColor: ThemeCubit.get(context).isDark!
              ? const Color(0xFF2C2E37)
              : const Color(0xFFF5F5F9),
          filled: !hasFocused,
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF6676E1),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}
