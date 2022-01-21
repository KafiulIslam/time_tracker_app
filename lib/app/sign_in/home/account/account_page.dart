import 'package:android_time_tracker/common_widget/avatar.dart';
import 'package:android_time_tracker/common_widget/dialog_box.dart';
import 'package:android_time_tracker/common_widget/platform_alert_dialogue.dart';
import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure to logout ?',
      cancelActionText: 'No',
      defaultActionText: 'Yes',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Kuser>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            'Account',
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogBox();
                    });
              },
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.00),
          child: _buildUserInfo(user),
        ),
      ),
    );
  }

  _buildUserInfo(Kuser user) {
    return Column(
      children: [
        Stack(children: [
          Avatar(
            radius: 55,
          ),
          Positioned(
            top: 5,
            right: 5,
            left: 5,
            bottom: 5,
            child: Avatar(
              radius: 5,
              photoUrl: user.photoUrl,
            ),
          ),
        ]),
        SizedBox(
          height: 8,
        ),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
