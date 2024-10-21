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
  runApp(
    FutureBuilder(
      builder: (context, snap) {
        return MaterialApp(
          home: const DashBoardScreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.amber[500],
          ),
        );
      },
      future: Future.wait(
        [
          Firebase.initializeApp(),
          initCore(),
          registerMicroAppDependencies(),
        ],
      ),
    ),
  );
}

// void main() async {
//   Widget build(BuildContext context) {
//     WidgetsFlutterBinding.ensureInitialized();

//     return FutureBuilder(
//       future: Future.wait(
//         [
//           Firebase.initializeApp(),
//           initCore(),
//           registerMicroAppDependencies(),
//         ],
//       ),
//       builder: (ctx, snap) => ScreenUtilInit(
//         designSize: const Size(375, 812),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (BuildContext context, Widget? child) {
//           return MaterialApp(
//             home: const DashBoardScreen(),
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               brightness: Brightness.light,
//               primaryColor: Colors.amber[500],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
