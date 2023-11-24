import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/core/app_constants.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_data_source_impl.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalInformationDataSourceImpl', () {
    late MockSharedPreferences mockSharedPreferences;
    late ILocalAuthenticatedDataSource localInformationDataSource;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      localInformationDataSource = LocalInformationDataSourceImpl(mockSharedPreferences);
    });

    group('getSavedInformation', () {
      test('should return an empty list when no information is saved', () async {
        when(() => mockSharedPreferences.getStringList(AppConstants.savedInformationKey))
            .thenReturn([]);

        final result = await localInformationDataSource.getSavedInformation();

        expect(result, isEmpty);
      });

      test('should return a list of Information objects when information is saved', () async {
        when(() => mockSharedPreferences.getStringList(AppConstants.savedInformationKey))
            .thenReturn(['information1', 'information2']);

        final result = await localInformationDataSource.getSavedInformation();

        expect(result, isA<List<Information>>());
        expect(result[0], isA<Information>());
        expect(result[1], isA<Information>());
      });
    });

    group('saveInformation', () {
      test('should save information to shared preferences', () async {
        final Information information = Information(text: 'new information');
        when(() => mockSharedPreferences.setStringList(any(), any()))
            .thenAnswer((_) async => Future.value(true));
        await localInformationDataSource.saveInformation(information);

        when(() => mockSharedPreferences.getStringList(any())).thenReturn([information.text]);
        final List<Information> savedInformation =
            await localInformationDataSource.getSavedInformation();
        expect(savedInformation[0], information);
      });

      test('should append information', () async {
        final Information information = Information(text: 'new information');
        // Configuração do mock para SharedPreferences
        when(() => mockSharedPreferences.getStringList(any()))
            .thenReturn(['info1', 'info2', 'info3']);
        when(() => mockSharedPreferences.setStringList(any(), any()))
            .thenAnswer((_) async => Future.value(true));

        await localInformationDataSource.saveInformation(information);
        // Verifica se a função correta de SharedPreferences foi chamada
        verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
      });
    });

    group('deleteInformation', () {
      test('should delete information from shared preferences', () async {
        // Configuração do mock para SharedPreferences
        when(() => mockSharedPreferences.getStringList(any()))
            .thenReturn(['info1', 'info2', 'info3']);
        when(() => mockSharedPreferences.setStringList(any(), any()))
            .thenAnswer((_) async => Future.value(true));

        // Teste da função deleteInformation
        await localInformationDataSource.deleteInformation(Information(text: 'info2'));

        // Verifica se a função correta de SharedPreferences foi chamada
        verify(() => mockSharedPreferences.setStringList(any(), any())).called(1);
      });
    });

    group('getAuthenticatedUser', () {
      test('should return null when no authenticated user is saved', () async {
        // Configuração do mock para SharedPreferences
        when(() => mockSharedPreferences.getString(AppConstants.usernameKey)).thenReturn(null);
        when(() => mockSharedPreferences.getString(AppConstants.passwordKey)).thenReturn(null);

        final result = await localInformationDataSource.getAuthenticatedUser();

        expect(result, null);
      });

      test('should save authenticated user to shared preferences', () async {
        final authenticatedUser =
            User(id: '1', name: 'Thiago', username: 'username', password: 'password');
        // Configuração do mock para SharedPreferences
        when(() => mockSharedPreferences.setString(
                AppConstants.usernameKey, authenticatedUser.username))
            .thenAnswer((_) async => Future.value(true));
        when(() => mockSharedPreferences.setString(
                AppConstants.passwordKey, authenticatedUser.password))
            .thenAnswer((_) async => Future.value(true));

        await localInformationDataSource.saveAuthenticatedUser(
            authenticatedUser: authenticatedUser);

        verify(() =>
            mockSharedPreferences.setString(AppConstants.usernameKey, authenticatedUser.username));
        verify(() =>
            mockSharedPreferences.setString(AppConstants.passwordKey, authenticatedUser.password));
      });
    });
  });
}
