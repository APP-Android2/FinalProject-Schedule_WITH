import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../assets/colors/color.dart';


class BankAccountBottomSheetWidget extends StatefulWidget {
  final Function(String) onSelectAccount;

  BankAccountBottomSheetWidget({Key? key, required this.onSelectAccount}) : super(key: key);

  @override
  _BankAccountBottomSheetWidgetState createState() => _BankAccountBottomSheetWidgetState();
}

class _BankAccountBottomSheetWidgetState extends State<BankAccountBottomSheetWidget> {
  TextEditingController bankController = TextEditingController();
  List<BankItem> bankItems = BankItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
    child: SizedBox(
      height: 380,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: grey4,),
                  onPressed: () => Navigator.pop(context),
                ),
                Spacer(),
                Text(
                  '계좌 추가',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (bankController.text.isNotEmpty) {
                      setState(() {
                        bankItems.add(BankItem(accountNumber: bankController.text));
                        widget.onSelectAccount(bankController.text);
                        bankController.clear();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    '완료',
                    style: TextStyle(
                      color: mainOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: bankController,
                style: TextStyle(decorationThickness: 0),
                decoration: InputDecoration(
                  hintText: '계좌번호를 입력해주세요',
                  hintStyle: TextStyle(fontSize: 12, color: grey3),
                  filled: true,
                  fillColor: grey1,
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: bankItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      widget.onSelectAccount(bankItems[index].accountNumber);
                      Navigator.pop(context);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () {
                              widget.onSelectAccount(bankItems[index].accountNumber);
                              Navigator.pop(context);
                            },
                            child: Text(bankItems[index].accountNumber),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                bankItems.removeAt(index);
                              });
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                "lib/assets/icon/icon_delete_bin.svg",
                                width: 12,
                                height: 16,
                                color: grey4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}


class BankItem {
  final String accountNumber;

  BankItem({ required this.accountNumber});
}

List<BankItem> BankItems = [];
