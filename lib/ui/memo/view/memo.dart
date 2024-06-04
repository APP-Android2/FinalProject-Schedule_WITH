import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../assets/colors/color.dart';
import '../../../widget/main_alert.dart';
import '../widget/memo_controller.dart';
import '../widget/memo_ispublic_status.dart';
import 'memo_item.dart';
import 'memo_main.dart';

class MemoScreen extends StatelessWidget {
  final MemoController controller = Get.find<MemoController>();
  final Memo? memo;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isPublic = false;

  MemoScreen({Key? key, this.memo}) : super(key: key) {
    _titleController.text = memo?.title ?? '';
    _contentController.text = memo?.body ?? '';
    _isPublic = memo?.isPublic ?? _isPublic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: grey4,),
          onPressed: () {
            if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
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
                if (result == true) {
                  Get.to(() => MemoMainScreen());
                }
              });
            } else {
              Get.back(result: false);
            }
          },
        ),
        title: Text('메모', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (memo == null) {
                controller.addMemo(Memo(
                  date: DateTime.now().toIso8601String().split('T')[0],
                  title: _titleController.text,
                  body: _contentController.text,
                  isPublic: _isPublic,
                ));
              } else {
                int index = controller.memos.indexOf(memo!);
                controller.memos[index] = Memo(
                  date: DateTime.now().toIso8601String().split('T')[0],
                  title: _titleController.text,
                  body: _contentController.text,
                  isPublic: _isPublic,
                );
              }
              Navigator.pop(context);
            },
            child: Text('완료', style: TextStyle(color: mainOrange, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            MemoIspublicStatus(
              isPublic: _isPublic,
              onStatusChanged: (bool isPublic) {
                _isPublic = isPublic;
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: grey2)),
              ),
              child: TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.black, fontSize: 16, decorationThickness: 0),
                decoration: InputDecoration(
                  hintText: '제목을 입력해 주세요.',
                  hintStyle: TextStyle(color: grey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.black, fontSize: 14, decorationThickness: 0),
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
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            print('이미지 : ${image.path}');
          }
        },
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
}
