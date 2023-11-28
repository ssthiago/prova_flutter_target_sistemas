import 'package:prova_flutter_target_sistemas/domian/repositories/i_information_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/i_usecase.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/information/save_information/result/save_information_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/information/save_information/result/save_information_success.dart';

import 'result/save_information_failure.dart';

class SaveInformationUseCase implements IUseCase<SaveInformationParams, Result> {
  final IInformationRepository repository;

  SaveInformationUseCase(this.repository);

  @override
  Future<Result> call(SaveInformationParams params) async {
    try {
      await repository.saveInformation(params.information);
      return SaveInformationSuccess(information: params.information);
    } catch (e) {
      return SaveInformationFailure('Erro ao salvar a informação');
    }
  }
}
