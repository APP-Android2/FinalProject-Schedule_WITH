import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../assets/colors/color.dart';

class MyPageBackgroundPhotoDetail extends StatefulWidget {
  const MyPageBackgroundPhotoDetail({super.key});

  @override
  State<MyPageBackgroundPhotoDetail> createState() => _MyPageBackgroundPhotoDetailState();
}

class _MyPageBackgroundPhotoDetailState extends State<MyPageBackgroundPhotoDetail> {

  final String? _image = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: Container(),
          // 타이틀
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "배경사진",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 8),
                child: SvgPicture.asset("lib/assets/icon/icon_cancel.svg",color: Colors.white),
              ),
            )
          ],

        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        // child 로 배경 이미지 설정
        child: _image == null ? Image.asset("lib/assets/image/image2.png",fit: BoxFit.fitWidth,)
            : Image.file(File(_image),fit: BoxFit.fitWidth)
      ),
    );
  }
}
