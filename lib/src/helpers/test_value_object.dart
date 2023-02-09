import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/errors/unexpected_value_error.dart';
import 'package:flutter_clean_domain/value_failure.dart';
import 'package:flutter_clean_domain/value_object.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/validator_mock.dart';

/// A class that represents a valid [ValueObject], intended to be used in a
/// testing context.
/// It stores separately the raw [value] and the [valueObject] that holds it,
/// for testing purposes.
class ValidValueObject<T extends Object> {
  /// The raw value contained in the [valueObject].
  final T value;

  /// The actual [ValueObject].
  final ValueObject<T> valueObject;

  /// Creates a [ValidValueObject].
  ValidValueObject({
    required this.value,
    required this.valueObject,
  });
}

/// A class that represents an invalid [ValueObject], intended to be used in a
/// testing context.
/// It stores separately the raw [value] and the [valueObject] that holds it,
/// for testing purposes.
/// It also stores the [valueFailure] related to the invalid [value].
class InvalidValueObject<T extends Object> {
  /// The raw value contained in the [valueObject].
  final T value;

  /// The actual [ValueObject].
  final ValueObject<T> valueObject;

  /// The failure caused by the [valueObject].
  final ValueFailure<T> valueFailure;

  /// Creates an [InvalidValueObject].
  InvalidValueObject({
    required this.value,
    required this.valueObject,
    required this.valueFailure,
  });
}

/// An helper function to test a valid [ValueObject].
/// It requires the raw [value] and the actual Value [object].
/// It is possible to provide a [name] that will be used in the test group
/// message.
void testValidValueObject<T extends Object>({
  final String name = "",
  required final ValueObject<T> object,
  required final T value,
}) {
  group("valid $name", () {
    group("value", () {
      test("should be a Right value", () {
        expect(object.value, isA<Right<ValueFailure<T>, T>>());
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
        expect(object.failureOrUnit, isA<Right<ValueFailure<T>, Unit>>());
      });
    });
  });
}

/// An helper function to test an invalid [ValueObject].
/// It requires the raw [value] and the actual Value [object].
void testInvalidValueObject<T extends Object>({
  required final ValueObject<T> object,
  required final T value,
}) {
  group("invalid ValueObject", () {
    group("value", () {
      test("should be a Left", () {
        expect(object.value, isA<Left<ValueFailure<T>, T>>());
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
        expect(object.failureOrUnit, isA<Left<ValueFailure<T>, Unit>>());
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
