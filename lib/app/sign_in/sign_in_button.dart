import 'package:flutter/material.dart';
import 'package:android_time_tracker/common_widget/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: textColor),
            ),
            color: color,
            onPressed: onPressed);
}
