import 'package:academiapp/app/modules/coba/views/coba_view.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/widgets/error_screen.dart';
import 'package:academiapp/app/widgets/loading_screen.dart';
import 'package:academiapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
// final BehaviorSubject<MyApp> didReceiveLocalNotificationSubject =
//     BehaviorSubject<MyApp>();

// final BehaviorSubject<String?> selectNotificationSubject =
//     BehaviorSubject<String?>();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

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
    loginController.firstInitialize();

    return GetMaterialApp(
      home: CobaView(),
    );
    // return FutureBuilder(
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     //check for errors
    //     if (snapshot.hasError) {
    //       return const ErrorScreen();
    //     }
    //     // once complete, show ur applications
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return FutureBuilder(
    //         future: loginController.firstInitialize(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             return Obx(() => GetMaterialApp(
    //                   theme: ThemeData.light(),
    //                   debugShowCheckedModeBanner: false,
    //                   initialRoute: loginController.isAuth.value == true
    //                       ? Routes.MAIN
    //                       : Routes.LOGIN,
    //                   // home: AllScheduleView(),
    //                   getPages: AppPages.routes,
    //                 ));
    //           }
    //           return FutureBuilder(
    //               // future: loginController.firstInitialize(),
    //               future: Future.delayed(Duration.zero),
    //               builder: (context, snapshot) => LoadingScreen());
    //         },
    //       );
    //     }
    //     return const LoadingScreen();
    //   },
    // );
  }
}
