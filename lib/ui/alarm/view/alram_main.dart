import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/alarm/view/alram_detail.dart';

import '../../../widget/main_appbar.dart';
import '../widget/alram_item.dart';

class AlramMain extends StatefulWidget {

  const AlramMain({super.key});

  @override
  State<AlramMain> createState() => _AlramMainState();

}

class _AlramMainState extends State<AlramMain> {
  bool alramIsChecked = false;


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MainAppBar()),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index){
                  return AlramItem(alramIsChecked: alramIsChecked,);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
              // 바텀 시트 높이 지정하려면 isScrollControlled: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context){
                return AlramDetail();
              });
          },
          backgroundColor: mainOrange,
          child: Icon(Icons.add, color: Colors.white,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}





