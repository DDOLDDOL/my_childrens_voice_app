import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/authentication/authentication.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/guardian.dart';
import 'package:my_childrens_voice_app/home/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenHive = await TokenHive.build();
  final apiClient = RestApiClient(tokenHive);

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();

  // await FirebaseMessaging.instance.getToken();
  //
  // FirebaseMessaging.onMessage.listen(
  //   (remoteMessage) async {
  //     print('message!!');
  //     NotificationRepository()
  //       ..init()
  //       ..push(
  //         1,
  //         remoteMessage.category ?? '',
  //         remoteMessage.category ?? '',
  //       );
  //
  //     final message = remoteMessage.toString();
  //     print('fcm message: $message');
  //   },
  // );

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: tokenHive),
        Provider.value(value: apiClient),
        Provider.value(value: FlutterSoundRecorder()),
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
          create: (context) => RecorderRepository(
            context.read<FlutterSoundRecorder>(),
          ),
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
        RepositoryProvider(
          create: (context) => GuardianRepository(
            context.read<RestApiClient>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0D7071),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            titleTextStyle: TextStyles.appBarTitleLarge,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          scaffoldBackgroundColor: const Color(0xFFF4F5F9),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}