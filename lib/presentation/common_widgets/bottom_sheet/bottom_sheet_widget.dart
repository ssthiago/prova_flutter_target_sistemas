import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'bottom_sheet_store.dart';

void showCustomBottomSheet(BuildContext context) {
  final bottomSheetStore = GetIt.I<BottomSheetStore>();

  if (bottomSheetStore.isBottomSheetVisible) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () async {}, // Adicione uma função que retorna um Future
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Erro',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bottomSheetStore.errorMessage ?? 'Erro desconhecido.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
