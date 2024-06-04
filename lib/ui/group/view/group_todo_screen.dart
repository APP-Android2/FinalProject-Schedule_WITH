import 'package:flutter/material.dart';

class GroupTodoScreen extends StatelessWidget {
  final String groupName;
  final String groupProfileImageUrl; // 그룹 이름, 그룹 프로필사진

  const GroupTodoScreen({
    Key? key,
    required this.groupName,
    required this.groupProfileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(groupProfileImageUrl),
                  radius: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  groupName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    // 설정 페이지로 이동하는 로직을 추가
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    '$groupName 그룹의 TODO 화면',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
