import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/authentication/authentication.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/home/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final tokenHive = await TokenHive.build();
  final apiClient = RestApiClient(apiUrl, tokenHive);

  Bloc.observer = MyBlocObserver();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: tokenHive),
        Provider.value(value: apiClient),
      ],
      child: const _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HomeRepository(context.read<RestApiClient>()),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationRepository(
            context.read<RestApiClient>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CaregiverRepository(
            context.read<RestApiClient>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0D7071),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
