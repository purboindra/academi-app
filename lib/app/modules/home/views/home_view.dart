import 'package:academiapp/app/controller/schedule_controller.dart';
import 'package:academiapp/app/model/schedule_model.dart';
import 'package:academiapp/app/modules/add_schedule/controllers/add_schedule_controller.dart';
import 'package:academiapp/app/modules/login/controllers/login_controller.dart';
import 'package:academiapp/app/routes/app_pages.dart';
import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/utils/app_constant.dart';
import 'package:academiapp/app/utils/notifications_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final box = GetStorage();
  final scheduleC = Get.put(ScheduleController());
  final loginC = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> listSchedule = [];
    Get.put(AddScheduleController());
    Get.put(LoginController());
    Get.put(HomeController());
    Get.find<AddScheduleController>();

    var lisOfSchedule = <ScheduleModel>[].obs;
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    final List<String> text = ["Schedule", "KRS", "Forum", "Consultation"];

    final List<Icon> icon = [
      Icon(
        Icons.format_list_numbered_outlined,
        size: 32,
      ),
      Icon(
        Icons.pending_actions,
        size: 32,
      ),
      Icon(
        Icons.people,
        size: 32,
      ),
      Icon(
        Icons.phone_in_talk,
        size: 32,
      ),
    ];

    final List colors = [
      Color(0xffF2D7D9),
      Color(0xffADCF9F),
      Color(0xffF4E06D),
      Color(0xffF2D1D1),
      Color(0xffFF8080),
    ];
    return Scaffold(
      body: Stack(
        children: [
          _backgroundHeader(),
          SizedBox(
            height: Dimensions.h20,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    _profile(),
                    SizedBox(
                      height: Dimensions.h30 * 1.2,
                    ),
                    _banner(imgList, context),
                    _category(text, colors, icon),
                    SizedBox(
                      height: Dimensions.h20,
                    ),
                    Text(
                      "Schedule",
                      style: subHeadingStyle.copyWith(),
                    ),
                    SizedBox(
                      height: Dimensions.h10,
                    ),
                    _scheduleList(),

                    // SizedBox(
                    //   height: Dimensions.h10,
                    // ),
                    // Obx(
                    //   () => Wrap(
                    //     children: List.generate(
                    //       3,
                    //       (index) => CheckboxListTile(
                    //         title: Text(controller.names[index]),
                    //         value:
                    //             controller.check.value == index ? true : false,
                    //         // value: controller.isSelec.value,
                    //         onChanged: (check) {
                    //           // controller.checkBox(index).value;
                    //           // controller.addCheck(index);
                    //           controller.checkBox(index).refresh();
                    //           print(controller.names);
                    //           // print(value);
                    //           // controller.isSelec.value = check!;
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _scheduleList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: controller.scheduleStream(loginC.user.value.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length != 0) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: Dimensions.h30 * 8,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length <= 5
                          ? snapshot.data!.docs.length
                          : 5,
                      itemBuilder: ((context, index) {
                        var data = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAIL_SCHEDULE,
                              arguments: snapshot.data!.docs[index],
                            );
                          },
                          child: Container(
                            width: Dimensions.w30 * 12,
                            padding: EdgeInsets.all(
                              Dimensions.h10 + Dimensions.h5,
                            ),
                            margin: EdgeInsets.only(
                              right: Dimensions.w20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(
                                Dimensions.w10,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${data["course"]}",
                                        style: subHeadingStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.w20,
                                    ),
                                    Text(
                                      "${data["status"]}",
                                      style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: data["status"] == "Done"
                                            ? primaryColor
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/schedule.png",
                                      width: Dimensions.w30 * 2,
                                    ),
                                    SizedBox(
                                      width: Dimensions.w5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${data["startTime"]} - ${data["endTime"]}",
                                        style: titleStyle.copyWith(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.h10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/class.png",
                                      width: Dimensions.w30 * 1.3,
                                    ),
                                    SizedBox(
                                      width: Dimensions.w10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${data["classCourse"]}",
                                        style: titleStyle.copyWith(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.w5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  snapshot.data!.docs.length >= 5
                      ? InkWell(
                          onTap: () => Get.toNamed(
                            Routes.ALL_SCHEDULE,
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 2,
                                color: darkGrey,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.chevron_right,
                                size: Dimensions.w30 + 5,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            );
          }
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Oops Sorry, Something Wrong"),
          );
        }
        return Container(
          width: Get.width,
          height: Dimensions.h30 * 5,
          child: Center(
            child: Text(
              "You haven\'t schedule yet",
              style: titleStyle.copyWith(),
            ),
          ),
        );
      },
    );
  }

  Container _category(
      List<String> text, List<dynamic> colors, List<Icon> icon) {
    return Container(
      width: Get.width,
      height: Dimensions.h30 * 2.8,
      margin: EdgeInsets.only(
        top: Dimensions.h20,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: text.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              if (text[index] == "Schedule") {
                Get.toNamed(Routes.ALL_SCHEDULE);
              } else {
                print(text[index]);
              }
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.h10),
              margin: EdgeInsets.only(
                right: Dimensions.w10,
              ),
              width: Dimensions.w20 * 10,
              // height: Dimensions.h30 * 2.8,
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(
                  Dimensions.w10,
                ),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: Dimensions.w30 * 2,
                      height: Dimensions.h30 * 2,
                      color: Colors.white,
                      child: Center(
                        child: icon[index],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.w10,
                  ),
                  Expanded(
                    child: Text(
                      "${text[index]}",
                      style: titleStyle.copyWith(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Column _banner(List<String> imgList, BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller.carouselController,
          items: imgList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.h10,
                    ),
                    color: primaryColor,
                    image: DecorationImage(
                      image: NetworkImage("${i}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "University News",
                      style: subHeadingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              controller.pageChanged(index);
            },
            height: Dimensions.h30 * 4,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Obx(
          () => Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      controller.carouselController.animateToPage(entry.key),
                  child: Container(
                    width: controller.currentIndex.value == entry.key
                        ? Dimensions.w20
                        : 12,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.h10,
                      horizontal: Dimensions.w5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        controller.currentIndex.value == entry.key
                            ? Dimensions.w10
                            : Dimensions.w30,
                      ),
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : primaryColor)
                          .withOpacity(
                        controller.currentIndex.value == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Container _profile() {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.h10,
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.w30 * 2.5,
            height: Dimensions.h30 * 2.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${loginC.user.value.photoUrl}"),
                fit: BoxFit.cover,
              ),
              color: greyColor,
              borderRadius: BorderRadius.circular(Dimensions.h30 * 2),
            ),
          ),
          SizedBox(
            width: Dimensions.w10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${loginC.user.value.name}",
                style: titleStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${loginC.user.value.status}",
                style: subTitleStyle.copyWith(
                  color: greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 40,
            child: Text(
              "AcademiApp",
              style: subHeadingStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _backgroundHeader() {
    return Container(
      width: Dimensions.w,
      height: Dimensions.h30 * 8.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.w10),
          bottomRight: Radius.circular(Dimensions.w10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            blueColor,
            purpleColor,
          ],
        ),
      ),
    );
  }
}
