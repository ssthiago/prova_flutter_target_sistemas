import 'package:prova_flutter_target_sistemas/data/models/imformation_model.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class LocalAuthenticatedDataSource {
  Future<void> saveAuthenticatedUser({required User authenticatedUser});
  Future<User?> getAuthenticatedUser();
  Future<List<InformationModel>> getSavedInformation();
  Future<void> saveInformation(InformationModel information);
  Future<void> deleteInformation(InformationModel information);
}
