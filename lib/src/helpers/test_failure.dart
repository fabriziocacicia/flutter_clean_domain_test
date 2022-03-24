import 'package:flutter_clean_domain/value_failure.dart';
import 'package:test/test.dart';

/// An helper function to test a [ValueFailure].
/// It accepts the raw [invalidValue] and the [failure] containing it.
void testValueFailure<T extends Object>({
  required T invalidValue,
  required ValueFailure<T> failure,
}) {
  test("should contain the invalid value", () {
    expect(failure.invalidValue, invalidValue);
  });
}
