import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/flutter_clean_domain.dart';
import 'package:flutter_clean_domain_test/flutter_clean_domain_test.dart';

class IntValueObject extends ValueObject<int> {
  final Either<ValueFailure<int>, int> _value;

  IntValueObject(Either<ValueFailure<int>, int> value) : _value = value;
  @override
  Either<ValueFailure<int>, int> get value => _value;
}

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
  final int validIntValue = 10;
  final validIntValues = <int>[12, 13, 14, 15];
  final int invalidIntValue = 5;
  final invalidIntValues = <int>[0, 1, 2, 3];

  final IntValueFailure valueFailure =
      IntValueFailure(invalidValue: invalidIntValue);

  testValidatorOnValidValue<int>(
    "should return a Right when 10 is passed",
    validator: intValidator,
    validValue: validIntValue,
  );

  testValidatorOnInvalidValue<int>(
    "should return a Left when 5 is passed",
    validator: intValidator,
    invalidValue: invalidIntValue,
    valueFailureFactory: (invalidValue) =>
        IntValueFailure(invalidValue: invalidValue),
  );

  testValidatorOnValidValues<int>(
    "test intValidator on valid values",
    validator: intValidator,
    validValues: validIntValues,
  );

  testValidatorOnInvalidValues<int>(
    "test intValidator on invalid values",
    validator: intValidator,
    invalidValues: invalidIntValues,
    valueFailureFactory: (invalidValue) =>
        IntValueFailure(invalidValue: invalidValue),
  );
}
