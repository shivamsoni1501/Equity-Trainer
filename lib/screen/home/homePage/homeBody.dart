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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FutureBuilder(
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
                style: TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ));
            }
          }
          LocalUser.load = false;
          return GridView.count(
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            physics: BouncingScrollPhysics(),
            children: LocalUser.stockList
                .map((value) => StockTile(stockId: value))
                .toList(),
          );
        },
      ),
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
    // dynamic color = (change < 0) ? Colors.white30 : Colors.white30;
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetails(stockId: stockId)));
      },
      child: Hero(
        tag: stockId,
        child: Container(
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
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value['shortName'],
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Colors.grey[800],
                thickness: 2,
                indent: 20,
                endIndent: 20,
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
              Text(
                " (${change / 100}%)",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
