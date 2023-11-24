// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_sheet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BottomSheetStore on _BottomSheetStoreBase, Store {
  late final _$isBottomSheetVisibleAtom = Atom(
      name: '_BottomSheetStoreBase.isBottomSheetVisible', context: context);

  @override
  bool get isBottomSheetVisible {
    _$isBottomSheetVisibleAtom.reportRead();
    return super.isBottomSheetVisible;
  }

  @override
  set isBottomSheetVisible(bool value) {
    _$isBottomSheetVisibleAtom.reportWrite(value, super.isBottomSheetVisible,
        () {
      super.isBottomSheetVisible = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_BottomSheetStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_BottomSheetStoreBaseActionController =
      ActionController(name: '_BottomSheetStoreBase', context: context);

  @override
  void showBottomSheet() {
    final _$actionInfo = _$_BottomSheetStoreBaseActionController.startAction(
        name: '_BottomSheetStoreBase.showBottomSheet');
    try {
      return super.showBottomSheet();
    } finally {
      _$_BottomSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideBottomSheet() {
    final _$actionInfo = _$_BottomSheetStoreBaseActionController.startAction(
        name: '_BottomSheetStoreBase.hideBottomSheet');
    try {
      return super.hideBottomSheet();
    } finally {
      _$_BottomSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String message) {
    final _$actionInfo = _$_BottomSheetStoreBaseActionController.startAction(
        name: '_BottomSheetStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_BottomSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isBottomSheetVisible: ${isBottomSheetVisible},
errorMessage: ${errorMessage}
    ''';
  }
}
