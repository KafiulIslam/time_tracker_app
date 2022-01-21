// import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class KafiAlertDialog extends StatefulWidget {
  const KafiAlertDialog({Key key, this.title, this.content}) : super(key: key);
  final String title;
  final String content;

  @override
  _KafiAlertDialogState createState() => _KafiAlertDialogState();
}

class _KafiAlertDialogState extends State<KafiAlertDialog> {
  // Future<void> signOut() async {
  //   try {
  //     final auth = Provider.of<AuthBase>(context, listen: false);
  //     await auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: 330,
        decoration: BoxDecoration(
            color: Colors.pink,
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 15,
            ),
            Text(widget.content,
                style: TextStyle(color: Colors.white, fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop(false);
                });
              },
              child: Text(
                'Ok',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
