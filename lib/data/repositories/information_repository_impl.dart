import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_information_repository.dart';

class InformationRepositoryImpl implements IInformationRepository {
  final LocalAuthenticatedDataSource localInformationDataSource;

  InformationRepositoryImpl(this.localInformationDataSource);

  @override
  Future<List<Information>> getSavedInformation() async {
    // Implementação da obtenção de informações utilizando localDataSource
    List<Information> informations = await localInformationDataSource.getSavedInformation();
    return informations;
  }

  @override
  Future<void> saveInformation(Information information) async {
    // Implementação do salvamento de informações utilizando localDataSource
    await localInformationDataSource.saveInformation(information);
  }

  @override
  Future<void> deleteInformation(Information information) async {
    // Implementação da exclusão de informações utilizando localDataSource
    await localInformationDataSource.deleteInformation(information);
  }
}
