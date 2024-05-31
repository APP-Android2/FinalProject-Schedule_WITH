import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_with/assets/colors/color.dart';
import '../widget/pay_bankaccount_bottomsheet.dart';
import '../widget/pay_settlement_status.dart';
import '../widget/pay_title__field.dart';
import '../widget/pay_usage_bottomsheet.dart';
import 'memo_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PayMemoScreen(),
    );
  }
}

class PayMemoScreen extends StatefulWidget {
  @override
  _MemoScreenState createState() => _MemoScreenState();
}


class _MemoScreenState extends State<PayMemoScreen> {
  final TextEditingController _titleController = TextEditingController();
  int _count = 0;
  List<String> _usageDetails = ["사용내역1 20000원", "사용내역2 15000원", "사용내역3 5000원"];
  String _selectedAccount = '계좌번호를 입력해 주세요.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('금액 계산', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('완료', style: TextStyle(color: mainOrange, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Column( // Non-scrollable part
            children: [
              PaySettlementStatus(),
              PayTitleField(titleController: _titleController),
              _buildBankFields(),
              _buildPersonCounter(),
              _buildUsageFields(),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                _buildUsageList(),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            children: [
                              BottomSheetWidget(),
                            ],
                          );
                        },
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        barrierColor: grey4.withOpacity(0.5),
                      );
                    },
                    backgroundColor: mainOrange,
                    child: Icon(Icons.add, color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTotalAmount(),
                _buildAmountPerPerson(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankFields() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text('계좌번호', style: TextStyle(fontSize: 14)),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return BankAccountBottomSheetWidget(onSelectAccount: (account) {
                            setState(() {
                              _selectedAccount = account;
                            });
                          });
                        },
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        barrierColor: grey4.withOpacity(0.5),
                      );
                    },
                    child: Text(_selectedAccount,
                        style: TextStyle(
                            fontSize: 14,
                            color: _selectedAccount == '계좌번호를 입력해 주세요.' ? grey3 : Colors.black)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonCounter() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("인원", style: TextStyle(fontSize: 14)),
            Row(
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset("lib/assets/icon/icon_minus.svg"),
                  onPressed: () {
                    setState(() {
                      if (_count > 0) _count--;
                    });
                  },
                ),
                Text('$_count', style: TextStyle(fontSize: 14)),
                IconButton(
                  icon: SvgPicture.asset("lib/assets/icon/icon_plus.svg"),
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageFields() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text('사용내역', style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }

  Widget _buildUsageList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _usageDetails.length,
        padding: EdgeInsets.only(bottom: 60),
        itemBuilder: (context, index) {
          List<String> parts = _usageDetails[index].split(' ');
          return Padding(
            padding: EdgeInsets.only(left: 30, top: 5, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(parts[0], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainOrange)),
                Text(parts[1], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainOrange)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalAmount() {
    int totalAmount = calculateTotalAmount();
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: grey2))),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Text('총 금액', style: TextStyle(fontSize: 14))),
            Expanded(flex: 2, child: Text('$totalAmount 원', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountPerPerson() {
    double perPerson = _count > 0 ? calculateTotalAmount() / _count : 0;
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Text('인당 금액', style: TextStyle(fontSize: 14))),
            Expanded(flex: 2, child: Text('${perPerson.toStringAsFixed(0)} 원', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
          ],
        ),
      ),
    );
  }

  int calculateTotalAmount() {
    return _usageDetails.fold(0, (sum, detail) {
      List<String> parts = detail.split(' ');
      return sum + int.parse(parts[1].replaceAll('원', ''));
    });
  }
}
