import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova_flutter_target_sistemas/data/providers/authentication_repository_provider.dart';
import 'package:prova_flutter_target_sistemas/data/repositories/authentication_repository_impl.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';
import 'package:prova_flutter_target_sistemas/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'data/datasource/remote/api/dio/dio_client_api.dart';
import 'data/datasource/remote/api/i_client_api.dart';
import 'data/datasource/remote/authentication_datasource_impl.dart';
import 'data/datasource/remote/i_authentication_datasource.dart';
import 'domian/repositories/i_authentication_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IClientApi>(
          create: (_) => DioClientApi(),
        ),
        Provider<IAuthenticationDataSource>(
          create: (context) => AuthenticationDataSourceImpl(
            clientApi: Provider.of<IClientApi>(context, listen: false),
          ),
        ),
        Provider<IAuthenticationRepository>(
          create: (context) => AuthenticationRepositoryImpl(
            Provider.of<IAuthenticationDataSource>(context, listen: false),
          ),
        ),
        Provider<LoginUseCase>(
          create: (context) {
            LoginUseCase loginUseCase = LoginUseCase(
              Provider.of<IAuthenticationRepository>(context, listen: false),
            );
            return loginUseCase;
          },
        ),
        Provider<LoginStore>(
          create: (_) =>
              LoginStore(loginUseCase: Provider.of<LoginUseCase>(context, listen: false)),
        ),
      ],
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
        title: 'Prova Flutter Target Sistemas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: LoginPage(),
      ),
    );
  }
}
