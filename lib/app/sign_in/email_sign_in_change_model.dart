import 'package:android_time_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:android_time_tracker/app/sign_in/validators.dart';
import 'package:android_time_tracker/services/auth.dart';
import 'package:flutter/cupertino.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel(
      {@required this.auth,
      this.email,
      this.password,
      this.formType,
      this.isLoading,
      this.submitted});
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      // await Future.delayed(Duration(seconds: 1));
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account first';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account.Register'
        : 'Have an account.Sign In';
  }

  bool get canSubmit {
    return emailValidators.isValid(email) &&
        passwordValidators.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidators.isValid(password);
    return showErrorText ? invalidErrorPasswordText : NonEmptyStringValidator();
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidators.isValid(email);
    return showErrorText ? invalidErrorEmailText : NonEmptyStringValidator();
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) {
    updateWith(email: email);
  }

  void updatePassword(String password) {
    updateWith(password: password);
  }

  EmailSignInChangeModel updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
    return EmailSignInChangeModel(auth: auth);
    // return EmailSignInChangeModel(auth: auth);
  }
}
