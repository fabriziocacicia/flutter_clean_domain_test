import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/flutter_clean_domain.dart';
import 'package:flutter_clean_domain_test/flutter_clean_domain_test.dart';
import 'package:test/test.dart';

class MockValueObject extends ValueObject<int> {
  final Either<ValueFailure<int>, int> _value;

  MockValueObject(Either<ValueFailure<int>, int> value) : _value = value;

  @override
  Either<ValueFailure<int>, int> get value => _value;
}

class MockValueFailure extends ValueFailure<int> {
  MockValueFailure(int invalidValue) : super(invalidValue: invalidValue);
}

void main() {
  group("testValidValueObject", () {
    final validValue = 0;
    final validValueObject = MockValueObject(Right(validValue));

    testValidValueObject<int>(object: validValueObject, value: validValue);
  });

  group("testInvalidValueObjectButFailures", () {
    final invalidValue = -1;
    final invalidValueObject =
        MockValueObject(Left(MockValueFailure(invalidValue)));

    testInvalidValueObject(object: invalidValueObject, value: invalidValue);
  });
}
