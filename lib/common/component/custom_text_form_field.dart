import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText, autofocusText;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocusText = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORLDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 비밀번호입력시
      obscureText: obscureText,
      autofocus: autofocusText,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: hintText,
        // 배경색 입힐건지 말건지?
        filled: true,
        fillColor: INPUT_BG_COLOR,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        errorText: errorText,
      ),
    );
  }
}
