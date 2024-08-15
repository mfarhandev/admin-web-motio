
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? buttonElevation;
  final Color? buttonBackgroundColor;
  final double? buttonborderRadius;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final FontWeight?  fontWeight;
  ElevatedButtonWidget({ 
    Key? key,
    required this.onPressed,
    required this.child, 
    this.margin,
    this.buttonBackgroundColor,
    this.buttonWidth,
    this.buttonElevation,
    this.buttonHeight,
    this.buttonborderRadius,
    this.fontSize,
    this.fontWeight
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: buttonWidth ?? 45,
      height: buttonHeight ?? 45,
      margin: margin ?? EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: buttonElevation ?? 2,
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(buttonborderRadius??8.0),
          ),
          backgroundColor: buttonBackgroundColor ?? Color(0xff26A4FF)),
        child: child
        )
      );
  }
}