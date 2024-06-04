import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_with/assets/colors/color.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainBrown,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          children: [
            Positioned(
              top: 300,
              right: -200,
              child: Container(
                child:
                Icon(
                  CupertinoIcons.alarm,
                  size: 500,
                  color: Colors.black.withOpacity(0.1),
                )
              ),
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 330,),
                  Text("오전",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      height: 1
                    ),
                  ),
                  Text("1:30",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      height: 0.67
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120,),
              Text("김진갱 일어나!!!!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: mainOrange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text("다시 알림",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Text("중단",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
