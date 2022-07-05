import 'package:academiapp/app/theme/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coba_controller.dart';

class CobaView extends GetView<CobaController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CobaController());
    return Scaffold(
      body: Column(
        children: [
          //for appbar
          Container(
            width: Get.width,
            height: 100,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  blueColor,
                  purpleColor,
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Member Baru",
                    style: titleStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //for body
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_add,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Data Pengundang",
                            style: titleStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nomor ID",
                                style: subTitleStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Masukan Nomor Mitra Anda",
                                style: subTitleStyle.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(
                              isDense: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.card_membership,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Data Member",
                                style: titleStyle.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() => FieldData(
                                // index: controller.indexField.value,
                                suffixText: "Masukan Kata Sandi",
                                prefixText: "Kata Sandi",
                                icon: InkWell(
                                  onTap: () {
                                    controller.obsecureTextKataSandi.value =
                                        !controller.obsecureTextKataSandi.value;
                                  },
                                  child: Icon(
                                    controller.obsecureTextKataSandi.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              )),
                          Obx(() => FieldData(
                                suffixText: "Masukan Ulang Kata Sandi",
                                prefixText: "Konfirmasi Kata Sandi",
                                icon: InkWell(
                                  onTap: () {
                                    controller.obsecureTextKonfirmKataSandi
                                            .value =
                                        !controller
                                            .obsecureTextKonfirmKataSandi.value;
                                  },
                                  child: Icon(
                                    controller
                                            .obsecureTextKonfirmKataSandi.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              )),
                          FieldData(
                            suffixText: "Masukan Nama Anda",
                            prefixText: "Nama Lengkap",
                          ),
                          FieldData(
                            suffixText: "No.Identitas",
                            prefixText: "Pilih Identitas",
                            icon: Icon(
                              Icons.chevron_right,
                            ),
                            readOnly: true,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Masukan No. Identitas Anda (16 digit)",
                              hintStyle: subTitleStyle.copyWith(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FieldData(
                            suffixText: "Masukan Tempat Lahir Anda",
                            prefixText: "Tempat Lahir",
                          ),
                          FieldData(
                            readOnly: true,
                            suffixText: "",
                            prefixText: "Jenis Kelamin",
                            icon: DropdownButton(
                                hint: Text(
                                  "Pilih Jenis Kelamin",
                                  style: subTitleStyle.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                isDense: true,
                                icon: Icon(
                                  Icons.chevron_right,
                                ),
                                items: controller.itemJenisKelamin
                                    .map<DropdownMenuItem<String>>((items) {
                                  return DropdownMenuItem<String>(
                                      value: items.toString(),
                                      child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                }),
                          ),
                          FieldData(
                            suffixText: "Masukan Alamat Anda",
                            prefixText: "Alamat",
                          ),
                          FieldData(
                            suffixText: "",
                            prefixText: "Provinsi",
                            icon: DropdownButton(
                                hint: Text(
                                  "Pilih Jenis Kelamin",
                                  style: subTitleStyle.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                isDense: true,
                                icon: Icon(
                                  Icons.chevron_right,
                                ),
                                items: controller.itemJenisKelamin
                                    .map<DropdownMenuItem<String>>((items) {
                                  return DropdownMenuItem<String>(
                                      value: items.toString(),
                                      child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                }),
                            readOnly: true,
                          ),
                          FieldData(
                            suffixText: "",
                            prefixText: "Kota/Kabupaten",
                            icon: DropdownButton(
                                hint: Text(
                                  "Pilih Jenis Kelamin",
                                  style: subTitleStyle.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                isDense: true,
                                icon: Icon(
                                  Icons.chevron_right,
                                ),
                                items: controller.itemJenisKelamin
                                    .map<DropdownMenuItem<String>>((items) {
                                  return DropdownMenuItem<String>(
                                      value: items.toString(),
                                      child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                }),
                            readOnly: true,
                          ),
                          FieldData(
                            suffixText: "",
                            prefixText: "Kecamatan",
                            icon: DropdownButton(
                                hint: Text(
                                  "Pilih Jenis Kelamin",
                                  style: subTitleStyle.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                isDense: true,
                                icon: Icon(
                                  Icons.chevron_right,
                                ),
                                items: controller.itemJenisKelamin
                                    .map<DropdownMenuItem<String>>((items) {
                                  return DropdownMenuItem<String>(
                                      value: items.toString(),
                                      child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                }),
                            readOnly: true,
                          ),
                          FieldData(
                            suffixText: "Masukan Nama Kelurahan Anda",
                            prefixText: "Keluaran",
                          ),
                          FieldData(
                            suffixText: "Masukan Kode Pos",
                            prefixText: "Kode Pos",
                          ),
                          FieldData(
                            suffixText: "Masukan Nomor HP Anda",
                            prefixText: "No. Hp",
                          ),
                          FieldData(
                            suffixText: "Masukan Email Anda",
                            prefixText: "Email",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldData extends StatelessWidget {
  final String suffixText;
  final String prefixText;
  final IconData? prefixIcon;
  final Widget? icon;
  final void Function()? onTap;
  bool readOnly;

  FieldData({
    Key? key,
    required this.suffixText,
    required this.prefixText,
    this.prefixIcon,
    this.icon,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cobaC = Get.find<CobaController>();
    return Container(
      margin: EdgeInsets.only(
        bottom: suffixText == "No.Identitas" ? 10 : 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prefixText,
                style: subTitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    suffixText,
                    style: subTitleStyle.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  icon != null ? icon! : SizedBox(),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Obx(
            () => TextField(
              onTap: onTap,
              obscureText: prefixText == "Kata Sandi"
                  ? cobaC.obsecureTextKataSandi.value
                  : cobaC.obsecureTextKonfirmKataSandi.value,
              readOnly: readOnly,
              decoration: InputDecoration(
                isCollapsed: true,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//  SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//           child: Card(
//             elevation: 2,
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                 vertical: 20,
//               ),
//               padding: EdgeInsets.symmetric(
//                 // horizontal: 5,
//                 vertical: 10,
//               ),
//               width: Get.width,
//               height: 350,
//               // color: Colors.grey.shade200,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //for indicator and divider
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: activeIndex == 0
//                                   ? Colors.red
//                                   : Colors.grey.shade700,
//                               radius: 7,
//                             ),
//                             Expanded(
//                               child: VerticalDivider(
//                                 color: activeIndex != 0
//                                     ? Colors.red
//                                     : Colors.grey.shade700,
//                                 thickness: 1,
//                               ),
//                             ),
//                             CircleAvatar(
//                               backgroundColor: activeIndex != 0
//                                   ? Colors.red
//                                   : Colors.grey.shade700,
//                               radius: 7,
//                             ),
//                             Expanded(
//                               child: VerticalDivider(
//                                 color: activeIndex != 0
//                                     ? Colors.red
//                                     : Colors.grey.shade700,
//                                 thickness: 1,
//                               ),
//                             ),
//                             CircleAvatar(
//                               backgroundColor: activeIndex != 0
//                                   ? Colors.red
//                                   : Colors.grey.shade700,
//                               radius: 7,
//                             ),
//                             Expanded(
//                               child: VerticalDivider(
//                                 color: activeIndex != 0
//                                     ? Colors.red
//                                     : Colors.black,
//                                 thickness: 1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         //for keterangan
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             style: titleStyle.copyWith(
//                                               color: Colors.red,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             text: "(SYSTEM-AUTOMATIC) ",
//                                           ),
//                                           TextSpan(
//                                             style: subTitleStyle.copyWith(
//                                               fontSize: 13,
//                                               color: Colors.grey.shade600,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             text: "24-11-2020 23:32 WIB",
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "Transaksi Selesai, Dana akan diteruskan ke penjual",
//                                       style: subTitleStyle.copyWith(
//                                         fontSize: 13,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             style: titleStyle.copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             text: "(BUYER) ",
//                                           ),
//                                           TextSpan(
//                                             style: subTitleStyle.copyWith(
//                                               fontSize: 13,
//                                               color: Colors.grey.shade600,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             text: "24-11-2020 23:32 WIB",
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "Transaksi telah dikonfirmasi pembeli dan menunggu review Tokopedia",
//                                       style: subTitleStyle.copyWith(
//                                         fontSize: 13,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             style: titleStyle.copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             text: "(SYSTEM-TRACKER) ",
//                                           ),
//                                           TextSpan(
//                                             style: subTitleStyle.copyWith(
//                                               fontSize: 13,
//                                               color: Colors.grey.shade600,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             text: "24-11-2020 23:32 WIB",
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "Pesanan telah tiba di tujuan. Received by Ida Bagus Ketut Adiyoga",
//                                       style: subTitleStyle.copyWith(
//                                         fontSize: 13,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
