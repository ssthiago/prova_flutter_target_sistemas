import 'result.dart';

abstract class Failure extends Result {
  Failure(String message) : super(message);
}
