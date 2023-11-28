import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';

abstract class Validate {
  static String? textInformacao(String value, {required String label}) {
    String? haveMinCharacters = _haveMinCharacters(value, label: label);
    if (haveMinCharacters != null) return haveMinCharacters;
    String? haveEmptyCharactersResult = _haveEmptyCharacters(value, label: label);
    if (haveEmptyCharactersResult != null) return haveEmptyCharactersResult;

    return null;
  }

  static String? username(String value, {required String label}) {
    String? haveEmptyCharactersResult = _haveEmptyCharacters(value, label: label);
    if (haveEmptyCharactersResult != null) return haveEmptyCharactersResult;

    String? haveMinCharacters = _haveMinCharacters(value, label: label);
    if (haveMinCharacters != null) return haveMinCharacters;

    String? haveMaxCharacters = _haveMaxCharacters(value, label: label);
    if (haveMaxCharacters != null) return haveMaxCharacters;

    String? haveEndWithSpace = _haveEndWithSpace(value, label: label);
    if (haveEndWithSpace != null) return haveEndWithSpace;

    return null;
  }

  static String? password(String value, {required String label}) {
    String? haveEmptyCharactersResult = _haveEmptyCharacters(value, label: label);
    if (haveEmptyCharactersResult != null) return haveEmptyCharactersResult;

    String? haveMinCharacters = _haveMinCharacters(value, label: label);
    if (haveMinCharacters != null) return haveMinCharacters;

    String? haveMaxCharacters = _haveMaxCharacters(value, label: label);
    if (haveMaxCharacters != null) return haveMaxCharacters;

    String? havePasswordSpecialCharacters = _havePasswordSpecialCharacters(value, label: label);
    if (havePasswordSpecialCharacters != null) return havePasswordSpecialCharacters;

    String? haveEndWithSpace = _haveEndWithSpace(value, label: label);
    if (haveEndWithSpace != null) return haveEndWithSpace;

    return null;
  }

  static String? _haveEmptyCharacters(String value, {required String label}) {
    if (value.isEmpty) return '$label ${StringsConstants.senhaNaoVazia}';
    return null;
  }

  static String? _haveMinCharacters(String value, {required String label, int minCharacters = 2}) {
    if (value.length < minCharacters) return StringsConstants.senhaMenorQue2Caracteres;
    return null;
  }

  static String? _haveMaxCharacters(String value, {required String label, int maxCharacters = 20}) {
    if (value.length > maxCharacters) return StringsConstants.senhaMaiorQue20Caracteres;
    return null;
  }

  static String? _havePasswordSpecialCharacters(String value, {required String label}) {
    if (value.contains(RegExp(r'[^a-zA-Z0-9\s]+'))) {
      return '$label ${StringsConstants.proibidoCaracteresEspeciais}';
    }
    return null;
  }

  static String? _haveEndWithSpace(String value, {required String label}) {
    if (value.endsWith(' ')) return '$label ${StringsConstants.espacoBrancoFinal}';
    return null;
  }
}
