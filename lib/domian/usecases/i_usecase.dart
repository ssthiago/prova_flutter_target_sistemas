abstract class IUseCase<Params, Result> {
  Future<Result> call(Params params);
}
