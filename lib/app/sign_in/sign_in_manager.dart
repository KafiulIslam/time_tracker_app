import 'dart:async';
import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/foundation.dart';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<Kuser> _signIn(Future<Kuser> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<Kuser> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<Kuser> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);
}
