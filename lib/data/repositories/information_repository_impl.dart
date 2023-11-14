import 'package:prova_flutter_target_sistemas/data/datasource/local_datasource.dart';
import 'package:prova_flutter_target_sistemas/data/models/imformation_model.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/information_repository.dart';

class InformationRepositoryImpl implements InformationRepository {
  final LocalDataSource localDataSource;

  InformationRepositoryImpl(this.localDataSource);

  @override
  Future<List<Information>> getSavedInformation() async {
    // Implementação da obtenção de informações utilizando localDataSource
    List<InformationModel> information = await localDataSource.getSavedInformation();
    return information.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveInformation(Information information) async {
    // Implementação do salvamento de informações utilizando localDataSource
    await localDataSource.saveInformation(InformationModel.fromEntity(information));
  }

  @override
  Future<void> deleteInformation(Information information) async {
    // Implementação da exclusão de informações utilizando localDataSource
    await localDataSource.deleteInformation(InformationModel.fromEntity(information));
  }
}
