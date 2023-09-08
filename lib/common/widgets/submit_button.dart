import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// TODO: icon과 text를 같이 child에 할당할 시 8의 간격이 적당합니다 (Recommended)
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.onPressed,
    this.loadingWhen = false,
    this.borderRadiusValue = 12,
    this.elevation = 2,
    this.enabledColor,
    this.disabledColor,
    this.enabledButtonTextColor,
    this.disabledButtonTextColor,
    this.border = const BorderSide(width: 0, color: Colors.transparent),
    this.width = double.maxFinite,
    this.height = 50,
    this.child,
  }) : super(key: key);

  final void Function()? onPressed;
  final bool loadingWhen;
  final double borderRadiusValue;
  final double elevation;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledButtonTextColor;
  final Color? disabledButtonTextColor;
  final BorderSide border;
  final double width;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var childWidget = child ?? _defaultChild;

    if(child is Text) {
      childWidget = Text((child as Text).data!, style: _defaultTextStyle);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
          side: border,
        ),
        backgroundColor: enabledColor ?? Colors.teal.shade400,
        disabledBackgroundColor: disabledColor ?? Colors.grey.shade400,
        foregroundColor: enabledButtonTextColor ?? Colors.white,
        disabledForegroundColor: disabledButtonTextColor ?? Colors.white,
      ),
      onPressed: loadingWhen ? () {} : onPressed,
      child: loadingWhen ? _loadingIndicator : childWidget,
    );
  }

  Widget get _defaultChild => Text('확인', style: _defaultTextStyle);

  Widget get _loadingIndicator => const SpinKitThreeBounce(
        color: Colors.white,
        size: 18,
      );

  TextStyle get _defaultTextStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
}
