import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/errors/unexpected_value_error.dart';
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

void testValidValueObject<T extends Object>({
  final String name = "",
  required final ValueObject<T> object,
  required final T value,
}) {
  group("valid $name", () {
    group("value", () {
      test("should be a Right value", () {
        expect(object.value, isA<Right>());
      });
    });

    group("getOrCrash", () {
      test("should return the stored value", () {
        expect(object.getOrCrash(), equals(value));
      });
    });

    group("isValid", () {
      test("should return true", () {
        expect(object.isValid(), equals(true));
      });
    });

    group("failureOrUnit", () {
      test("should return a Right", () {
        expect(object.failureOrUnit, isA<Right>());
      });
    });
  });
}

void testInvalidValueObject<T extends Object>({
  required final ValueObject<T> object,
  required final value,
}) {
  group("invalid ValueObject", () {
    group("value", () {
      test("should be a Left", () {
        expect(object.value, isA<Left>());
      });
    });

    group("getOrCrash", () {
      test("should throw an UnexpectedValueError", () {
        expect(() => object.getOrCrash(), throwsA(isA<UnexpectedValueError>()));
      });
    });

    group("isValid", () {
      test("should return false", () {
        expect(object.isValid(), equals(false));
      });
    });

    group("failureOrUnit", () {
      test("should return a Left", () {
        expect(object.failureOrUnit, isA<Left>());
      });
    });
  });
}

@Deprecated(
  'Use testValidValueObject and testInvalidValueObject instead. Will be '
  'removed in v2.0.0',
)
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
