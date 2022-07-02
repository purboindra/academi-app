import 'package:academiapp/app/theme/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coba_controller.dart';

class CobaView extends GetView<CobaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coba View"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  purpleColor,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(
                    top: 50,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: blueColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Belanja",
                        style: subTitleStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Pengiriman",
                        style: subTitleStyle.copyWith(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Pembayaran",
                        style: subTitleStyle.copyWith(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                          ),
                          width: Get.width,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 300,
                                bottom: 0,
                                top: 0,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width - 80,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orange,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.error_outline,
                                          color: Colors.white,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    style: subTitleStyle,
                                                    text:
                                                        "Paket Anava\'s Secret Night Calm",
                                                  ),
                                                  TextSpan(
                                                    style: subTitleStyle,
                                                    text: " ",
                                                  ),
                                                  TextSpan(
                                                    style:
                                                        subTitleStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    text: "(12)",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: blueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "2",
                                                        style: subTitleStyle
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Icon(
                                                  Icons.discount,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    style: subTitleStyle
                                                        .copyWith(),
                                                    text: "Harga : ",
                                                  ),
                                                  TextSpan(
                                                    style: subTitleStyle
                                                        .copyWith(),
                                                    text: " ",
                                                  ),
                                                  TextSpan(
                                                    style: titleStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    text: "Rp 1,260,000,-",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
