import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../assets/colors/color.dart';
import '../../../entity/memo_tbl.dart';
import '../../../widget/main_alert.dart';
import '../widget/memo_controller.dart';
import '../widget/memo_ispublic_status.dart';
import 'memo_main.dart';

class MemoScreen extends StatelessWidget {
  final MemoController controller = Get.find<MemoController>();
  final Memo? memo;

  MemoScreen({Key? key, this.memo}) : super(key: key) {
    final memo = this.memo;
    if (memo == null) {
      controller.titleController.value.clear();
      controller.contentController.value.clear();
      controller.isPublic.value;
    } else {
      controller.titleController.value.text = memo.title;
      controller.contentController.value.text = memo.content;
      controller.isPublic.value = memo.isPublic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: grey4),
          onPressed: () => _handleBackPress(context),
        ),
        title: Text(
            '메모', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
                if (memo == null) {
                  Memo newMemo = Memo(
                    idx: DateTime.now().millisecondsSinceEpoch,
                    title: controller.titleController.value.text,
                    content: controller.contentController.value.text,
                    isPublic: controller.isPublic.value,
                    hasImage: false,
                    reg_dt: DateTime.now(),
                    mod_dt: DateTime.now(),
                    status: 'Y',
                  );
                  await controller.addMemo(newMemo);
                } else {
                  // 새로운 Memo 객체 생성하여 업데이트
                  Memo updatedMemo = Memo(
                    idx: memo!.idx,
                    title: controller.titleController.value.text,
                    content: controller.contentController.value.text,
                    isPublic: controller.isPublic.value,
                    hasImage: memo!.hasImage,
                    reg_dt: memo!.reg_dt,
                    mod_dt: DateTime.now(),
                    status: memo!.status,
                  );
                  await controller.updateMemo(updatedMemo);
                }
                Navigator.pop(context);
            },
            child: Text('완료', style: TextStyle(
                color: mainOrange, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Obx(() =>
                MemoIspublicStatus(
                  isPublic: controller.isPublic.value,
                  onStatusChanged: (bool isPublic) {
                    controller.isPublic.value = isPublic;
                  },
                ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: grey2)),
              ),
              child: TextField(
                controller: controller.titleController.value,
                style: TextStyle(
                    color: Colors.black, fontSize: 16, decorationThickness: 0),
                decoration: InputDecoration(
                  hintText: '제목을 입력해 주세요.',
                  hintStyle: TextStyle(color: grey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller.contentController.value,
                style: TextStyle(
                    color: Colors.black, fontSize: 14, decorationThickness: 0),
                decoration: InputDecoration(
                  hintText: '내용을 입력해 주세요.',
                  hintStyle: TextStyle(color: grey2),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddImage,
        backgroundColor: mainOrange,
        child: SvgPicture.asset(
          "lib/assets/icon/icon_camera.svg",
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    if (controller.titleController.value.text.isNotEmpty ||
        controller.contentController.value.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MainAlert(
              msg: '등록사항을 취소하시겠습니까?',
              YesMsg: '예',
              NoMsg: '계속 작성',
            );
          }
      ).then((result) {
        if (result == false) {
          Get.to(() => MemoMainScreen());
        }
      });
    } else {
      Get.back(result: true);
    }
  }


  void _handleAddImage() async {
    print('Image added.');
  }
}