abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidators = NonEmptyStringValidator();
  final StringValidator passwordValidators = NonEmptyStringValidator();
  final invalidErrorEmailText = 'You must enter an email id';
  final invalidErrorPasswordText = 'You must enter a strong password';
}
