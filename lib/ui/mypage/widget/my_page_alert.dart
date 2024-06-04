// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:schedule_with/assets/colors/color.dart';
// import 'package:schedule_with/ui/mypage/widget/my_page_divider.dart';
// import 'package:schedule_with/widget/main_profile.dart';
// import 'nick_name_controller.dart';
//
//
// class MyPageAlert extends StatefulWidget {
//
//   final void Function(XFile) onBackgroundImageSelected;
//
//   final void Function(XFile) onProfileImageSelected;
//
//   const MyPageAlert({super.key, required this.onBackgroundImageSelected, required this.onProfileImageSelected});
//
//   @override
//   State<MyPageAlert> createState() => _MainAlertState();
// }
//
// class _MainAlertState extends State<MyPageAlert> {
//
//   final NickNameController controller = Get.find();
//
//   // 배경 이미지
//   XFile? _backgroundImage;
//
//   // 프로필 이미지
//   XFile? _profileImage;
//
//   final ImagePicker picker = ImagePicker();
//
//   // 배경 이미지를 가져오는 함수
//   void getBackgroundImage(ImageSource imageSource) async {
//     //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
//     final XFile? pickedFile = await picker.pickImage(source: imageSource);
//     if (pickedFile != null) {
//       if(mounted){
//         setState(() {
//           _backgroundImage = XFile(pickedFile.path);
//           widget.onBackgroundImageSelected(_backgroundImage!);
//           Get.back();
//         });
//       }
//     }
//   }
//
//   // 프로필 이미지를 가져오는 함수
//   void getProfileImage(ImageSource imageSource) async {
//     //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
//     final XFile? pickedFile = await picker.pickImage(source: imageSource);
//     if (pickedFile != null) {
//       if(mounted){
//         setState(() {
//           _profileImage = XFile(pickedFile.path);
//           widget.onProfileImageSelected(_profileImage!);
//           Get.back();
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 수정 아이콘을 눌렀을 때 보여줄 위젯
//     return Center(
//       child: Dialog(
//         backgroundColor: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 프로필 사진 변경
//             Container(
//               height: 45,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                   border: Border(),
//                   color: Colors.white
//               ),
//               child: MaterialButton(
//                 onPressed: () async {
//                   // 갤러리 권한 요청
//                   var status = await Permission.photos.request();
//                   print("${status.isGranted}");
//                   if(status.isGranted)
//                     getProfileImage(ImageSource.gallery);
//                 },
//                 child: Text("프로필 사진 변경",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: mainBrown,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             // 디바이더 설정
//             MyPageDivider(verticalPadding: 0, horizontalPadding: 0),
//             // 배경 사진 변경
//             Container(
//               height: 45,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white
//               ),
//               child: MaterialButton(
//                 onPressed: () {
//                   getBackgroundImage(ImageSource.gallery);
//
//                 },
//                 child: Text("배경 사진 변경",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: mainBrown,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             // 디바이더 설정
//             MyPageDivider(verticalPadding: 0, horizontalPadding: 0),
//             // 닉네임 변경
//             Container(
//               height: 45,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
//                   color: Colors.white
//               ),
//               child: MaterialButton(
//                 onPressed: () {
//                   controller.nickNameChangeState(true);
//                   Get.back();
//                 },
//                 child: Text("닉네임 변경",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: mainOrange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
