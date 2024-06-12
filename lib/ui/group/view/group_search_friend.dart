import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import 'package:schedule_with/ui/group/widget/search_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../widget/group_profile.dart';

class GroupProfile {
  String profileImage;
  String groupName;

  GroupProfile({this.profileImage = '', required this.groupName});
}

class SearchFriend extends StatefulWidget {
  const SearchFriend({super.key});

  @override
  State<SearchFriend> createState() => _SearchFriendState();
  }

class _SearchFriendState extends State<SearchFriend> {
  List<String> allFriends = ["이영주", "김승미", "이수원", "정명재", "이영주", "이영주",];
  List<String> filteredFriends = [];
  List<GroupProfile> allGroups = [
    GroupProfile(groupName: '스케줄 위드'),
    GroupProfile(groupName: '멋쟁이 사자처럼'),
    GroupProfile(groupName: '안드로이드 스쿨 2기'),
    GroupProfile(groupName: '인천 정모'),
    GroupProfile(groupName: '스터디 그룹'),
    GroupProfile(groupName: '친구 모임'),


  ];
  List<GroupProfile> filteredGroups = [];


  @override
  void initState() {
    super.initState();
    filteredFriends = allFriends;
    filteredGroups = allGroups;
  }

  void updateSearch(String query) {
    setState(() {
      filteredFriends = allFriends.where((friend) =>
          friend.toLowerCase().contains(query.toLowerCase())).toList();
      // 그룹 필터링
      filteredGroups = allGroups.where((group) =>
          group.groupName.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey1,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            backgroundColor: Colors.white,
            // 뒤로가기 버튼
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(CupertinoIcons.back,color: grey4),
              onPressed: () {
                Get.back();
              },
            ),
            // 타이틀
            centerTitle: true,
            title: Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "친구 검색",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
        ),
      ),
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
            FriendSearchBar(
              onChanged: updateSearch,
            ),
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
            child: ShowFriendsList(friends: filteredFriends),
          ),
          // 그룹
          Container(
              padding: EdgeInsets.all(16),
              child: ShowGroupList(groups: filteredGroups),
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
  final List<String> friends;
  const ShowFriendsList({super.key, required this.friends});

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
            SizedBox(
              height: 100,
              child: friends.isEmpty
                  ? Center(child: Text("검색 결과가 없습니다."))
                  : Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  // 가로 스크롤
                  scrollDirection: Axis.horizontal,
                  // 보여질 항목의 개수
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return SearchFriendListItem(friendName: friends[index]);
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class ShowGroupList extends StatefulWidget {
  final List<GroupProfile> groups;
  const ShowGroupList({super.key, required this.groups});

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
            child: widget.groups.isNotEmpty ? ListView.builder(
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                return SearchGroupListItem(
                    groupName: widget.groups[index].groupName,
                    profileImage: widget.groups[index].profileImage
                );
              },
            ) : Center(child: Text("검색 결과가 없습니다.")),
          ),
          // 더보기 부분
          if (widget.groups.length > 3) InkWell(
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
class SearchGroupListItem extends StatefulWidget {
  final String groupName;
  final String profileImage;

  const SearchGroupListItem({Key? key, required this.groupName, this.profileImage = ''}) : super(key: key);

  @override
  State<SearchGroupListItem> createState() => _SearchGroupListItemState();
}

class _SearchGroupListItemState extends State<SearchGroupListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){ Get.toNamed('/groupDetail'); },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: grey1,
                      border: Border.all(color: grey2, width: 0.5)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: widget.profileImage.isEmpty
                        ? Center(child: Text(widget.groupName.substring(0, 1), style: TextStyle(fontSize: 24, color: grey4)))
                        : Image.asset(widget.profileImage, fit: BoxFit.cover),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.groupName,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(widget.groupName,
                      style: TextStyle(
                        fontSize: 12,
                        color: grey3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 친구 항목들의 리스트 아이템
class SearchFriendListItem extends StatelessWidget {
  final String friendName;

  const SearchFriendListItem({Key? key, required this.friendName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/groupDetail'),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: grey1,
                border: Border.all(color: grey2, width: 0.5),
              ),
              margin: EdgeInsets.only(bottom: 5),
              child: Center(
                child: Text(
                  friendName.substring(0, 1),
                  style: TextStyle(fontSize: 24, color: grey4),
                ),
              ),
            ),
            Text(
              friendName,
              style: TextStyle(
                color: grey4,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
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