## UNRELEASED

- Updated dependencies:
  - `dart_lint_rules`: v0.2.0

## 1.5.2

- Updated dependencies:
  - `flutter_clean_domain`: v1.3.0
  - `dart_lint_rules`: v0.1.0

## 1.5.1

- Fix an issue that prevents the usage of the validator helper functions

## 1.5.0

- Add helper functions to test validators: `testValidatorOnValidValue`, `testValidatorOnValidValues`,
  `testValidatorOnInvalidValue`, `testValidatorOnInvalidValues`

## 1.4.1

- Fix an issue causing the failure of `pub get` for packages
that but depend on `flutter_clean_domain` and `flutter_clean_domain_test`

## 1.4.0

- Update `mocktail` dependency to `0.3.0`

## 1.3.0

- Added the `name` parameter to the `testValidValueObject`
- Fixed an issue in the `testValidValueObject` that caused the test of the `value` getter always
fails

## 1.2.0

- Added two new helper functions to test `ValueObject`s: `testValidValueObject` and 
`testInvalidValueObject`
- Deprecated the `testValueObject` in favor of the two new ones

## 1.1.0

- Hide the sources and add the exports of the public api


## 1.0.0

- The first stable release
