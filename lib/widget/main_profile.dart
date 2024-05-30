import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/colors/color.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Padding(
          padding: EdgeInsets.only(bottom: 35),
          child: Container(
            width: double.infinity,
            color: grey2,
            // child 로 배경 이미지 설정
            child: Image.asset("lib/assets/image/profile.png",fit: BoxFit.cover,),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        border: Border.all(color: grey2,width: 0.5)
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: SvgPicture.asset(
                            "lib/assets/icon/icon_profile.svg",
                            color: genderMale
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("이름",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                          child: SvgPicture.asset("lib/assets/icon/icon_pen.svg"),
                        ),

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
