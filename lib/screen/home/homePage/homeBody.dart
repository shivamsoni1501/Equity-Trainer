import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/constants.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen/home/homePage/insideStock/stockDetail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  fetchData() async {
    quoteRaw = await FinanceQuote.getRawData(
        quoteProvider: QuoteProvider.yahoo, symbols: LocalUser.stockList);
    return quoteRaw;
  }

  @override
  Widget build(BuildContext context) {
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
        LocalUser.load = false;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: LocalUser.stockList
                .map((value) => StockTile(stockId: value))
                .toList(),
          ),
        );
        // itemCount: 10,
        // physics: BouncingScrollPhysics(),
        // // itemBuilder: (context, index) => StockTile(
        // //   stockId: requestC[index],
        // // ),
        // children:
        //     requestC.map((value) => StockTile(stockId: value)).toList());
        // );
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
    int change = (value['regularMarketChangePercent'] * 100).toInt();
    dynamic color = (change < 0) ? Colors.red[800] : Colors.green[800];
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetails(stockId: stockId)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: stockId,
              child: Text(
                value['shortName'],
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.pink,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      value['regularMarketPrice'].toString() ?? 'Error',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' USD',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    )
                  ],
                ),
                Text(
                  " (${change / 100}%)",
                  style: TextStyle(
                    fontSize: 15,
                    color: color,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
