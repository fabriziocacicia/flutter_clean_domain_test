import 'package:mocktail/mocktail.dart';

/// Mocks a standalone function
// ignore: one_member_abstracts
abstract class FunctionMock<R extends Object, T extends Object> extends Mock {
  R call(T value);
}
