abstract class UseCaseResult {
  bool isSuccess;
  String? errorMessage;

  UseCaseResult({required this.isSuccess, this.errorMessage});
}
