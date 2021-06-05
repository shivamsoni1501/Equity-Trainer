import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen/home/homePage/insideStock/stockDetail.dart';
import 'package:intl/intl.dart';

class Porfolio extends StatefulWidget {
  @override
  _PorfolioState createState() => _PorfolioState();
}

class _PorfolioState extends State<Porfolio> {
  List<String> cList = [];
  fetchData() async {
    quoteRaw = await FinanceQuote.getRawData(
        quoteProvider: QuoteProvider.yahoo, symbols: LocalUser.stockList);
    return quoteRaw;
  }

  @override
  void initState() {
    super.initState();
    LocalUser.stockList.forEach((element) {
      if (LocalUser.stocksHistory[element].length != 0) {
        cList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    // var width = screenSize.width;
    return FutureBuilder(
      future: (quoteRaw == null) ? fetchData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            quoteRaw = snapshot.data;
          } else {
            return Center(
                child: Text(
              'Network Error!\nCheck your internet connection.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent),
            ));
          }
        }
        return (cList.length == 0)
            ? Center(
                child: Text(
                  'No Transaction Yet!',
                  style: textStyle,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: cList.length,
                  itemExtent: 170,
                  itemBuilder: (context, index) => StockTile(
                    stockId: cList[index],
                  ),
                  physics: BouncingScrollPhysics(),
                ),
              );
      },
    );
  }
}

class StockTile extends StatelessWidget {
  // final String cName;
  final dynamic stockId;
  const StockTile({this.stockId});

  @override
  Widget build(BuildContext context) {
    dynamic value = quoteRaw[stockId];
    return Container(
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
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TranHistory(stockId: stockId)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Hero(
                tag: stockId + '0',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: customColorScheme.background,
                      foregroundColor: Colors.white54,
                      radius: 23,
                      child: Text(
                        LocalUser.stocks[stockId]['count'].toInt().toString(),
                      ),
                    ),
                    Text(
                      stockId,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          value['regularMarketPrice'].toString() ?? 'Error',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          ' USD',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Total Investment',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        LocalUser.stocks[stockId]['totalBuy']
                            .floorToDouble()
                            .toString(),
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Total Earn',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        LocalUser.stocks[stockId]['totalSell']
                            .floorToDouble()
                            .toString(),
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TranHistory extends StatefulWidget {
  final String stockId;
  const TranHistory({Key key, this.stockId}) : super(key: key);

  @override
  _TranHistoryState createState() => _TranHistoryState();
}

class _TranHistoryState extends State<TranHistory> {
  getItems(String a1, String a2, BuildContext context) {
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
    dynamic value = quoteRaw[widget.stockId];
    final int historyL = LocalUser.stocksHistory[widget.stockId].length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white70,
            onPressed: () => Navigator.pop(context)),
        backgroundColor: customColorScheme.primary,
        title: Hero(
          tag: widget.stockId + '0',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CircleAvatar(
              //   backgroundColor: customColorScheme.background,
              //   foregroundColor: Colors.white54,
              //   radius: 23,
              //   child: Text(
              //     LocalUser.stocks[stockId]['count'].toInt().toString(),
              //   ),
              // ),
              Text(
                widget.stockId,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value['regularMarketPrice'].toString() ?? 'Error',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    ' USD',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: customColorScheme.background,
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: customColorScheme.surface,
        ),
        child: Column(
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.headline3,
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[800],
            ),
            Row(
              children: [
                getItems(
                    'Total Investment',
                    LocalUser.stocks[widget.stockId]['totalBuy']
                        .floorToDouble()
                        .toString(),
                    context),
                getItems(
                    'Total Earn',
                    LocalUser.stocks[widget.stockId]['totalSell']
                        .floorToDouble()
                        .toString(),
                    context)
              ],
            ),
            Row(
              children: [
                getItems(
                    'number of owned stocks',
                    LocalUser.stocks[widget.stockId]['count']
                        .toInt()
                        .toString(),
                    context),
                getItems('Market Volume',
                    value['regularMarketVolume'].toString(), context)
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StockDetails(stockId: widget.stockId)))
                    .then((value) {
                  setState(() {});
                });
              },
              child: Text(
                'See More details',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Past Transactions',
              style: Theme.of(context).textTheme.headline3,
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[800],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: historyL,
                  itemBuilder: (context, index) => HTile(
                    hData: LocalUser.stocksHistory[widget.stockId]
                        [historyL - index - 1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            widget.hData['price'],
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
