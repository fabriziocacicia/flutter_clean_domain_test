import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/flutter_clean_domain.dart';
import 'package:flutter_clean_domain_test/src/helpers/test_validator.dart';

class IntValueFailure extends ValueFailure<int> {
  IntValueFailure({required int invalidValue})
      : super(invalidValue: invalidValue);
}

Either<ValueFailure<int>, int> intValidator(final int value) {
  return value >= 10
      ? Right(value)
      : Left(IntValueFailure(invalidValue: value));
}

void main() {
  testValidatorOnValidValue<int>(
    "testValidatorOnValidValue",
    validator: intValidator,
    validValue: 11,
  );

  testValidatorOnValidValues<int>(
    "testValidatorOnValidValues",
    validator: intValidator,
    validValues: [11, 50, 100],
  );

  testValidatorOnInvalidValue<int>(
    "testValidatorOnInvalidValue",
    validator: intValidator,
    invalidValue: 0,
    valueFailureFactory: (invalidValue) =>
        IntValueFailure(invalidValue: invalidValue),
  );

  testValidatorOnInvalidValues<int>(
    "testValidatorOnInvalidValues",
    validator: intValidator,
    invalidValues: [-1, -10, 0],
    valueFailureFactory: (invalidValue) =>
        IntValueFailure(invalidValue: invalidValue),
  );
}
