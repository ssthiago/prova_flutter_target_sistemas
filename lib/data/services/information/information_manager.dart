import 'dart:convert';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationsManager {
  static const String _infoKey = 'info_map';
  final SharedPreferences sharedPreferences;

  InformationsManager(this.sharedPreferences);

  // Carrega o mapa de informações armazenadas no SharedPreferences
  Future<Map<String, List<Information>>> getInformationMap() async {
    final infoJson = sharedPreferences.getString(_infoKey);
    if (infoJson != null) {
      final Map<String, dynamic> infoMap = json.decode(infoJson);
      return infoMap.map((key, value) {
        final List<dynamic> infoList = List<dynamic>.from(value);
        return MapEntry(key, infoList.map((info) => Information.fromJson(info)).toList());
      });
    }
    return {};
  }

  // Adiciona uma nova informação ao mapa associada ao usuário
  Future<void> addInformation(String userId, Information information) async {
    final Map<String, List<Information>> currentMap = await getInformationMap();

    if (!currentMap.containsKey(userId)) {
      currentMap[userId] = [];
    }

    currentMap[userId]?.add(information);

    // Salva o mapa atualizado no SharedPreferences
    await sharedPreferences.setString(
        _infoKey,
        json.encode(currentMap
            .map((key, value) => MapEntry(key, value.map((info) => info.toJson()).toList()))));
  }

  // Edita uma informação no mapa associada ao usuário
  Future<void> editInformation(String userId, int index, Information newInformation) async {
    final Map<String, List<Information>> currentMap = await getInformationMap();

    if (currentMap.containsKey(userId) && index >= 0 && index < currentMap[userId]!.length) {
      currentMap[userId]![index] = newInformation;
    }

    // Salva o mapa atualizado no SharedPreferences
    await sharedPreferences.setString(
        _infoKey,
        json.encode(currentMap
            .map((key, value) => MapEntry(key, value.map((info) => info.toJson()).toList()))));
  }

  // Remove uma informação do mapa associada ao usuário
  Future<void> removeInformation(String userId, int index) async {
    final Map<String, List<Information>> currentMap = await getInformationMap();

    if (currentMap.containsKey(userId) && index >= 0 && index < currentMap[userId]!.length) {
      currentMap[userId]!.removeAt(index);
    }

    // Salva o mapa atualizado no SharedPreferences
    await sharedPreferences.setString(
        _infoKey,
        json.encode(currentMap
            .map((key, value) => MapEntry(key, value.map((info) => info.toJson()).toList()))));
  }
}
