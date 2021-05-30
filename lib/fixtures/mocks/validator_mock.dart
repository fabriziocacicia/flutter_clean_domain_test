import 'package:dartz/dartz.dart';
import 'package:flutter_clean_domain/value_failure.dart';

import 'function_mock.dart';

class ValidatorMock<T extends Object>
    extends FunctionMock<Either<ValueFailure<T>, T>, T> {}
