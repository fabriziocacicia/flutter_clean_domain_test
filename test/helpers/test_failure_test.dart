import 'package:flutter_clean_domain/flutter_clean_domain.dart';
import 'package:flutter_clean_domain_test/src/helpers/test_failure.dart';
import 'package:test/test.dart';

class IntValueFailure extends ValueFailure<int> {
  IntValueFailure({required super.invalidValue});
}

void main() {
  group("testValueFailure", () {
    // arrange
    final int invalidValue = 0;
    final ValueFailure<int> failure =
        IntValueFailure(invalidValue: invalidValue);

    // assert
    testValueFailure<int>(invalidValue: invalidValue, failure: failure);
  });
}
