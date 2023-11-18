import 'package:prova_flutter_target_sistemas/core/app_constants.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalInformationDataSourceImpl implements ILocalAuthenticatedDataSource {
  final SharedPreferences sharedPreferences;

  LocalInformationDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<Information>> getSavedInformation() async {
    final List<String>? savedInformation =
        sharedPreferences.getStringList(AppConstants.savedInformationKey);
    return savedInformation?.map((info) => Information(text: info)).toList() ?? [];
  }

  @override
  Future<void> saveInformation(Information information) async {
    List<Information> informations = await getSavedInformation();
    List<String> currentInformation = informations.map((info) => info.text).toList();
    currentInformation.add(information.text);
    await sharedPreferences.setStringList(AppConstants.savedInformationKey, currentInformation);
  }

  @override
  Future<void> deleteInformation(Information information) async {
    List<Information> informations = await getSavedInformation();
    List<String> currentInformation = informations.map((info) => info.text).toList();
    currentInformation.remove(information.text);
    await sharedPreferences.setStringList(AppConstants.savedInformationKey, currentInformation);
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    // Lógica para salvar informações de autenticação
    String? username = sharedPreferences.getString(AppConstants.usernameKey);
    String? password = sharedPreferences.getString(AppConstants.passwordKey);
    return username != null && password != null
        ? User(username: username, password: password)
        : null;
  }

  @override
  Future<void> saveAuthenticatedUser({required User authenticatedUser}) async {
    // Lógica para salvar informações de autenticação
    await sharedPreferences.setString('username', authenticatedUser.username);
    await sharedPreferences.setString('password', authenticatedUser.password);
  }
}
