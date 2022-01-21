import 'dart:io';
import 'package:android_time_tracker/common_widget/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      this.cancelActionText,
      @required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(cancelActionText != null),
        assert(defaultActionText != null);
  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            builder: (context) => this);
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final action = <Widget>[];
    if (cancelActionText != null) {
      action.add(PlatformAlertDialogAction(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            cancelActionText,
            style: TextStyle(color: Colors.black, fontSize: 10),
          )));
    } else {
      action.add(PlatformAlertDialogAction(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            defaultActionText,
            style: TextStyle(color: Colors.black, fontSize: 10),
          )));
    }
    return _buildActions(context);
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }
}
