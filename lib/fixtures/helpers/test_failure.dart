import 'package:flutter_clean_domain/value_failure.dart';
import 'package:test/test.dart';

void testValueFailure<T extends Object>({
  required T invalidValue,
  required ValueFailure<T> failure,
}) {
  test("should be a ValueFailure", () {
    expect(failure, isA<ValueFailure>());
  });

  test("should contain the invalid value", () {
    expect(failure.invalidValue, invalidValue);
  });
}
