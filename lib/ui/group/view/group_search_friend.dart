import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/widget/search_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchFriend extends StatefulWidget {
  const SearchFriend({super.key});

  State<SearchFriend> createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey1,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), child: SearchFriendAppbar()),
      body: bodyContent(),
    );
  }

  // 앱바
  Widget SearchFriendAppbar() {
    return AppBar(
      leading: Icon(CupertinoIcons.back),
      backgroundColor: Colors.white,
      title: Text('친구 검색', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
    );
  }

  Widget bodyContent() {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // 서치바
            FriendSearchBar(),
            // 여백
            Padding(padding: EdgeInsets.all(4)),
            // 완료 버튼
            buttonSubmit(),
          ]),
          // 검색 결과
          // Text("Input Text = $inputText", style: TextStyle(fontSize: 30)),
          // 친구
          Container(
            padding: EdgeInsets.all(16),
            child: ShowFriendsList(),
          ),
          // 그룹
          Container(
              padding: EdgeInsets.all(16),
              child: ShowGroupList(),
            ),
          // 광고
          Container(
              padding: EdgeInsets.all(16),
              child: ShowAd()
          ),
        ])));
  }
}


Widget buttonSubmit() {
  return SizedBox(
    width: 60,
    height: 40,
    child: TextButton(
      onPressed: () {},
      child: Text(
        '완료',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ),
  );
}

class ShowFriendsList extends StatelessWidget {
  const ShowFriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 0,
                blurRadius: 8.0,
                offset: Offset(0, 5), // changes position of shadow
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10, height: 10),
            Container(
              child: Text("친구",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Container(
              width: double.infinity,
              height: 100, // 원하는 높이 설정
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                // 가로 스크롤
                scrollDirection: Axis.horizontal,
                // 보여질 항목의 개수
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SearchGroupListItem();
                },
              ),
            ),
          ],
        ));
  }
}

class ShowGroupList extends StatefulWidget {
  const ShowGroupList({super.key});

  @override
  _ShowGroupListState createState() => _ShowGroupListState();
}

class _ShowGroupListState extends State<ShowGroupList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 8.0,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10, height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              "그룹",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: _expanded ? 300 : 200, // 처음에는 3개 높이, 확장 시 더 높이
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: ListView.builder(
              itemCount: _expanded ? 10 : 3, // 확장 여부에 따른 항목 개수
              itemBuilder: (context, index) {
                return SearchGroupListItem();
              },
            ),
          ),
          // 더보기 부분
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: grey1,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
                  alignment: Alignment.center,
                  child: Text(
                    _expanded ? '접기' : '더보기',
                    style: TextStyle(color: grey4),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}

// 그룹 항목들의 리스트 아이템
Widget SearchGroupListItem() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5), // 아이템 간의 간격을 설정
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 그룹 프사 설정
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: grey1,
            border: Border.all(color: grey2, width: 0.5),
          ),
          margin: EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "lib/assets/icon/icon_plus.svg",
            width: 15,
            height: 15,
            fit: BoxFit.scaleDown,
          ),
        ),
        // "그룹추가" 텍스트 출력
        Text(
          "그룹 추가",
          style: TextStyle(
            color: grey4,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}



class ShowAd extends StatefulWidget {
  const ShowAd({super.key});

  @override
  State<ShowAd> createState() => _ShowAdState();

}

class _ShowAdState extends State<ShowAd> {

  var adImages = [
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png"),
    Image.asset("lib/assets/image/logo.png")
  ];

  var imagePosition = 0;


  @override
  Widget build(BuildContext context) {
    return
      // 광고
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 8.0,
                  offset: Offset(0, 5), // changes position of shadow
                )
              ]
          ),
          child: Column(
            children: [
              CarouselSlider(
                items: adImages,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setState(() {
                      var imagePosition = index;
                    });
                  },
                ),
              ),
              AnimatedSmoothIndicator(
                activeIndex: imagePosition,
                count: adImages.length,
                effect: JumpingDotEffect(
                    dotWidth: 5,
                    dotHeight: 5,
                    dotColor: grey3,
                    paintStyle: PaintingStyle.fill,
                    activeDotColor: mainOrange
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 7))
            ],
          )
      );
  }
}