import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:schedule_with/assets/colors/color.dart';
import '../../../entity/paymemo_tbl.dart';
import '../../../widget/main_alert.dart';
import '../widget/pay_bankaccount_bottomsheet.dart';
import '../widget/pay_settlement_status.dart';
import '../widget/pay_title__field.dart';
import '../widget/pay_usage_bottomsheet.dart';
import '../widget/paymemo_controller.dart';

class PayMemoScreen extends StatefulWidget {
  final PayMemo? paymemo;

  PayMemoScreen({Key? key, this.paymemo}) : super(key: key);

  @override
  _PayMemoScreenState createState() => _PayMemoScreenState();
}

class _PayMemoScreenState extends State<PayMemoScreen> {
  final PayMemoController controller = Get.find<PayMemoController>();
  final TextEditingController _titleController = TextEditingController();
  int _count = 1;
  List<String> _usageDetails = [];
  String _selectedAccount = '계좌번호를 입력해 주세요.';
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.paymemo?.title ?? '';
    _isComplete = widget.paymemo?.isCompleted ?? false;
    _selectedAccount = widget.paymemo?.accountNumber ?? '계좌번호를 입력해 주세요.';
    _count = widget.paymemo?.participantsCount ?? 1;
    _usageDetails = widget.paymemo?.usageDetails ?? [];
  }

  void _handleSettlementChange(bool isComplete) {
    setState(() {
      _isComplete = isComplete;
    });
  }

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
            icon: Icon(CupertinoIcons.back, color: grey4,),
            onPressed: () {
              if (_titleController.text.isNotEmpty ||
                  _selectedAccount != '계좌번호를 입력해 주세요.' ||
                  _count > 1 ||
                  _usageDetails.isNotEmpty) {
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
                    Navigator.pop(context);
                  }
                });
              } else {
                Get.back(result: true);
              }
            },
          ),
          title: Text('금액 계산', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: _saveMemo,
              child: Text('완료', style: TextStyle(color: mainOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: [
              PaySettlementStatus(
                  isComplete: _isComplete,
                  onStatusChanged: _handleSettlementChange),
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
                              BottomSheetWidget(
                                onAdd: (String usage, String cost,
                                    bool isAddition) {
                                  setState(() {
                                    // 사용 내역과 비용을 _usageDetails 리스트에 추가
                                    _usageDetails.add("$usage $cost원");
                                  });
                                },
                              ),
                            ],
                          );
                        },
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius
                              .circular(10.0)),
                        ),
                        barrierColor: grey4.withOpacity(0.5),
                      );
                    },
                    backgroundColor: mainOrange,
                    child: Icon(Icons.add, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTotalAmount(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      height: 1,
                      color: grey2
                  ),
                ),
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
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
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
                child: GestureDetector(
                  onTap: _showBankAccountBottomSheet,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedAccount.isEmpty || _selectedAccount == '계좌번호를 입력해 주세요.' ? '계좌번호를 입력해 주세요.' : _selectedAccount,
                          style: TextStyle(
                              fontSize: 14,
                              color: _selectedAccount.isEmpty || _selectedAccount == '계좌번호를 입력해 주세요.' ? grey3 : Colors.black
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        InkWell(
                          onTap: () {
                            if (_selectedAccount.isNotEmpty && _selectedAccount != '계좌번호를 입력해 주세요.') {
                              Clipboard.setData(ClipboardData(text: _selectedAccount));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: SvgPicture.asset(
                                "lib/assets/icon/icon_copy_payaccount.svg",
                                color: _selectedAccount.isEmpty || _selectedAccount == '계좌번호를 입력해 주세요.' ? grey3 : grey4
                            ),
                          ),
                        ),
                      ],
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
  void _showBankAccountBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BankAccountBottomSheetWidget(
          onSelectAccount: (account) {
            setState(() {
              _selectedAccount = account;
            });
          },
        );
      },
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      barrierColor: grey4.withOpacity(0.5),
    );
  }

  Widget _buildPersonCounter() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: grey2))),
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
                      if (_count > 1) _count--;
                    });
                  },
                ),
                Text('$_count', style: TextStyle(fontSize: 14)),
                IconButton(
                  icon: SvgPicture.asset(
                      "lib/assets/icon/icon_paymemo_plus.svg"),
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
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
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
          // var isIncome = parts[1].startsWith('-');
          var isIncome = parts.length > 1 && parts[1].startsWith('-');
          return SwipeActionCell(
            key: ObjectKey(_usageDetails[index]),
            backgroundColor: Colors.white,
            trailingActions: [
              SwipeAction(
                title: "삭제",
                onTap: (CompletionHandler handler) async {
                  await handler(true);
                  setState(() {
                    _usageDetails.removeAt(index);
                  });
                },
                color: mainBrown,
              ),
            ],
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30, top: 10, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(parts[0], style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isIncome ? mainOrange : mainBrown)),
                  Text(parts[1], style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isIncome ? mainOrange : mainBrown)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalAmount() {
    int totalAmount = calculateTotalAmount();
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Padding(
      padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Column(
        children: <Widget>[
          Dash(
            direction: Axis.horizontal,
            length: screenWidth - 40,
            dashLength: 12,
            dashColor: grey2,
            dashGap: 8,

          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white,))),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text('총 금액', style: TextStyle(fontSize: 14))
                  ),
                  Expanded(
                      flex: 2,
                      child: Text('$totalAmount 원',
                          style: TextStyle(fontSize: 16,),
                          textAlign: TextAlign.right)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountPerPerson() {
    double perPerson = _count > 0 ? calculateTotalAmount() / _count : 0;
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1, child: Text('인당 금액', style: TextStyle(fontSize: 14))),
            Expanded(flex: 2,
                child: Text('${perPerson.toStringAsFixed(0)} 원',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right)),
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

  double calculateAmountPerPerson() {
    int total = calculateTotalAmount();
    return _count > 0 ? total / _count : 0;
  }

  Future<void> _saveMemo() async {
    if (_titleController.text.isNotEmpty) {
      int totalAmount = calculateTotalAmount();
      int amountPerPerson = calculateAmountPerPerson().toInt();

      if (widget.paymemo == null) {
        PayMemo newPayMemo = PayMemo(
          documentId: '',
          idx: DateTime
              .now()
              .millisecondsSinceEpoch,
          reg_dt: DateTime.now(),
          mod_dt: DateTime.now(),
          title: _titleController.text,
          amount: '$totalAmount원 | $amountPerPerson원',
          isCompleted: _isComplete,
          accountNumber: _selectedAccount,
          participantsCount: _count,
          usageDetails: _usageDetails,
          status: 'Y',
        );
        String documentId = await controller.addPayMemo(newPayMemo);
        newPayMemo.documentId = documentId;
      }
      else {
        // Update an existing PayMemo
        PayMemo updatedPayMemo = PayMemo(
          documentId: widget.paymemo!.documentId,
          idx: widget.paymemo!.idx,
          reg_dt: widget.paymemo!.reg_dt,
          mod_dt: DateTime.now(),
          title: _titleController.text,
          amount: '$totalAmount원 | $amountPerPerson원',
          isCompleted: _isComplete,
          accountNumber: _selectedAccount,
          participantsCount: _count,
          usageDetails: _usageDetails,
          status: widget.paymemo!.status,
        );
        await controller.updatePayMemo(updatedPayMemo);
      }
      Navigator.pop(context);
    }
  }
}
