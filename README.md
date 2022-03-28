# flutter_clean_domain_test

A package that provides a testing framework for packages that depends on flutter_clean_domain

## Usage
### Test a validator
A validator is a function used by a `ValueObject` to make sure that the value it stores is valid.
In case the value is valid it returns a `Right` containing it; otherwise it returns a `Left`
containing a `ValueFailure` which in turn contains the invalid value.

The package provides helper functions for testing both the case of valid and invalid values.

#### Test the case of a valid value
Use the `testValidatorOnValidValue` helper function. 

Pass your validator function as argument and provide the valid value you want to test
your validator to.

```dart
  testValidatorOnValidValue<ValueType>(
    "a message that describe the test",
    validator: myValidator,
    validValue: aValidValue,
);
```

#### Test multiple valid values at once
Use the `testValidatorOnValidValues` helper function.

Pass your validator function as argument and provide the valid values you want to test
your validator to. The function accepts any `Iterable` on the `validValues` argument, but you 
should prefer to pass a `List`.

```dart
    
testValidatorOnValidValues<ValueType>(
    "a message that describe the test group",
    validator: myValidator,
    validValues: [validValue1, validValue2, validValue3],
 );
```

#### Test the case of an invalid value
Use the `testValidatorOnInvalidValue` helper function.

Pass your validator function as argument and provide the invalid value you want to test
your validator to. 
You also have to pass a factory function that builds the `ValueFailure` that
you expect the validator should return when called with that specific invalid value.

```dart
  testValidatorOnInvalidValue<ValueType>(
    "a message that describe the test",
    validator: myValidator,
    invalidValue: anInvalidValue,
    valueFailureFactory: (invalidValue) =>
        AValueFailure(invalidValue: invalidValue),
  );
```

#### Test multiple invalid values at once

Use the `testValidatorOnInvalidValues` helper function.

Pass your validator function as argument and provide the invalid values you want to test
your validator to. The function accepts any `Iterable` on the `invalidValues` argument, but you
should prefer to pass a `List`.

You also have to pass a factory function that builds the `ValueFailure` that
you expect the validator should return when called with that specific invalid value.

```dart
  testValidatorOnInvalidValues<int>(
    "a message that describe the test group",
    validator: myValidator,
    invalidValues: [invalidValue1, invalidValue2, invalidValue3],
    valueFailureFactory: (invalidValue) =>
      AValueFailure(invalidValue: invalidValue),
  );
```