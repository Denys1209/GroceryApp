import 'package:bloc_project_test/config/routes/routes.dart';
import 'package:bloc_project_test/config/theme/app_themes.dart';
import 'package:bloc_project_test/domain/repository/product_repository.dart';
import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:bloc_project_test/featues/add_product_screen/cubit/product_cubit.dart';
import 'package:bloc_project_test/featues/home/bloc/home_bloc.dart';
import 'package:bloc_project_test/featues/home/ui/home.dart';
import 'package:bloc_project_test/featues/sign_up/ui/sign_up_page.dart';
import 'package:bloc_project_test/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userRepository = UserRepository();
  runApp(MyApp(
    authenticationRepository: userRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required UserRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final UserRepository _authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
              create: (context) => HomeBloc() // replace with your repository
              ),
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(ProductRepository()),
          ),
        ],
        child: MaterialApp(
          theme: theme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const Home();
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SignUpPage();
            },
          ),
        ),
      ),
    );
  }
}
