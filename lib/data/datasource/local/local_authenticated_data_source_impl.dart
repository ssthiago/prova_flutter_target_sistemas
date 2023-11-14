import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_datasource.dart';
import 'package:prova_flutter_target_sistemas/data/models/imformation_model.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalInformationDataSourceImpl implements LocalAuthenticatedDataSource {
  final SharedPreferences sharedPreferences;

  LocalInformationDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<InformationModel>> getSavedInformation() async {
    final List<String>? savedInformation = sharedPreferences.getStringList('saved_information');
    return savedInformation?.map((info) => InformationModel(text: info)).toList() ?? [];
  }

  @override
  Future<void> saveInformation(InformationModel information) async {
    List<InformationModel> informations = await getSavedInformation();
    List<String> currentInformation = informations.map((info) => info.text).toList();
    currentInformation.add(information.text);
    await sharedPreferences.setStringList('saved_information', currentInformation);
  }

  @override
  Future<void> deleteInformation(InformationModel information) async {
    List<InformationModel> informations = await getSavedInformation();
    List<String> currentInformation = informations.map((info) => info.text).toList();
    currentInformation.remove(information.text);
    await sharedPreferences.setStringList('saved_information', currentInformation);
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    // Lógica para salvar informações de autenticação
    String? username = sharedPreferences.getString('username');
    String? password = sharedPreferences.getString('password');
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
