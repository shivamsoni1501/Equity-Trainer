import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';

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

  @override
  Widget build(BuildContext context) {
    int hLen = LocalUser.history.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.black,
          ),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total Invested    :',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      'Total Earned    :',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalI',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      '$totalE',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ]),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Text(
                  'Transaction History',
                  style: TextStyle(
                      color: Colors.pink,
                      // fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Divider(
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
  List time;
  @override
  void initState() {
    super.initState();
    if (widget.hData['isSell'] == 'false') {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    time = widget.hData['time'].split(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 2,
            color: Colors.white70,
          )
        ],
        color: Colors.black,
      ),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: color,
            foregroundColor: Colors.black,
            child: Text(widget.hData['count']),
          ),
          Text(
            widget.hData['stockId'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: color,
            ),
            textAlign: TextAlign.left,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${time[1].substring(0, 8)}',
                style: TextStyle(color: color),
              ),
              Text('${time[0]}', style: TextStyle(color: color)),
            ],
          ),
        ],
      ),
    );
  }
}
