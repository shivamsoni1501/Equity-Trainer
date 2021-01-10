class LocalUser {
  static String uid;
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

  static Map<String, List<Map<String, String>>> history = {
    'AAPL': List(),
    'GOOG': List(),
    'MSFT': List(),
    'AMZN': List(),
    'FB': List(),
    'TSLA': List(),
    'BABA': List(),
    'V': List(),
    'NFLX': List(),
    'NKE': List()
  };

  updateLocalUser(String name, String phone, String email, String password) {
    LocalUser.userData['name'] = name;
    LocalUser.userData['phone'] = phone;
    LocalUser.userData['email'] = email;
    LocalUser.userData['password'] = password;
  }
}
