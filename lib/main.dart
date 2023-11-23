import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:prova_flutter_target_sistemas/data/repositories/authentication_repository_impl.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';
import 'package:prova_flutter_target_sistemas/routes/app_routes.dart';

import 'data/datasource/remote/api/dio/dio_client_api.dart';
import 'data/datasource/remote/api/i_client_api.dart';
import 'data/datasource/remote/authentication_datasource_impl.dart';
import 'data/datasource/remote/i_authentication_datasource.dart';
import 'domian/repositories/i_authentication_repository.dart';
import 'presentation/common_widgets/bottom_sheet/bottom_sheet_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  GetIt getIt = GetIt.I;

  //registra e inicializa o DioCLientApi
  GetIt.instance.registerLazySingleton<IClientApi>(() {
    DioClientApi clientApi = DioClientApi();
    clientApi.init();
    return clientApi;
  });

  getIt.registerSingleton<BottomSheetStore>(BottomSheetStore());
  getIt.registerSingleton<IAuthenticationDataSource>(
      AuthenticationDataSourceImpl(clientApi: getIt.get<IClientApi>()));
  getIt.registerSingleton<IAuthenticationRepository>(
      AuthenticationRepositoryImpl(getIt.get<IAuthenticationDataSource>()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt.get<IAuthenticationRepository>()));
  getIt.registerSingleton<LoginStore>(LoginStore(
      loginUseCase: getIt.get<LoginUseCase>(), bottomSheetStore: getIt.get<BottomSheetStore>()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'Prova Flutter Target Sistemas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: LoginPage(),
    );
  }
}
