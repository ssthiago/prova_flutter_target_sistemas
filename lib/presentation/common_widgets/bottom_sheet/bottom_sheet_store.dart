// bottom_sheet_store.dart
import 'package:mobx/mobx.dart';

part 'bottom_sheet_store.g.dart';

class BottomSheetStore = _BottomSheetStoreBase with _$BottomSheetStore;

abstract class _BottomSheetStoreBase with Store {
  @observable
  bool isBottomSheetVisible = false;

  @observable
  String? errorMessage;

  @action
  void showBottomSheet() {
    isBottomSheetVisible = true;
  }

  @action
  void hideBottomSheet() {
    isBottomSheetVisible = false;
    errorMessage = null; // Limpar a mensagem de erro ao ocultar o BottomSheet
  }

  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }
}
