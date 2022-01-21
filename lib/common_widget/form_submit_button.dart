import 'package:android_time_tracker/common_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({@required String text, VoidCallback onPressed})
      : super(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            height: 44,
            color: Colors.indigo,
            borderRadius: 8,
            onPressed: onPressed);
}
