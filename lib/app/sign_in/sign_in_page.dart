import 'package:android_time_tracker/app/sign_in/email-sign-in-page.dart';
import 'package:android_time_tracker/app/sign_in/sign_in_manager.dart';
import 'package:android_time_tracker/app/sign_in/sign_in_button.dart';
import 'package:android_time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:android_time_tracker/common_widget/platform_exception_alert_dialog.dart';
import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);

  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (context) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
              builder: (context, manager, _) =>
                  SignInPage(manager: manager, isLoading: isLoading.value)),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
      // onSignIn(user);
      // print('${authResult.user.uid}');
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Center(
          child: Text(
            'Time Tracker',
          ),
        ),
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Padding _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50, child: _buildHeader()),
            SizedBox(
              height: 30,
            ),
            SocialSignInButton(
              imageName: 'images/google logo.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: isLoading ? null : () => _signInWithGoogle(context),
            ),
            SizedBox(
              height: 10,
            ),
            SocialSignInButton(
              imageName: 'images/facebook logo.png',
              text: 'Sign in with facebook',
              textColor: Colors.black,
              color: Color(0xFF334D92),
              onPressed: isLoading ? null : () {},
            ),
            SizedBox(
              height: 10,
            ),
            SocialSignInButton(
              imageName: 'images/gmail logo.png',
              text: 'Sign in with email',
              textColor: Colors.black,
              color: Colors.teal[700],
              onPressed: isLoading ? null : () => _signInWithEmail(context),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            SignInButton(
              text: 'Go with anonymous',
              textColor: Colors.black,
              color: Colors.lime[300],
              onPressed: isLoading ? null : () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        'Sign In',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      );
    }
  }
}
