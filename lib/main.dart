import 'package:app_piloto/core/depedencies/app_piloto_dependencies.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initCore();
  await registerMicroAppDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Firebase.initializeApp(),
        initCore(),
        registerMicroAppDependencies(),
      ]),
      builder: (context, snapshot) {
        return MaterialApp(
          home: const HomeScreen(),
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.amber[500],
          ),
        );
      },
    );
  }
}
