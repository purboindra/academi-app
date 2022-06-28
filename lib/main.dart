import 'package:academiapp/app/modules/add_schedule/views/add_schedule_view.dart';
import 'package:academiapp/app/modules/home/views/home_view.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/modules/login/views/login_view.dart';
import 'package:academiapp/app/modules/main/controllers/main_controller.dart';
import 'package:academiapp/app/modules/main/views/main_view.dart';
import 'package:academiapp/app/widgets/error_screen.dart';
import 'package:academiapp/app/widgets/loading_screen.dart';
import 'package:academiapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final loginC = Get.put(LoginController());
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //check for errors
        if (snapshot.hasError) {
          return const ErrorScreen();
        }
        // once complete, show ur applications
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => GetMaterialApp(
                    theme: ThemeData.light(),
                    debugShowCheckedModeBanner: false,
                    initialRoute: loginController.isAuth.isTrue
                        ? Routes.HOME
                        : Routes.LOGIN,
                    getPages: AppPages.routes,
                  ),
                );
              }
              return FutureBuilder(
                  future: loginController.firstInitialize(),
                  builder: (context, snapshot) => LoadingScreen());
            },
          );
        }
        return const LoadingScreen();
      },
    );
  }
}
