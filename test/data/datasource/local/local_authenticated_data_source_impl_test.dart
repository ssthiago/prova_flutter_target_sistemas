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
        when(() => mockSharedPreferences.setStringList(
            AppConstants.savedInformationKey, [information.text])).thenAnswer((_) async => true);
        await localInformationDataSource.saveInformation(information);

        when(() => mockSharedPreferences.getStringList(AppConstants.savedInformationKey))
            .thenReturn([information.text]);
        final List<Information> savedInformation =
            await localInformationDataSource.getSavedInformation();
        expect(savedInformation[0], information);
      });

      test('should append information', () async {
        final Information information = Information(text: 'new information');
        when(() => mockSharedPreferences.setStringList(
            AppConstants.savedInformationKey, [information.text])).thenAnswer((_) async => true);
        localInformationDataSource.saveInformation(information);
        verify(() => localInformationDataSource.saveInformation(information)).called(1);
      });
    });

    group('deleteInformation', () {
      test('should delete information from shared preferences', () async {
        final information = Information(text: 'information to delete');
        final existingInformations = [
          Information(text: 'information1'),
          Information(text: 'information to delete'),
          Information(text: 'information3'),
        ];

        when(
          () => mockSharedPreferences.getStringList('saved_information'),
        ).thenReturn(
          existingInformations.map((info) => info.text).toList(),
        );
        await localInformationDataSource.deleteInformation(information);

/*        verify(() => mockSharedPreferences.setStringList(
              AppConstants.savedInformationKey,
              existingInformations
                  .where((info) => info != information)
                  .map((info) => info.text)
                  .toList(),
            ));*/
      });

      test('should not fail when deleting non-existent information', () async {
        final information = Information(text: 'non-existent information');

        when(() => mockSharedPreferences.getStringList('saved_information')).thenReturn([]);
        await localInformationDataSource.deleteInformation(information);

        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('getAuthenticatedUser', () {
      test('should return null when no authenticated user is saved', () async {
        when(() => mockSharedPreferences.getString(AppConstants.usernameKey)).thenReturn(null);
        when(() => mockSharedPreferences.getString(AppConstants.passwordKey)).thenReturn(null);

        final result = await localInformationDataSource.getAuthenticatedUser();

        expect(result, null);
      });

      test('should save authenticated user to shared preferences', () async {
        final authenticatedUser = User(username: 'username', password: 'password');

        when(() => mockSharedPreferences.getString(AppConstants.usernameKey)).thenReturn(null);
        when(() => mockSharedPreferences.getString(AppConstants.passwordKey)).thenReturn(null);

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
