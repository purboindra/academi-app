import 'package:get/get.dart';

import '../modules/add_schedule/bindings/add_schedule_binding.dart';
import '../modules/add_schedule/views/add_schedule_view.dart';
import '../modules/all_schedule/bindings/all_schedule_binding.dart';
import '../modules/all_schedule/views/all_schedule_view.dart';
import '../modules/coba/bindings/coba_binding.dart';
import '../modules/coba/views/coba_view.dart';
import '../modules/detail_schedule/bindings/detail_schedule_binding.dart';
import '../modules/detail_schedule/views/detail_schedule_view.dart';
import '../modules/edit_schedule/bindings/edit_schedule_binding.dart';
import '../modules/edit_schedule/views/edit_schedule_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  // static String routesAddSchedule(int pageId, String page) {
  //   return "${Routes.ADD_SCHEDULE}?pageId=${pageId}&page=$page";
  // }

  // static String routesMain(int pageId, String page) {
  //   return "${Routes.MAIN}?pageId=${pageId}&page=$page";
  // }

  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SCHEDULE,
      page: () {
        return AddScheduleView();
      },
      binding: AddScheduleBinding(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () {
        return MainView();
      },
      binding: MainBinding(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.DETAIL_SCHEDULE,
      page: () => DetailScheduleView(),
      binding: DetailScheduleBinding(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.EDIT_SCHEDULE,
      page: () => EditScheduleView(),
      binding: EditScheduleBinding(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.ALL_SCHEDULE,
      page: () => AllScheduleView(),
      binding: AllScheduleBinding(),
    ),
    GetPage(
      name: _Paths.COBA,
      page: () => CobaView(),
      binding: CobaBinding(),
    ),
  ];
}
