import 'package:flutter/material.dart';
import 'package:android_time_tracker/common_widget/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    String imageName,
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(imageName),
                ),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
                Opacity(opacity: 0.0, child: Image.asset(imageName))
              ],
            ),
            color: color,
            onPressed: onPressed);
}
