import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_information_repository.dart';

class SaveInformation {
  final IInformationRepository repository;

  SaveInformation(this.repository);

  Future<void> call(Information information) async {
    // Implementação da lógica de salvamento de informações
    await repository.saveInformation(information);
  }
}
