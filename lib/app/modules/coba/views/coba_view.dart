import 'package:academiapp/app/theme/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coba_controller.dart';

class CobaView extends GetView<CobaController> {
  @override
  Widget build(BuildContext context) {
    var activeIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Coba View"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Card(
            elevation: 2,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              padding: EdgeInsets.symmetric(
                // horizontal: 5,
                vertical: 10,
              ),
              width: Get.width,
              height: 350,
              // color: Colors.grey.shade200,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //for indicator and divider
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: activeIndex == 0
                                  ? Colors.red
                                  : Colors.grey.shade700,
                              radius: 7,
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: activeIndex != 0
                                    ? Colors.red
                                    : Colors.grey.shade700,
                                thickness: 1,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: activeIndex != 0
                                  ? Colors.red
                                  : Colors.grey.shade700,
                              radius: 7,
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: activeIndex != 0
                                    ? Colors.red
                                    : Colors.grey.shade700,
                                thickness: 1,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: activeIndex != 0
                                  ? Colors.red
                                  : Colors.grey.shade700,
                              radius: 7,
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: activeIndex != 0
                                    ? Colors.red
                                    : Colors.black,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //for keterangan
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: titleStyle.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            text: "(SYSTEM-AUTOMATIC) ",
                                          ),
                                          TextSpan(
                                            style: subTitleStyle.copyWith(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            text: "24-11-2020 23:32 WIB",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Transaksi Selesai, Dana akan diteruskan ke penjual",
                                      style: subTitleStyle.copyWith(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: titleStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            text: "(BUYER) ",
                                          ),
                                          TextSpan(
                                            style: subTitleStyle.copyWith(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            text: "24-11-2020 23:32 WIB",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Transaksi telah dikonfirmasi pembeli dan menunggu review Tokopedia",
                                      style: subTitleStyle.copyWith(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: titleStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            text: "(SYSTEM-TRACKER) ",
                                          ),
                                          TextSpan(
                                            style: subTitleStyle.copyWith(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            text: "24-11-2020 23:32 WIB",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Pesanan telah tiba di tujuan. Received by Ida Bagus Ketut Adiyoga",
                                      style: subTitleStyle.copyWith(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
