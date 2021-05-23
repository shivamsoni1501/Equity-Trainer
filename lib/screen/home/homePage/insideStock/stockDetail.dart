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

  Map<String, String> images = {
    'AAPL':
        'https://cdn4.iconfinder.com/data/icons/apple-products-2026/512/Apple_Logo-128.png',
    'GOOG':
        'https://cdn4.iconfinder.com/data/icons/picons-social/57/09-google-3-512.png',
    'AMZN':
        'https://cdn3.iconfinder.com/data/icons/picons-social/57/27-amazon-128.png',
    'MSFT':
        'https://cdn3.iconfinder.com/data/icons/picons-social/57/32-windows8-128.png',
    'FB':
        'https://cdn3.iconfinder.com/data/icons/social-media-black-white-2/512/BW_Facebook_2_glyph_svg-128.png',
    'TSLA':
        'https://cdn2.iconfinder.com/data/icons/logos-9/64/Logos_tesla-256.png',
    'BABA': 'https://cdn.onlinewebfonts.com/svg/img_125353.png',
    'V':
        'https://cdn1.iconfinder.com/data/icons/picons-social/57/social_visa-128.png',
    'NFLX':
        'https://cdn4.iconfinder.com/data/icons/logos-and-brands-1/512/227_Netflix_logo-128.png',
    'NKE':
        'https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/230_Nike_logo-128.png'
  };

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

    color = (change < 0) ? Colors.red[800] : Colors.green[800];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        leading: Container(
          color: Colors.pink,
          child: Image.network(images[widget.stockId] ??
              'https://www.bing.com/th?id=OIP.Z2QqC4Dz1QJ3xEzej0UOUAHaJL&w=60&h=100&c=8&rs=1&qlt=90&dpr=1.25&pid=3.1&rm=2'),
        ),
        elevation: 80,
        shadowColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.stockId,
              child: Text(_value['symbol'],
                  style: Theme.of(context).textTheme.headline3),
            ),
            Text(_value['longName'],
                style: TextStyle(color: Colors.pink[800], fontSize: 12)),
          ],
        ),
        actions: [
          VerticalDivider(
            color: Colors.white54,
            indent: 20,
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
                children: [
                  Text(
                    _value['regularMarketPrice'].toString() ?? 'N.A.',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' USD',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  arrow(),
                  Text(
                    "${changeI / 100}\n(${change / 100}%)",
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                    ),
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
        padding: EdgeInsets.all(5),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            width: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "TODAY",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.pink,
                ),
                textL("Last Close"),
                textR('${_value['regularMarketPreviousClose']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Todays Open"),
                textR('${_value['regularMarketOpen']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Todays Prize"),
                textR('${_value['regularMarketPrice']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Todays Change"),
                textR("${changeI / 100} (${change / 100}%)"),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Todays High"),
                textR('${_value['regularMarketDayHigh']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Todays Low"),
                textR('${_value['regularMarketDayLow']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Market Volume"),
                textR('${_value['regularMarketVolume']}'),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            width: 500,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "PAST 52 WEEKs",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.pink,
                ),
                textL("High"),
                textR('${_value['fiftyTwoWeekHigh']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Low"),
                textR('${_value['fiftyTwoWeekLow']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("High Change"),
                textR("${changeIFH / 100} (${changeFH / 100}%)"),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Low Change"),
                textR("${changeIFL / 100} (${changeFL / 100}%)"),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            width: 500,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "FUNDAMENTALS",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.pink,
                ),
                textL("Market Cap"),
                textR('${_value['marketCap']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Currency"),
                textR('${_value['currency']}'),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Earning per Share"),
                textR("${_value['epsCurrentYear']}"),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("P/E ratio"),
                textR("${_value['trailingPE']}"),
                Divider(
                  color: Colors.white38,
                  indent: 20,
                  endIndent: 20,
                ),
                textL("Earning per Share (trailing year)"),
                textR("${_value['epsTrailingTwelveMonths']}"),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
