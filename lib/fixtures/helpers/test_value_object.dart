import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/value_failure.dart';
import 'package:flutter_clean_domain/value_object.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/validator_mock.dart';

class ValidValueObject<T extends Object> {
  final T value;
  final ValueObject<T> valueObject;

  ValidValueObject({
    required this.value,
    required this.valueObject,
  });
}

class InvalidValueObject<T extends Object> {
  final T value;
  final ValueObject<T> valueObject;
  final ValueFailure<T> valueFailure;

  InvalidValueObject({
    required this.value,
    required this.valueObject,
    required this.valueFailure,
  });
}

void testValueObject<T extends Object>({
  required ValidValueObject<T> validObject,
  required InvalidValueObject<T> invalidObject,
  required ValidatorMock<T> validate,
}) {
  when(() => validate(validObject.value)).thenReturn(Right(validObject.value));
  when(() => validate(invalidObject.value))
      .thenReturn(Left(invalidObject.valueFailure));

  test("should be a Value Object", () {
    expect(validObject.valueObject, isA<ValueObject>());
    expect(invalidObject.valueObject, isA<ValueObject>());
  });

  group("value", () {
    test("should contain either a Failure or a value", () {
      expect(validObject.valueObject.value, isA<Either<ValueFailure, T>>());
      expect(invalidObject.valueObject.value, isA<Either<ValueFailure, T>>());
    });

    test("should always contain only validated text values", () {
      expect(validObject.valueObject.value, validate(validObject.value));
      expect(invalidObject.valueObject.value, validate(invalidObject.value));
    });
  });
}
