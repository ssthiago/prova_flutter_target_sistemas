import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';

class InformationModel {
  final String text;

  InformationModel({required this.text});

  factory InformationModel.fromEntity(Information information) {
    return InformationModel(text: information.text);
  }

  Information toEntity() {
    return Information(text: text);
  }
}
