// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$usernameAtom =
      Atom(name: 'LoginStoreBase.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'LoginStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  void setUsername(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToInformationPage(BuildContext context) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.goToInformationPage');
    try {
      return super.goToInformationPage(context);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
password: ${password}
    ''';
  }
}
