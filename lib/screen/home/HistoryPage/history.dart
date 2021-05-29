import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  double totalI = 0;
  double totalE = 0;
  @override
  void initState() {
    super.initState();
    LocalUser.stocks.forEach((key, value) {
      totalE += value['totalSell'];
      totalI += value['totalBuy'];
    });
    totalE = totalE.floorToDouble();
    totalI = totalI.floorToDouble();
  }

  getItems(String a1, String a2) {
    return Expanded(
      child: Container(
        height: 70,
        child: Column(
          children: [
            Text(
              a1,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              a2,
              style:
                  Theme.of(context).textTheme.headline4.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int hLen = LocalUser.history.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 150,
          child: Row(
            children: [
              getItems('Total Invested', totalI.toString()),
              getItems('Total Earned', totalE.toString())
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: customColorScheme.surface,
            ),
            child: Column(
              children: [
                Text(
                  'Transaction History',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Divider(
                  height: 25,
                  color: Colors.white70,
                ),
                Expanded(
                  child: (LocalUser.history.length == 0)
                      ? Center(
                          child: Text(
                            'No Transactions Yet!',
                            style: textStyle,
                          ),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: hLen,
                          itemBuilder: (context, index) => HTile(
                              hData: LocalUser.history[hLen - (index + 1)]),
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HTile extends StatefulWidget {
  final Map<String, String> hData;
  const HTile({Key key, this.hData}) : super(key: key);

  @override
  _HTileState createState() => _HTileState();
}

class _HTileState extends State<HTile> {
  Color color;
  String time;
  @override
  void initState() {
    super.initState();
    if (widget.hData['isSell'] == 'false') {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    time = widget.hData['time'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: color),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 0,
            offset: Offset(0, 3),
            color: Colors.black38,
          )
        ],
        color: customColorScheme.primaryVariant,
      ),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: customColorScheme.background,
            foregroundColor: color,
            radius: 23,
            child: Text(widget.hData['count']),
          ),
          Text(
            widget.hData['stockId'],
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.left,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.Hm().format(DateTime.parse(time)),
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                DateFormat.yMMMd().format(DateTime.parse(time)),
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
