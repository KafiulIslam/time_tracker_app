import 'package:android_time_tracker/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.email,
      this.password,
      this.formType,
      this.isLoading,
      this.submitted});
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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
    return showErrorText ? invalidErrorPasswordText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidators.isValid(email);
    return showErrorText ? invalidErrorEmailText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
