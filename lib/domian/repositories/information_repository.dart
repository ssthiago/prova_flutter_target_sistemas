import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';

abstract class InformationRepository {
  Future<List<Information>> getSavedInformation();
  Future<void> saveInformation(Information information);
  Future<void> deleteInformation(Information information);
}
