import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CA_TextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPasswordText;
  final String? initialValueCustom;
  final bool filledValue;
  final bool needBorder;
  final Color? fillColor;
  final String CA_hintText;
  final String labelText;
  final TextStyle labelTextStyle;
  final TextInputType textInputType;
  final bool isObscure;
  final int maxlen;
  final VoidCallback? onTapField;
  final Function(String?) onChangeField;
  final Function(String?) onSaveField;
  final VoidCallback onEditingDone;
  final Widget? suffixIcon;
  final Color? suffixColor;

  const CA_TextField(
    this.controller,
    this.textInputType, {
    required this.onSaveField,
    required this.onEditingDone,
    required this.onChangeField,
    required this.onTapField,
    this.maxlen = 20,
    this.suffixIcon,
    this.suffixColor,
    this.labelText = '',
    this.CA_hintText = '',
    this.isObscure = false,
    this.fillColor = const Color.fromARGB(255, 232, 227, 227),
    this.needBorder = false,
    this.isPasswordText = false,
    this.initialValueCustom,
    this.filledValue = true,
    this.labelTextStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: TextFormField(
        initialValue: initialValueCustom,
        controller: controller,
        maxLines: 1,
        cursorOpacityAnimates: true,
        keyboardType: textInputType,
        obscureText: isObscure,
        maxLength: maxlen,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        onEditingComplete: onEditingDone,
        // onSaved: ((newValue) => ),
        onChanged: onChangeField,
        onFieldSubmitted: onSaveField,
        onTap: onTapField,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: suffixColor,
          filled: true,
          hintText: CA_hintText,
          labelText: labelText,
          labelStyle: labelTextStyle,
          fillColor: fillColor,
          focusColor: Colors.green,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          border: needBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
