import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class ILocalAuthenticatedDataSource {
  Future<void> saveAuthenticatedUser({required User authenticatedUser});
  Future<User?> getAuthenticatedUser();
  Future<List<Information>> getSavedInformation();
  Future<void> saveInformation(Information information);
  Future<void> deleteInformation(Information information);
}
