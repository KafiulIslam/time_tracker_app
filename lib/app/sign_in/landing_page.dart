import 'package:android_time_tracker/app/sign_in/home/home_page.dart';
import 'package:android_time_tracker/services/database.dart';
import 'home/job/JobsPage.dart';
import 'package:android_time_tracker/app/sign_in/sign_in_page.dart';
import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  // void inputData() {
  //   final User user = FirebaseAuth.instance.currentUser;
  //   final uid = user.uid;
  //   // here you write the codes to input the data into firestore
  // }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
        stream: auth.authStateChanges,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            Kuser user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Kuser>.value(
              value: user,
              child: Provider<Database>(
                  create: (_) => FirestoreDatabase(uid: user.uid),
                  child: HomePage()),
            ); // temporary placeholder for homepage
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
