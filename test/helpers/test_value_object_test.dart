import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/value_failure.dart';
import 'package:flutter_clean_domain/value_object.dart';
import 'package:flutter_clean_domain_test/src/helpers/test_value_object.dart';

class IntValueObject extends ValueObject<int> {
  final Either<ValueFailure<int>, int> _value;

  IntValueObject(Either<ValueFailure<int>, int> value) : _value = value;

  @override
  Either<ValueFailure<int>, int> get value => _value;
}

class IntValueFailure extends ValueFailure<int> {
  IntValueFailure({required super.invalidValue});
}

void main() {
  final int value = 0;
  final IntValueObject validObject = IntValueObject(Right(value));

  testValidValueObject<int>(
    name: "value object",
    value: value,
    object: validObject,
  );

  final IntValueObject invalidObject =
      IntValueObject(Left(IntValueFailure(invalidValue: value)));
  testInvalidValueObject<int>(
    value: value,
    object: invalidObject,
  );
}
