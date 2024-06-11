import 'package:flutter/material.dart';
import 'package:schedule_with/assets/colors/color.dart';

class MemoIspublicStatus extends StatefulWidget {
  final bool isPublic;
  final Function(bool) onStatusChanged;

  const MemoIspublicStatus({Key? key, required this.isPublic, required this.onStatusChanged}) : super(key: key);

  @override
  _MemoIspublicStatusState createState() => _MemoIspublicStatusState();
}

class _MemoIspublicStatusState extends State<MemoIspublicStatus> {
  late String _isPublicStatus;

  @override
  void initState() {
    super.initState();
    _isPublicStatus = widget.isPublic ? 'Y' : 'N';
  }

  void _updateStatus(String status) {
    bool isPublic = status == 'Y';
    setState(() {
      _isPublicStatus = status;
    });
    widget.onStatusChanged(isPublic);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: grey2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("공개 상태", style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _updateStatus('N'),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<String>(
                                value: 'N',
                                groupValue: _isPublicStatus,
                                onChanged: (value) => _updateStatus(value ?? 'N'),
                                activeColor: mainBrown,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) => states.contains(MaterialState.selected) ? mainBrown : mainBrown.withOpacity(1),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("비공개", style: TextStyle(color: mainBrown, fontSize: 14)),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => _updateStatus('Y'),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Radio<String>(
                                value: 'Y',
                                groupValue: _isPublicStatus,
                                onChanged: (value) => _updateStatus(value ?? 'Y'),
                                activeColor: mainOrange,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (states) => states.contains(MaterialState.selected) ? mainOrange : mainOrange.withOpacity(0.5),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("전체 공개", style: TextStyle(color: mainOrange, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}