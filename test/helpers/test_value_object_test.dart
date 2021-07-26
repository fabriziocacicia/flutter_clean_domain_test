import 'dart:collection';

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

class HashSetIntValueObject extends ValueObject<HashSet<int>> {
  final Either<ValueFailure<HashSet<int>>, HashSet<int>> _value;

  HashSetIntValueObject(Either<ValueFailure<HashSet<int>>, HashSet<int>> value)
      : _value = value;

  @override
  Either<ValueFailure<HashSet<int>>, HashSet<int>> get value => _value;
}

void main() {
  group("testValidValueObject", () {
    final validValue = 0;
    final validValueObject = MockValueObject(Right(validValue));

    testValidValueObject<int>(object: validValueObject, value: validValue);

    final validHashSet = HashSet<int>.from(<int>{1, 2, 3});
    final validHashSetValueObject = HashSetIntValueObject(Right(validHashSet));

    testValidValueObject(
      object: validHashSetValueObject,
      value: validHashSet,
    );
  });

  group("testInvalidValueObjectButFailures", () {
    final invalidValue = -1;
    final invalidValueObject =
        MockValueObject(Left(MockValueFailure(invalidValue)));

    testInvalidValueObject(object: invalidValueObject, value: invalidValue);
  });
}
