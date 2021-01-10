import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';

class Porfolio extends StatefulWidget {
  @override
  _PorfolioState createState() => _PorfolioState();
}

class _PorfolioState extends State<Porfolio> {
  fetchData() async {
    quoteRaw = await FinanceQuote.getRawData(
        quoteProvider: QuoteProvider.yahoo, symbols: LocalUser.stockList);
    return quoteRaw;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
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
              'Error in Fetching Information!',
              style: TextStyle(color: Colors.redAccent),
            ));
          }
        }
        return ListView.builder(
          itemCount: LocalUser.stockList.length,
          itemExtent: width,
          itemBuilder: (context, index) => Tile(
            stockId: LocalUser.stockList[index],
          ),
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  final String stockId;
  Tile({this.stockId});

  @override
  Widget build(BuildContext context) {
    int history = LocalUser.history[stockId].length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stockId,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.pink,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    quoteRaw[stockId]['shortName'],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.pink.shade900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  LocalUser.stocks[stockId]['count'].toInt().toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.pink,
            indent: 20,
            endIndent: 20,
          ),
          Text(
            'Total Investment',
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.center,
          ),
          Text(
            LocalUser.stocks[stockId]['totalBuy'].floorToDouble().toString(),
            style: TextStyle(
                color: Colors.pink, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Total Outcome',
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.center,
          ),
          Text(
            LocalUser.stocks[stockId]['totalSell'].floorToDouble().toString(),
            style: TextStyle(
                color: Colors.pink, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink,
              ),
              child: ListView.builder(
                itemCount: history,
                itemBuilder: (context, index) => HistoryTile(
                  data: LocalUser.history[stockId][history - index - 1],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTile extends StatelessWidget {
  final Map<String, String> data;
  HistoryTile({this.data});
  @override
  Widget build(BuildContext context) {
    List time = data['time'].split(' ');
    Color color = (data['isSell'] == 'true') ? Colors.red : Colors.green;
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5)],
          color: Colors.black,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: color,
            foregroundColor: Colors.black,
            child: Text(data['count']),
          ),
          Text(
            '\$${data['price']}',
            style: TextStyle(color: color),
          ),
          Column(
            children: [
              Text(
                '${time[1].substring(0, 8)}',
                style: TextStyle(color: color),
              ),
              Text('${time[0]}', style: TextStyle(color: color)),
            ],
          )
        ],
      ),
    );
  }
}
