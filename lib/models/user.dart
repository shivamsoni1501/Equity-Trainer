class LocalUser {
  static String uid = 'NULL';
  static double tocken;
  static bool load = true;
  static Map<String, String> userData = {
    'name': 'First Last',
    'phone': '9999999999',
    'email': 'example@gmail.com',
    'password': 'example',
  };

  static List<String> stockList = [
    'AAPL',
    'GOOG',
    'MSFT',
    'AMZN',
    'FB',
    'TSLA',
    'BABA',
    'V',
    'NFLX',
    'NKE'
  ];

  static Map<String, Map<String, double>> stocks = {
    'AAPL': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'GOOG': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'MSFT': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'AMZN': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'FB': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'TSLA': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'BABA': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'V': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'NFLX': {'count': 0, 'totalSell': 0, 'totalBuy': 0},
    'NKE': {'count': 0, 'totalSell': 0, 'totalBuy': 0}
  };

  static List<Map<String, String>> history = [];

  static Map<String, List<Map<String, String>>> stocksHistory = {
    'AAPL': [],
    'GOOG': [],
    'MSFT': [],
    'AMZN': [],
    'FB': [],
    'TSLA': [],
    'BABA': [],
    'V': [],
    'NFLX': [],
    'NKE': []
  };

  static updateLocalUser(
      String name, String phone, String email, String password) {
    LocalUser.userData['name'] = name;
    LocalUser.userData['phone'] = phone;
    LocalUser.userData['email'] = email;
    LocalUser.userData['password'] = password;
  }

  static clear() {
    LocalUser.history.clear();
    LocalUser.stocksHistory.forEach((key, value) {
      stocksHistory[key].clear();
    });
    LocalUser.stocks.forEach((key, value) {
      value.forEach((key1, value1) {
        stocks[key][key1] = 0;
      });
    });
  }
}
