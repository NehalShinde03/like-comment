import 'package:flutter/material.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_text.dart';

class CommonMaterialButton extends StatelessWidget {

  final Color buttonColor;
  final Color textColor;
  final String text;
  final VoidCallback? onPressed;


  const CommonMaterialButton({
    super.key,
    this.buttonColor = Colors.teal,
    this.text = "",
    this.textColor = Colors.white,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: buttonColor,
      child: CommonText(text: text, textColor: textColor, fontWeight: TextWeight.bold),
    );
  }
}
