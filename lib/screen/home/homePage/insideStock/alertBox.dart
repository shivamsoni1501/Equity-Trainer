import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/database.dart';

class AlertBox extends StatefulWidget {
  final String stockId;
  AlertBox({this.stockId});
  @override
  _AlertBoxState createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  final TextEditingController nStockC = TextEditingController();
  bool switchSell = false;
  String error = ' ';
  toggle() {
    switchSell = !switchSell;
  }

  bool load = false;

  @override
  void initState() {
    nStockC.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String stockId = widget.stockId;
    Color color = (switchSell) ? Colors.red : Colors.green;
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "BUY",
            style: TextStyle(
                color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: switchSell,
            onChanged: (val) {
              setState(() {
                error = ' ';
                toggle();
              });
            },
            activeColor: Colors.red,
            inactiveThumbColor: Colors.green,
            inactiveTrackColor: Colors.green[900],
          ),
          Text(
            "SELL",
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(.6),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Available Stocks : ${LocalUser.stocks[stockId]['count'].toInt()}',
            style: TextStyle(fontSize: 20, color: color),
          ),
          SizedBox(height: 20),
          Text(
            "Quantity",
            style: TextStyle(color: color, fontSize: 12),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(flex: 10, child: SizedBox()),
              Expanded(
                flex: 7,
                child: TextField(
                  onSubmitted: (val) {
                    error = ' ';
                    if (val == '') {
                      nStockC.text = '1';
                    }
                    setState(() {});
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.pink,
                  style: TextStyle(color: color),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2)),
                  ),
                  controller: nStockC,
                ),
              ),
              Expanded(flex: 10, child: SizedBox()),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          (load)
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                )
              : Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[900], fontSize: 12),
                )
        ],
      ),
      actions: <Widget>[
        SizedBox.fromSize(
          size: Size(300, 40),
          child: FlatButton(
            color: switchSell
                ? Colors.red.withOpacity(.5)
                : Colors.green.withOpacity(.5),
            child: Text(
              "Confirm",
              style: TextStyle(fontSize: 20, color: color),
            ),
            onPressed: () async {
              int val;
              try {
                val = int.parse(nStockC.text);
                if (val < 1) {
                  error = 'Please Enter a valide number of stocks!';
                } else if (switchSell) {
                  // SELL
                  if (LocalUser.stocks[stockId]['count'] < val) {
                    error = 'Insufficient Funds!';
                  } else {
                    try {
                      setState(() {
                        load = true;
                      });
                      dynamic result = await FinanceQuote.getPrice(
                          quoteProvider: QuoteProvider.yahoo,
                          symbols: [stockId]);
                      double price = double.parse(result[stockId]['price']);
                      double total = price * val;

                      //updating LocalData
                      LocalUser.tocken += total;
                      LocalUser.stocks[stockId]['count'] -= val;
                      LocalUser.stocks[stockId]['totalSell'] += total;
                      LocalUser.history.add({
                        'stockId': stockId,
                        'time': DateTime.now().toString(),
                        'price': price.toString(),
                        'isSell': true.toString(),
                        'count': val.toString()
                      });

                      try {
                        //trying to update ServerData
                        print(LocalUser.history.length);
                        await DatabaseService().updateDatabase();
                        Navigator.pop(context);
                      } catch (e) {
                        //if fails then undoing all changes
                        LocalUser.tocken -= total.toInt();
                        LocalUser.stocks[stockId]['count'] += val;
                        LocalUser.stocks[stockId]['totalSell'] -= total;
                        LocalUser.history.removeLast();
                        error = 'Network Error!\ncheck your connection';
                      }
                    } catch (e) {
                      error = "Network Error!\ncheck your connection";
                    }
                    setState(() {
                      load = false;
                    });
                  }
                } else {
                  // BUY
                  try {
                    setState(() {
                      load = true;
                    });
                    dynamic result = await FinanceQuote.getPrice(
                        quoteProvider: QuoteProvider.yahoo, symbols: [stockId]);
                    double price = double.parse(result[stockId]['price']);
                    double total = price * val;
                    if (total > LocalUser.tocken) {
                      error = 'Insufficient Balance!';
                    } else {
                      // updating localData
                      LocalUser.tocken -= total;
                      LocalUser.stocks[stockId]['count'] += val;
                      LocalUser.stocks[stockId]['totalBuy'] += total;
                      LocalUser.history.add({
                        'stockId': stockId,
                        'time': DateTime.now().toString(),
                        'price': price.toString(),
                        'isSell': false.toString(),
                        'count': val.toString(),
                      });
                      try {
                        //trying to update serverData
                        await DatabaseService().updateDatabase();
                        Navigator.pop(context);
                        print(LocalUser.history.length);
                      } catch (e) {
                        //undoing all changes if fails
                        LocalUser.tocken += total.toInt();
                        LocalUser.stocks[stockId]['count'] -= val;
                        LocalUser.stocks[stockId]['totalBuy'] -= total;
                        LocalUser.history.removeLast();
                        error = 'Network Error!\ncheck your connection';
                      }
                    }
                  } catch (e) {
                    error = "Network Error!\ncheck your connection";
                  }
                  setState(() {
                    load = false;
                  });
                }
              } catch (e) {
                nStockC.text = '1';
                error = 'Please Enter a valide number of stocks!';
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
