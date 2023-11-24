import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';

abstract class IInformationsManager {
  Future<Map<String, List<Information>>> getInformationMap();
  Future<void> addInformation(String userId, Information information);
  Future<void> editInformation(String userId, int index, Information newInformation);
  Future<void> removeInformation(String userId, int index);
}
