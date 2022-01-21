import 'package:android_time_tracker/app/sign_in/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });
}
