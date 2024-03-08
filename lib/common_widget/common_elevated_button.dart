import 'package:flutter/material.dart';
import 'package:like_comment/common_attribute/common_value.dart';
import 'package:like_comment/common_widget/common_text.dart';

class CommonElevatedButton extends StatelessWidget {

  final Color buttonColor;
  final Color textColor;
  final String text;
  final VoidCallback? onPressed;


  const CommonElevatedButton({
    super.key,
    this.buttonColor = Colors.teal,
    this.text = "",
    this.textColor = Colors.white,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      child: CommonText(text: text, textColor: textColor, fontWeight: TextWeight.bold),
    );
  }
}
