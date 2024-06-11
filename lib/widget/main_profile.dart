import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedule_with/domain/repository/user_repository.dart';
import 'package:schedule_with/ui/mypage/controller/mypage_controller.dart';
import 'package:schedule_with/ui/mypage/widget/my_page_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/colors/color.dart';
import '../entity/user_tbl.dart';
import '../ui/mypage/widget/nick_name_controller.dart';

class MainProfile extends StatefulWidget {

  const MainProfile({super.key});

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  // var _textEditingController = TextEditingController();
  final MyPageController myPageController = Get.find<MyPageController>();


  var user_nickname = TextEditingController();

  UserRepository userRepository = UserRepository();
  Users? users;

  // 배경 이미지
  XFile? _backgroundImage;
  // 프로필 이미지
  XFile? _profileImage;

  final ImagePicker picker = ImagePicker();

  @override void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    users = await userRepository.getUserInfoUseId(prefs.getString('id')!);
    myPageController.text.value = "${users?.name}";
    ever(myPageController.userUpdated, (_) {
      _initializeUser(); // Re-fetch user info and update UI
    }); // 사용자 정보를 가져온 후 UI를 업데이트하기 위해 setState 호출
  }

  // 배경 이미지를 가져오는 함수
  void getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      if(mounted){
        setState(() {
          _backgroundImage = XFile(pickedFile.path);
        });
      }
    }
  }

  // 프로필 이미지를 가져오는 함수
  void getProfileImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      if(mounted){
        setState(() {
          _profileImage = XFile(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // GetXController 등록
    final NickNameController controller = Get.put(NickNameController());
    return Stack(
      children: [
        // 배경 이미지
        Padding(
          padding: EdgeInsets.only(bottom: 35),
          child: InkWell(
            onTap: () {
              Get.toNamed('/myPageBackgroundPhotoDetail', arguments: users?.back_img);
            },
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: grey2,
                // child 로 배경 이미지 설정
                child: users?.back_img == null ? Image.asset("lib/assets/image/image2.png",fit: BoxFit.cover)
                    : Image.file(File(users!.back_img!),fit: BoxFit.cover)
            ),
          ),
        ),
        // 프로필 + 이름 + 수정 아이콘
        Positioned(
            bottom: 0,
            left: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 프로필
                InkWell(
                  onTap: () {
                    Get.toNamed('/myPageProfilePhotoDetail', arguments: users?.profile_img);
                  },
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(color: grey2,width: 0.5)
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: users?.profile_img == null ? Icon(CupertinoIcons.person_fill, color: mainBrown.withOpacity(0.5))
                              : Image.file(File(users!.profile_img!),fit: BoxFit.cover,)
                      )
                  ),
                ),
                // 이름 및 수정 아이콘
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 이름
                        Obx((){
                          return controller.nickNameChangeState.value ? Container(
                            color: Colors.white,
                            width: 100,
                            height: 25,
                            child: TextField(
                              decoration: InputDecoration(border: InputBorder.none,isDense: true),
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,decorationThickness: 0),
                              autofocus: true,
                              controller: myPageController.textEditingController,
                            ),

                          )
                              : Text(
                              myPageController.text.value,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                          );

                        }),
                        // 수정 아이콘
                        Obx((){
                          return controller.nickNameChangeState.value ? Container() : InkWell(
                            onTap: ()  {
                              // 아이콘을 눌렀을 때
                              Get.dialog(MyPageAlert(
                                onBackgroundImageSelected: (selectedImage) async {
                                  users?.back_img = selectedImage.path;
                                  await userRepository.updateUserInfo(users!, users!.idx);
                                  setState(() {
                                  });
                                },
                                onProfileImageSelected: (selectedImage) async {
                                  users?.profile_img = selectedImage.path;
                                  await userRepository.updateUserInfo(users!, users!.idx);
                                  setState((){
                                  });
                                },
                              ));
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                              child: SvgPicture.asset("lib/assets/icon/icon_pen.svg"),
                            ),
                          );
                        })
                      ],
                    )
                ),
              ],
            )
        ),
      ],
    );
  }
}
