import 'package:flutter/material.dart';
import 'package:my_childrens_voice_app/home/home.dart';

Future<void> main() async {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
