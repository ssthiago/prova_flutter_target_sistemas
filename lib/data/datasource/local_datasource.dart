import 'package:prova_flutter_target_sistemas/data/models/imformation_model.dart';
import 'package:prova_flutter_target_sistemas/data/models/user_model.dart';

abstract class LocalDataSource {
  Future<List<InformationModel>> getSavedInformation();
  Future<void> saveInformation(InformationModel information);
  Future<void> deleteInformation(InformationModel information);
  Future<bool> authenticateUser(UserModel user);
}
