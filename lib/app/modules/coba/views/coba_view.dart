import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:academiapp/app/widgets/input_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coba_controller.dart';

class CobaView extends GetView<CobaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CobaView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () {},
                    autocorrect: false,
                    cursorColor: Get.isDarkMode
                        ? Colors.grey.shade100
                        : Colors.grey.shade700,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w10,
                        vertical: Dimensions.h15,
                      ),
                      suffixIcon: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(Dimensions.w10 - 3),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      suffixIconColor: greyColor,
                      iconColor: primaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.w10 - 3),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.w10 - 3),
                      ),
                      hintText: "hint",
                      hintStyle: subTitleStyle.copyWith(
                        color: darkGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.shopping_bag,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            //Gridview
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: Dimensions.w30 * 6,
                    mainAxisSpacing: Dimensions.w10,
                    crossAxisSpacing: Dimensions.h10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          "Example $index",
                          style: titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
