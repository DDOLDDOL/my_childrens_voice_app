import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.title,
    this.labelText,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.maxLength,
    this.hintStyle = const TextStyle(fontSize: 14),
    this.textStyle = const TextStyle(fontSize: 14),
    this.floatingLabelStyle = const TextStyle(color: Colors.black),
    this.prefixIcon,
    this.suffixIcon,
    this.innerPrefixIcon,
    this.innerSuffixIcon,
    this.keyboardType,
    this.borderRadiusValue = 12,
    this.enabled = true,
    this.autoFocus = false,
    this.obscureText = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double borderRadiusValue;
  final int? maxLength;
  final String? title;
  final String? labelText;
  final String? errorText;
  final String? hintText;
  final String? initialValue;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final TextStyle floatingLabelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? innerPrefixIcon;
  final Widget? innerSuffixIcon;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool autoFocus;
  final bool obscureText;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        Row(
          children: [
            if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: prefixIcon,
              ),
            Expanded(
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(maxLength),
                ],
                enabled: enabled,
                autofocus: autoFocus,
                controller: controller,
                initialValue: initialValue,
                onTap: onTap,
                onChanged: onChanged,
                focusNode: focusNode,
                obscureText: obscureText,
                keyboardType: keyboardType,
                style: textStyle,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: errorText == null ? Colors.grey : Colors.red,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  fillColor: !enabled ? Colors.grey.shade200 : null,
                  filled: !enabled,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  errorText: errorText,
                  hintText: hintText,
                  labelText: labelText,
                  floatingLabelStyle: floatingLabelStyle,
                  hintStyle: hintStyle,
                  floatingLabelBehavior: floatingLabelBehavior,
                  prefixIcon: innerPrefixIcon,
                  suffixIcon: innerSuffixIcon,
                ),
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: suffixIcon,
              ),
          ],
        ),
      ],
    );
  }
}
