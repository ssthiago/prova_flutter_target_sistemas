import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/result/success.dart';

class SaveInformationSuccess extends Success {
  Information? information;

  SaveInformationSuccess({
    this.information,
    String message = '',
  }) : super(message);
}
