import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_information_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/information/save_information/result/save_information_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/information/save_information/result/save_information_success.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/information/save_information/save_information_usecase.dart';

class MockInformationRepository extends Mock implements IInformationRepository {}

void main() {
  group('saveInformation', () {
    late MockInformationRepository mockInformationRepository;
    late SaveInformationUseCase saveInformationUseCase;

    setUp(() {
      mockInformationRepository = MockInformationRepository();
      saveInformationUseCase = SaveInformationUseCase(mockInformationRepository);
    });

    test('should return SaveInformationSuccess when information is saved', () async {
      // Arrange - Configura o comportamento esperado
      final params = SaveInformationParams(information: Information(text: 'text'));
      when(() => mockInformationRepository.saveInformation(params.information))
          .thenAnswer((_) async => ());

      //Act - Executa a ação
      Result result = await saveInformationUseCase(params);

      // Assert - Verifica o comportamento
      expect(result, isA<SaveInformationSuccess>());
      expect((result as SaveInformationSuccess).information, isNotNull);
      verify(() => mockInformationRepository.saveInformation(params.information)).called(1);
      verifyNoMoreInteractions(mockInformationRepository);
    });
  });
}
