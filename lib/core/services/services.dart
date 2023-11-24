import 'package:get_it/get_it.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/dio/dio_client_api.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/i_client_api.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/authentication_datasource_impl.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/i_authentication_datasource.dart';
import 'package:prova_flutter_target_sistemas/data/repositories/authentication_repository_impl.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/bottom_sheet/bottom_sheet_store.dart';
import 'package:prova_flutter_target_sistemas/presentation/informations/informations_store.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Classe responsavel por inicializar as dependências do projeto
class Services {
  static Future<void> init() async {
    GetIt getIt = GetIt.I;

    GetIt.instance.registerLazySingleton<IClientApi>(() {
      DioClientApi clientApi = DioClientApi();
      clientApi.init();
      return clientApi;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(sharedPreferences);

    getIt.registerSingleton<BottomSheetStore>(BottomSheetStore());
    getIt.registerSingleton<IAuthenticationDataSource>(
        AuthenticationDataSourceImpl(clientApi: getIt.get<IClientApi>()));
    getIt.registerSingleton<IAuthenticationRepository>(
        AuthenticationRepositoryImpl(getIt.get<IAuthenticationDataSource>()));
    getIt
        .registerSingleton<IUserSessionManager>(UserSessionManager(getIt.get<SharedPreferences>()));
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt.get<IAuthenticationRepository>(), getIt.get<IUserSessionManager>()),
    );
    getIt.registerSingleton<LoginStore>(LoginStore(
        loginUseCase: getIt.get<LoginUseCase>(), bottomSheetStore: getIt.get<BottomSheetStore>()));

    getIt.registerSingleton<InformationsStore>(InformationsStore());
  }
}
