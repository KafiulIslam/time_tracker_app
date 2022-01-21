import 'package:android_time_tracker/common_widget/platform_alert_dialogue.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
            title: title,
            content: _message(exception),
            defaultActionText: 'ok');

  static _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'invalid-email': 'invalid-email'

    ///  - Thrown if the email address is not valid.
    /// - **user-disabled**:
    ///  - Thrown if the user corresponding to the given email has been disabled.
    /// - **user-not-found**:
    ///  - Thrown if there is no user corresponding to the given email.
    /// - **wrong-password**:
    ///  - Thrown if the password is invalid for the given email, or the account
    ///    corresponding to the email does not have a password set.
  };
}
