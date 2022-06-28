import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (loginC) {
          return loginC.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/welcome.png"),
                                SizedBox(
                                  height: Dimensions.h30,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    primary: primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.login();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_google.png',
                                        width: 32,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Sign In With Google',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Academiapp",
                                style: titleStyle.copyWith(
                                  color: darkGrey,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Version 1.1.1',
                                style: subTitleStyle.copyWith(
                                  color: darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ]),
                    // ],
                  ),
                );
        },
      ),
    );
  }
}
