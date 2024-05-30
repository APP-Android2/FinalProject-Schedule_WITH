import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../assets/color/color.dart';
import '../view/paymemo.dart';

class BankAccountBottomSheetWidget extends StatefulWidget {
  final Function(String) onSelectAccount;

  BankAccountBottomSheetWidget({Key? key, required this.onSelectAccount}) : super(key: key);

  @override
  _BankAccountBottomSheetWidgetState createState() => _BankAccountBottomSheetWidgetState();
}

class _BankAccountBottomSheetWidgetState extends State<BankAccountBottomSheetWidget> {
  TextEditingController bankController = TextEditingController();
  List<BankItem> bankItems = exampleBankItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
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
                        bankItems.add(BankItem(
                            accountNumber: bankController.text));
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: bankController,
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: bankItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bankItems[index].accountNumber),
                  onTap: () {
                    widget.onSelectAccount(bankItems[index].accountNumber);
                    Navigator.pop(context);
                  },
                  trailing: IconButton(
                    icon: SvgPicture.asset(
                      "lib/assets/icon/icon_delete_bin.svg",
                      width: 12,
                      height: 16,
                      color: grey4,
                    ),
                    onPressed: () {
                      setState(() {
                        bankItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BankListView extends StatelessWidget {
  final List<BankItem> bankItems;

  const BankListView({Key? key, required this.bankItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bankItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(bankItems[index].accountNumber),
          onTap: () {
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              bankItems.removeAt(index);
              (context as Element).markNeedsBuild();
            },
          ),
        );
      },
    );
  }
}

class BankItem {
  final String accountNumber;

  BankItem({ required this.accountNumber});
}

List<BankItem> exampleBankItems = [
  BankItem(accountNumber: '국민은행 123-456-7890'),
  BankItem(accountNumber: '신한은행 987-654-3210'),
  BankItem(accountNumber: '국민은행 123-456-7890'),
  BankItem(accountNumber: '신한은행 987-654-3210'),
  BankItem(accountNumber: '국민은행 123-456-7890'),
  BankItem(accountNumber: '신한은행 987-654-3210'),
];
