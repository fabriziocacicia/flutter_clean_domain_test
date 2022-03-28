import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/flutter_clean_domain.dart';
import 'package:test/test.dart';

/// Tests the given [validator] in the case of a valid value.
/// Checks that it properly returns a [Right] containing the given [validValue].
///
/// It is possible to specify a [message], which will be used as test description.
/// If [message] is not passed a default description is used.
void testValidatorOnValidValue<T extends Object>(
  String? message, {
  required final Either<ValueFailure<T>, T> Function(T) validator,
  required final T validValue,
}) {
  if (message == null || message.isEmpty) {
    message = "should return a Right when a valid value is passed";
  }

  test(message, () {
    final validationResult = validator(validValue);

    expect(validationResult, Right<ValueFailure<T>, T>(validValue));
  });
}

/// Test the given [validator] over multiple valid values.
///
/// It is possible to specify a [message], which will be used as description
/// of the test group. If [message] is not passed a default description is used.
void testValidatorOnValidValues<T extends Object>(
  String? message, {
  required final Either<ValueFailure<T>, T> Function(T) validator,
  required final Iterable<T> validValues,
}) {
  if (message == null || message.isEmpty) {
    message = "test validator on valid values";
  }
  group(message, () {
    for (final validValue in validValues) {
      testValidatorOnValidValue(
        "should return a Right when $validValue is passed",
        validator: validator,
        validValue: validValue,
      );
    }
  });
}

/// Tests the given [validator] on the case of an invalid value.
/// Checks that the return is a [Left] containing a specific [valueFailure]
/// which in turn contains the [invalidValue].
///
/// [valueFailureFactory] should create the [ValueFailure] containing the
/// invalid value being tested.
///
/// It is possible to specify a [message], which will be used as test description.
/// If [message] is not passed a default description is used.
void testValidatorOnInvalidValue<T extends Object>(
  String? message, {
  required final Either<ValueFailure<T>, T> Function(T) validator,
  required final T invalidValue,
  required final ValueFailure<T> Function(T invalidValue) valueFailureFactory,
}) {
  if (message == null || message.isEmpty) {
    message = "should return a Left containing a value failure when an invalid "
        "value is passed";
  }

  test(message, () {
    final validationResult = validator(invalidValue);

    expect(validationResult,
        Left<ValueFailure<T>, T>(valueFailureFactory(invalidValue)));
  });
}

/// Test the given [validator] over multiple invalid values.
///
/// [valueFailureFactory] should create the [ValueFailure] containing the
/// invalid value being tested.
///
/// It is possible to specify a [message], which will be used as description
/// of the test group. If [message] is not passed a default description is used.
void testValidatorOnInvalidValues<T extends Object>(
  String? message, {
  required final Either<ValueFailure<T>, T> Function(T) validator,
  required final Iterable<T> invalidValues,
  required final ValueFailure<T> Function(T invalidValue) valueFailureFactory,
}) {
  if (message == null || message.isEmpty) {
    message = "test validator on invalid values";
  }

  group(message, () {
    for (final invalidValue in invalidValues) {
      testValidatorOnInvalidValue(
        "should return a Left when $invalidValue is passed",
        validator: validator,
        invalidValue: invalidValue,
        valueFailureFactory: valueFailureFactory,
      );
    }
  });
}
