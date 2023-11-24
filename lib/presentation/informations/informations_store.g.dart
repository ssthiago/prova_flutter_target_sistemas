// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InformationsStore on InformationsStoreBase, Store {
  late final _$textAtom =
      Atom(name: 'InformationsStoreBase.text', context: context);

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  late final _$infoListAtom =
      Atom(name: 'InformationsStoreBase.infoList', context: context);

  @override
  ObservableList<Information> get infoList {
    _$infoListAtom.reportRead();
    return super.infoList;
  }

  @override
  set infoList(ObservableList<Information> value) {
    _$infoListAtom.reportWrite(value, super.infoList, () {
      super.infoList = value;
    });
  }

  late final _$addInformationAsyncAction =
      AsyncAction('InformationsStoreBase.addInformation', context: context);

  @override
  Future<void> addInformation() {
    return _$addInformationAsyncAction.run(() => super.addInformation());
  }

  late final _$editInformationAsyncAction =
      AsyncAction('InformationsStoreBase.editInformation', context: context);

  @override
  Future<void> editInformation(
      Information oldInformation, Information newInformation) {
    return _$editInformationAsyncAction
        .run(() => super.editInformation(oldInformation, newInformation));
  }

  late final _$removeInformationAsyncAction =
      AsyncAction('InformationsStoreBase.removeInformation', context: context);

  @override
  Future<void> removeInformation(Information information, int index) {
    return _$removeInformationAsyncAction
        .run(() => super.removeInformation(information, index));
  }

  late final _$InformationsStoreBaseActionController =
      ActionController(name: 'InformationsStoreBase', context: context);

  @override
  void setText(String value) {
    final _$actionInfo = _$InformationsStoreBaseActionController.startAction(
        name: 'InformationsStoreBase.setText');
    try {
      return super.setText(value);
    } finally {
      _$InformationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text},
infoList: ${infoList}
    ''';
  }
}
