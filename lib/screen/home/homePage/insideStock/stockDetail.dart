import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/screen/home/homePage/insideStock/alertBox.dart';

class StockDetails extends StatefulWidget {
  final String stockId;
  StockDetails({this.stockId});
  @override
  _StockDetailsState createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  dynamic _value;
  int change;
  dynamic color;
  Widget arrow() {
    if (change > 0) return Icon(Icons.arrow_circle_up_rounded, color: color);
    return Icon(Icons.arrow_circle_down_rounded, color: color);
  }

  getItems(String a1, String a2) {
    return Expanded(
      child: Container(
        height: 70,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
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
    _value = quoteRaw[widget.stockId];
    change = (_value['regularMarketChangePercent'] * 100).toInt();
    int changeI = (_value['regularMarketChange'] * 100).toInt();
    int changeIFH = (_value['fiftyTwoWeekHighChange'] * 100).toInt();
    int changeIFL = (_value['fiftyTwoWeekLowChange'] * 100).toInt();
    int changeFH = (_value['fiftyTwoWeekHighChangePercent'] * 100).toInt();
    print(_value['fiftyTwoWeekLowChangePercent']);
    int changeFL = (_value['fiftyTwoWeekLowChangePercent'] * 100).toInt();

    color =
        (change < 0) ? Colors.red.withAlpha(150) : Colors.green.withAlpha(120);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white60,
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 100,
        backgroundColor: customColorScheme.primary,
        elevation: 12,
        automaticallyImplyLeading: false,
        title: Hero(
          tag: widget.stockId,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _value['symbol'],
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                _value['longName'],
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        actions: [
          VerticalDivider(
            color: Colors.black54,
            thickness: 1,
            indent: 20,
            width: 25,
            endIndent: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _value['regularMarketPrice'].toString() ?? 'Error',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    ' USD',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  arrow(),
                  Text(
                    "  ${changeI / 100}\n (${change / 100}%)",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: color),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: customColorScheme.background,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Buy / Sell",
          style: TextStyle(
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          return showDialog(
              context: context,
              builder: (context) => AlertBox(stockId: widget.stockId));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        focusElevation: 5,
        backgroundColor: Colors.pink.withOpacity(.6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 6,
                  color: Colors.black54,
                  offset: Offset(0, 5),
                )
              ],
              color: customColorScheme.surface,
            ),
            // width: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "TODAY",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.grey[800],
                ),
                Row(
                  children: [
                    getItems("Last Close",
                        _value['regularMarketPreviousClose'].toString()),
                    getItems(
                        "Todays Open", _value['regularMarketOpen'].toString()),
                  ],
                ),
                Row(
                  children: [
                    getItems("Todays Price",
                        _value['regularMarketPrice'].toString()),
                    getItems(
                        "Todays Change", '${changeI / 100} (${change / 100}%)'),
                  ],
                ),
                Row(
                  children: [
                    getItems(
                        "Todays Low", _value['regularMarketDayLow'].toString()),
                    getItems("Todays High",
                        _value['regularMarketDayHigh'].toString()),
                  ],
                ),
                Row(
                  children: [
                    getItems("Market Volume",
                        _value['regularMarketVolume'].toString()),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: customColorScheme.surface,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 6,
                  color: Colors.black54,
                  offset: Offset(0, 5),
                )
              ],
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "PAST 52 WEEKs",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.grey[800],
                ),
                Row(
                  children: [
                    getItems("Low", _value['fiftyTwoWeekLow'].toString()),
                    getItems("High", _value['fiftyTwoWeekHigh'].toString()),
                  ],
                ),
                Row(
                  children: [
                    getItems("Low Change",
                        "${changeIFL / 100} (${changeFL / 100}%)"),
                    getItems("High Change",
                        "${changeIFH / 100} (${changeFH / 100}%)"),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: customColorScheme.surface,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 6,
                  color: Colors.black54,
                  offset: Offset(0, 5),
                )
              ],
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "FUNDAMENTALS",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.grey[800],
                ),
                Row(
                  children: [
                    getItems("Currency", '${_value['currency']}'),
                    getItems("P/E ratio", '${_value['trailingPE']}'),
                  ],
                ),
                Row(
                  children: [
                    getItems(
                        "Earning per Share", '${_value['epsCurrentYear']}'),
                    getItems("Earning per Share (trailing year)",
                        '${_value['epsTrailingTwelveMonths']}'),
                  ],
                ),
                Row(
                  children: [
                    getItems("Market Cap", '${_value['marketCap']}'),
                  ],
                ),

                // textL("Market Cap"),
                // textR('${_value['marketCap']}'),
                // Divider(
                //   color: Colors.white38,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // textL("Currency"),
                // textR('${_value['currency']}'),
                // Divider(
                //   color: Colors.white38,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // textL("Earning per Share"),
                // textR("${_value['epsCurrentYear']}"),
                // Divider(
                //   color: Colors.white38,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // textL("P/E ratio"),
                // textR("${_value['trailingPE']}"),
                // Divider(
                //   color: Colors.white38,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // textL("Earning per Share (trailing year)"),
                // textR("${_value['epsTrailingTwelveMonths']}"),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
