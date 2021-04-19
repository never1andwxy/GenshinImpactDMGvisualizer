import 'dart:html';

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genshin damage calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Genshin damage calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //ANCHOR characterstat
  int _counter = 0;
  int level = 80;
  int cons = 0;
  int natklv = 8;
  int eskilllv = 8;
  int eburstlv = 8;
  int weaponlv = 80;
  int weaponref = 1;

  String fsub1n = 'HP%';

  Map<int, int> cleveltoatk = {
    1: 26,
    10: 26,
    20: 68,
    30: 68,
    40: 135,
    50: 173,
    60: 217,
    70: 256,
    80: 295,
    90: 335
  };

  int levelatk = 0;

  Map<int, double> cleveltoPhysicalDMGpercent = {};
  double levelPhysicalDMGpercent = 0;
  Map<int, double> cleveltoPyroDMGpercent = {};
  double levelPyroDMGpercent = 0;
  Map<int, double> cleveltoHydroDMGpercent = {};
  double levelHydroDMGpercent = 0;
  Map<int, double> cleveltoCryoDMGpercent = {};
  double levelCryoDMGpercent = 0;
  Map<int, double> cleveltoElectroDMGpercent = {};
  double levelElectroDMGpercent = 0;
  Map<int, double> cleveltoAnemoDMGpercent = {};
  double levelAnemoDMGpercent = 0;
  Map<int, double> cleveltoGeoDMGpercent = {};
  double levelGeoDMGpercent = 0;

  Map<int, int> weapontoatk = {
    1: 46,
    5: 62,
    10: 82,
    15: 102,
    20: 122,
    25: 173,
    30: 194,
    35: 214,
    40: 235,
    45: 287,
    50: 308,
    55: 361,
    60: 382,
    65: 435,
    70: 457,
    75: 510,
    80: 532,
    85: 586,
    90: 608
  };

  Map<int, double> weapontoatkpercent = {
    1: 10.8,
    5: 12.5,
    10: 14.7,
    15: 16.9,
    20: 19.1,
    25: 21.3,
    30: 23.4,
    35: 25.6,
    40: 27.8,
    45: 30,
    50: 32.2,
    55: 34.4,
    60: 36.5,
    65: 38.7,
    70: 40.9,
    75: 43.1,
    80: 45.3,
    85: 47.4,
    90: 49.6
  };

  int lvldef = 0;

  Map<int, int> baseDEFbyLV = {
    1: 49,
    10: 49,
    20: 127,
    30: 169,
    40: 253,
    50: 326,
    60: 409,
    70: 482,
    80: 556,
    90: 630
  };
  Map<int, double> weapontodefpercent = {};

  Map<int, double> weapontoERpercent = {};

  Map<int, double> weapontoPhysicalDMGpercent = {};
  double weaponPhysicalDMGpercent = 0;
  Map<int, double> weapontoPyroDMGpercent = {};
  double weaponPyroDMGpercent = 0;
  Map<int, double> weapontoHydroDMGpercent = {};
  double weaponHydroDMGpercent = 0;
  Map<int, double> weapontoCryoDMGpercent = {};
  double weaponCryoDMGpercent = 0;
  Map<int, double> weapontoElectroDMGpercent = {};
  double weaponElectroDMGpercent = 0;
  Map<int, double> weapontoAnemoDMGpercent = {};
  double weaponAnemoDMGpercent = 0;
  Map<int, double> weapontoGeoDMGpercent = {};
  double weaponGeoDMGpercent = 0;

  int lvlhp = 0;

  Map<int, int> baseHPbyLV = {
    1: 763,
    10: 763,
    20: 1978,
    30: 2632,
    40: 3939,
    50: 5066,
    60: 6355,
    70: 7495,
    80: 8643,
    90: 9797,
  };
  Map<int, double> weapontoHPpercent = {};

  double baseCR = 5;
  Map<int, double> baseCRbylvl = {};
  double weaponCR = 0;
  Map<int, double> weaponCRbylvl = {};
  double bonusCR = 0;
  double allCR = 0;

  double baseCD = 0;
  double weaponCD = 0;
  double bonusCD = 0;
  double allCD = 0;

  Map<int, double> baseCDbyLVL = {
    1: 50,
    10: 50,
    20: 50,
    30: 50,
    40: 50,
    50: 59.6,
    60: 69.2,
    70: 69.2,
    80: 78.8,
    90: 88.4
  };

  Map<int, double> weaponCDbyLVL = {};

  int lvlEM = 0;
  Map<int, int> baseEMbylvl = {};
  int weaponEM = 0;
  Map<int, int> weapontoEM = {};

  double weaponHPpercent = 0;
  double weaponHPpercentstat = 0;
  double weaponatkpercent = 0;
  double weaponatkpercentstat = 0;
  double weapondefpercent = 0;
  double weapondefpercentstat = 0;
  double weaponERpercent = 0;
  double bonusatk = 0;
  double allatk = 0;
  double bonusdef = 0;
  double bonusER = 0;
  double alldef = 0;
  double allER = 0;
  double bonusHP = 0;
  double allHP = 0;
  int allEM = 0;
  int bonusEM = 0;

  double bonusPhysicalDMGpercent = 0;
  double bonusPyroDMGpercent = 0;
  double bonusHydroDMGpercent = 0;
  double bonusCryoDMGpercent = 0;
  double bonusElectroDMGpercent = 0;
  double bonusAnemoDMGpercent = 0;
  double bonusGeoDMGpercent = 0;

  int weaponatk = 0;
  int basicatk = 0;
  int basicdef = 0;

  //     'ATK%',
  //     'HP%',
  //     'DEF%',
  //     'EM',
  //     'ER',
  //     'CritRate',
  //     'CritDamage',
  //     'ATK',
  //     'HP',
  //     'DEF',

//ANCHOR artifact1stat
  int fstar = 5;
  int flv = 20;
  double stat1atkpercent = 0;
  bool stat1atkpercentOn = false;
  double stat1hppercent = 0;
  bool stat1hppercentOn = false;
  double stat1defpercent = 0;
  bool stat1defpercentOn = false;
  int stat1EM = 0;
  bool stat1EMOn = false;
  double stat1ERpercent = 0;
  bool stat1ERpercentOn = false;
  double stat1CRpercent = 0;
  bool stat1CRpercentOn = false;
  double stat1CDpercent = 0;
  bool stat1CDpercentOn = false;
  int stat1atk = 0;
  bool stat1atkOn = false;
  int stat1hp = 0;
  bool stat1hpOn = false;
  int stat1def = 0;
  bool stat1defOn = false;
  int checkstat1 = 0;

  int a1hp = 0;
  double a1percentatk = 0;
  double a1percentdef = 0;
  double a1percenthp = 0;

  var a1hpbyLVL = {
    4: {1: 828, 4: 1377, 8: 2108, 12: 2839, 16: 3571, 20: 3571},
    5: {1: 920, 4: 1530, 8: 2342, 12: 3155, 16: 3967, 20: 4780}
  };

//ANCHOR artifact2stat

  int pstar = 5;
  int plv = 20;
  double stat2atkpercent = 0;
  bool stat2atkpercentOn = false;
  double stat2hppercent = 0;
  bool stat2hppercentOn = false;
  double stat2defpercent = 0;
  bool stat2defpercentOn = false;
  int stat2EM = 0;
  bool stat2EMOn = false;
  double stat2ERpercent = 0;
  bool stat2ERpercentOn = false;
  double stat2CRpercent = 0;
  bool stat2CRpercentOn = false;
  double stat2CDpercent = 0;
  bool stat2CDpercentOn = false;
  int stat2atk = 0;
  bool stat2atkOn = false;
  int stat2hp = 0;
  bool stat2hpOn = false;
  int stat2def = 0;
  bool stat2defOn = false;
  int checkstat2 = 0;

  var a2atkbyLVL = {
    4: {1: 54, 4: 90, 8: 137, 12: 185, 16: 232, 20: 232},
    5: {1: 60, 4: 100, 8: 152, 12: 205, 16: 258, 20: 311}
  };

  int a2atk = 0;
  double a2percentatk = 0;
  double a2percentdef = 0;
  double a2percenthp = 0;

//ANCHOR artifact3stat
  int sstar = 5;
  int slv = 20;
  int artifact3mainstatcat = 2;
  double stat3atkpercent = 0;
  bool stat3atkpercentOn = false;
  double stat3hppercent = 0;
  bool stat3hppercentOn = false;
  double stat3defpercent = 0;
  bool stat3defpercentOn = false;
  int stat3EM = 0;
  bool stat3EMOn = false;
  double stat3ERpercent = 0;
  bool stat3ERpercentOn = false;
  double stat3CRpercent = 0;
  bool stat3CRpercentOn = false;
  double stat3CDpercent = 0;
  bool stat3CDpercentOn = false;
  int stat3atk = 0;
  bool stat3atkOn = false;
  int stat3hp = 0;
  bool stat3hpOn = false;
  int stat3def = 0;
  bool stat3defOn = false;
  int checkstat3 = 0;

  //1:HP% 2:ATK% 3:DEF% 4:EM 5:ER
  var a3HPpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a3HPpercentMain = 0;
  double a3percentHPMain = 0;
  double a3percentHP = 0;

  var a3atkpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a3atkpercentMain = 0;
  double a3percentatkMain = 0;
  double a3percentatk = 0;

  var a3defpercentbyLVL = {
    4: {1: 10.1, 4: 16.8, 8: 25.7, 12: 34.6, 16: 43.5, 20: 43.5},
    5: {1: 11.2, 4: 18.6, 8: 28.6, 12: 38.5, 16: 48.4, 20: 58.3}
  };

  double a3defpercentMain = 0;
  double a3percentdefMain = 0;
  double a3percentdef = 0;

  var a3ERpercentbyLVL = {
    4: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 38.7},
    5: {1: 10, 4: 16.6, 8: 25.4, 12: 34.2, 16: 43, 20: 51.8}
  };

  double a3ERpercentMain = 0;
  double a3percentERMain = 0;

  var a3EMbyLVL = {
    4: {1: 32, 4: 54, 8: 82, 12: 111, 16: 139, 20: 139},
    5: {1: 36, 4: 60, 8: 91, 12: 123, 16: 155, 20: 187}
  };

  int a3EMmain = 0;
  int a3EM = 0;

//ANCHOR artifact4stat
  int gstar = 5;
  int glv = 20;
  int artifact4mainstatcat = 8;
  double stat4atkpercent = 0;
  bool stat4atkpercentOn = false;
  double stat4hppercent = 0;
  bool stat4hppercentOn = false;
  double stat4defpercent = 0;
  bool stat4defpercentOn = false;
  int stat4EM = 0;
  bool stat4EMOn = false;
  double stat4ERpercent = 0;
  bool stat4ERpercentOn = false;
  double stat4CRpercent = 0;
  bool stat4CRpercentOn = false;
  double stat4CDpercent = 0;
  bool stat4CDpercentOn = false;
  int stat4atk = 0;
  bool stat4atkOn = false;
  int stat4hp = 0;
  bool stat4hpOn = false;
  int stat4def = 0;
  bool stat4defOn = false;
  int checkstat4 = 0;

  var a4HPpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a4HPpercentMain = 0;
  double a4percentHPMain = 0;
  double a4percentHP = 0;

  var a4atkpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a4atkpercentMain = 0;
  double a4percentatkMain = 0;
  double a4percentatk = 0;

  var a4defpercentbyLVL = {
    4: {1: 10.1, 4: 16.8, 8: 25.7, 12: 34.6, 16: 43.5, 20: 43.5},
    5: {1: 11.2, 4: 18.6, 8: 28.6, 12: 38.5, 16: 48.4, 20: 58.3}
  };

  double a4defpercentMain = 0;
  double a4percentdefMain = 0;
  double a4percentdef = 0;

  var a4EMbyLVL = {
    4: {1: 32, 4: 54, 8: 82, 12: 111, 16: 139, 20: 139},
    5: {1: 36, 4: 60, 8: 91, 12: 123, 16: 155, 20: 187}
  };

  int a4EMmain = 0;
  int a4EM = 0;

  var a4PhysicalDMGpercentbyLVL = {
    4: {1: 10.1, 4: 16.8, 8: 25.7, 12: 34.6, 16: 43.5, 20: 43.5},
    5: {1: 11.2, 4: 18.6, 8: 28.6, 12: 38.5, 16: 48.4, 20: 58.3}
  };
  double a4PhysicalDMGpercentMain = 0;
  double a4PhysicalDMGpercent = 0;

  var a4ElementDMGpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 44.6}
  };
  double a4PyroDMGpercentMain = 0;
  double a4HydroDMGpercentMain = 0;
  double a4CryoDMGpercentMain = 0;
  double a4ElectroDMGpercentMain = 0;
  double a4AnemoDMGpercentMain = 0;
  double a4GeoDMGpercentMain = 0;

  double a4PyroDMGpercent = 0;
  double a4HydroDMGpercent = 0;
  double a4CryoDMGpercent = 0;
  double a4ElectroDMGpercent = 0;
  double a4AnemoDMGpercent = 0;
  double a4GeoDMGpercent = 0;

//ANCHOR artifact5stat
  int cstar = 5;
  int clv = 20;
  int artifact5mainstatcat = 6;
  double stat5atkpercent = 0;
  bool stat5atkpercentOn = false;
  double stat5hppercent = 0;
  bool stat5hppercentOn = false;
  double stat5defpercent = 0;
  bool stat5defpercentOn = false;
  int stat5EM = 0;
  bool stat5EMOn = false;
  double stat5ERpercent = 0;
  bool stat5ERpercentOn = false;
  double stat5CRpercent = 0;
  bool stat5CRpercentOn = false;
  double stat5CDpercent = 0;
  bool stat5CDpercentOn = false;
  int stat5atk = 0;
  bool stat5atkOn = false;
  int stat5hp = 0;
  bool stat5hpOn = false;
  int stat5def = 0;
  bool stat5defOn = false;
  int checkstat5 = 0;

  var a5HPpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a5HPpercentMain = 0;
  double a5percentHPMain = 0;
  double a5percentHP = 0;

  var a5atkpercentbyLVL = {
    4: {1: 8.1, 4: 13.4, 8: 20.6, 12: 27.7, 16: 34.8, 20: 34.8},
    5: {1: 9, 4: 14.9, 8: 22.8, 12: 30.8, 16: 38.7, 20: 46.6}
  };

  double a5atkpercentMain = 0;
  double a5percentatkMain = 0;
  double a5percentatk = 0;

  var a5defpercentbyLVL = {
    4: {1: 10.1, 4: 16.8, 8: 25.7, 12: 34.6, 16: 43.5, 20: 43.5},
    5: {1: 11.2, 4: 18.6, 8: 28.6, 12: 38.5, 16: 48.4, 20: 58.3}
  };

  double a5defpercentMain = 0;
  double a5percentdefMain = 0;
  double a5percentdef = 0;

  var a5EMbyLVL = {
    4: {1: 32, 4: 54, 8: 82, 12: 111, 16: 139, 20: 139},
    5: {1: 36, 4: 60, 8: 91, 12: 123, 16: 155, 20: 187}
  };

  int a5EMmain = 0;
  int a5EM = 0;

  var a5CRbyLVL = {
    4: {1: 5.4, 4: 9, 8: 13.7, 12: 18.5, 16: 23.2, 20: 23.2},
    5: {1: 6, 4: 9.9, 8: 15.2, 12: 20.5, 16: 25.8, 20: 31.1}
  };

  double a5CRmain = 0;
  double a5CR = 0;

  var a5CDbyLVL = {
    4: {1: 10.8, 4: 17.9, 8: 27.4, 12: 36.9, 16: 46.4, 20: 46.4},
    5: {1: 12, 4: 19.9, 8: 30.5, 12: 41, 16: 51.6, 20: 62.2}
  };

  double a5CDmain = 0;
  double a5CD = 0;

  //ANCHOR enemystat
  int enemylv = 80;
  int enemydefdebuff = 0;
  int enemytype = 1;
  int enemyPhysicalres = 10;
  int enemyPyrores = 10;
  int enemyHydrores = 10;
  int enemyDendrores = 10;
  int enemyElectrores = 10;
  int enemyAnemores = 10;
  int enemyCryores = 10;
  int enemyGeores = 10;
  int enemyPhysicalresv = 10;
  int enemyPyroresv = 10;
  int enemyHydroresv = 10;
  int enemyDendroresv = 10;
  int enemyElectroresv = 10;
  int enemyAnemoresv = 10;
  int enemyCryoresv = 10;
  int enemyGeoresv = 10;

  var eneresbytype = {
    1: {
      'physical': 10,
      'pyro': 10,
      'hydro': 10,
      'dendro': 10,
      'electro': 10,
      'anemo': 10,
      'cryo': 10,
      'geo': 10
    },
    2: {
      'physical': 70,
      'pyro': 10,
      'hydro': 10,
      'dendro': 10,
      'electro': 10,
      'anemo': 10,
      'cryo': 10,
      'geo': 10
    },
    3: {
      'physical': -20,
      'pyro': 10,
      'hydro': 10,
      'dendro': 10,
      'electro': 10,
      'anemo': 10,
      'cryo': 10,
      'geo': 10
    },
    4: {
      'physical': 10,
      'pyro': 10,
      'hydro': 10,
      'dendro': 10,
      'electro': 10,
      'anemo': 999,
      'cryo': 999,
      'geo': 10
    }
  };

  //ANCHOR skilldamagestat
  var natklvtoskill = {
    '1hitDMG': {
      1: 31.73,
      2: 34.32,
      3: 36.9,
      4: 40.59,
      5: 43.17,
      6: 46.13,
      7: 50.18,
      8: 54.24,
      9: 58.3,
      10: 62.73,
      11: 67.8,
      12: 73.77,
      13: 79.74,
      14: 85.7,
      15: 92.21,
    },
    '2hitDMG': {
      1: 35.6,
      2: 38.5,
      3: 41.4,
      4: 45.54,
      5: 48.44,
      6: 51.75,
      7: 56.3,
      8: 60.86,
      9: 65.41,
      10: 70.38,
      11: 76.07,
      12: 82.77,
      13: 89.46,
      14: 96.16,
      15: 103.46,
    },
    '3hitDMG': {
      1: 45.49,
      2: 49.2,
      3: 52.9,
      4: 58.19,
      5: 61.89,
      6: 66.13,
      7: 71.94,
      8: 77.76,
      9: 83.58,
      10: 89.93,
      11: 97.2,
      12: 105.76,
      13: 114.31,
      14: 122.87,
      15: 132.2,
    },
    '4hitDMG': {
      1: 45.49,
      2: 49.2,
      3: 52.9,
      4: 58.19,
      5: 61.89,
      6: 66.13,
      7: 71.94,
      8: 77.76,
      9: 83.58,
      10: 89.93,
      11: 97.2,
      12: 105.76,
      13: 114.31,
      14: 122.87,
      15: 132.2,
    },
    '5hitDMG': {
      1: 48.25,
      2: 52.17,
      3: 56.1,
      4: 61.71,
      5: 65.64,
      6: 70.13,
      7: 76.3,
      8: 82.47,
      9: 88.64,
      10: 95.37,
      11: 103.08,
      12: 112.16,
      13: 121.23,
      14: 130.3,
      15: 140.19,
    },
    '6hitDMG': {
      1: 57.62,
      2: 62.31,
      3: 67,
      4: 73.7,
      5: 78.39,
      6: 83.75,
      7: 91.12,
      8: 98.49,
      9: 105.86,
      10: 113.9,
      11: 123.11,
      12: 133.95,
      13: 144.78,
      14: 155.61,
      15: 167.43,
    },
    'AimShootDMG': {
      1: 43.86,
      2: 47.43,
      3: 51,
      4: 56.1,
      5: 59.67,
      6: 63.75,
      7: 69.36,
      8: 74.97,
      9: 80.58,
      10: 86.7,
      11: 92.82,
      12: 98.94,
      13: 105.06,
      14: 111.18,
      15: 117.3,
    },
    'ChargedAimShootDMG': {
      1: 124,
      2: 133.3,
      3: 142.6,
      4: 155,
      5: 164.3,
      6: 173.6,
      7: 186,
      8: 198.4,
      9: 210.8,
      10: 223.2,
      11: 235.6,
      12: 248,
      13: 263.5,
      14: 279,
      15: 294.5,
    },
    'PlungeDMG': {
      1: 56.83,
      2: 61.45,
      3: 66.08,
      4: 72.69,
      5: 77.31,
      6: 82.6,
      7: 89.87,
      8: 97.14,
      9: 104.41,
      10: 112.34,
      11: 120.27,
      12: 128.2,
      13: 136.12,
      14: 144.05,
      15: 151.98,
    },
    'LPlungeDMG': {
      1: 113.63,
      2: 122.88,
      3: 132.13,
      4: 145.35,
      5: 154.59,
      6: 165.17,
      7: 179.7,
      8: 194.23,
      9: 208.77,
      10: 224.62,
      11: 240.48,
      12: 256.34,
      13: 272.19,
      14: 288.05,
      15: 303.9,
    },
    'HPlungeDMG': {
      1: 141.93,
      2: 153.49,
      3: 165.04,
      4: 181.54,
      5: 193.1,
      6: 206.3,
      7: 224.45,
      8: 242.61,
      9: 260.76,
      10: 280.57,
      11: 300.37,
      12: 320.18,
      13: 339.98,
      14: 359.79,
      15: 379.59,
    },
    'Frostflake Arrow DMG': {
      1: 128,
      2: 137.6,
      3: 147.2,
      4: 160,
      5: 169.6,
      6: 179.2,
      7: 192,
      8: 204.8,
      9: 217.6,
      10: 230.4,
      11: 243.2,
      12: 256,
      13: 272,
      14: 288,
      15: 304,
    },
    'Frostflake Arrow Bloom DMG': {
      1: 217.6,
      2: 233.92,
      3: 250.24,
      4: 272,
      5: 288.32,
      6: 304.64,
      7: 326.4,
      8: 348.16,
      9: 369.92,
      10: 391.68,
      11: 413.44,
      12: 435.2,
      13: 462.4,
      14: 489.6,
      15: 516.8,
    },
    'Trail of the Qilin DMG': {
      1: 132,
      2: 141.9,
      3: 151.8,
      4: 165,
      5: 174.9,
      6: 184.8,
      7: 198,
      8: 211.2,
      9: 224.4,
      10: 237.6,
      11: 250.8,
      12: 264,
      13: 280.5,
      14: 297,
      15: 313.5,
    },
    'Trail of the Qilin HP': {
      1: 120,
      2: 129,
      3: 138,
      4: 150,
      5: 159,
      6: 1688,
      7: 180,
      8: 192,
      9: 204,
      10: 216,
      11: 228,
      12: 240,
      13: 255,
      14: 270,
      15: 285,
    },
    'Celestial Shower DMG': {
      1: 70.27,
      2: 75.54,
      3: 80.81,
      4: 87.84,
      5: 93.11,
      6: 98.38,
      7: 105.41,
      8: 112.44,
      9: 119.46,
      10: 126.49,
      11: 133.52,
      12: 140.54,
      13: 149.33,
      14: 158.11,
      15: 166.9,
    },
  };

  double hit1dmgpercent = 0;
  double hit2dmgpercent = 0;
  double hit3dmgpercent = 0;
  double hit4dmgpercent = 0;
  double hit5dmgpercent = 0;
  double hit6dmgpercent = 0;
  double aimdmgpercent = 0;
  double caimdmgpercent = 0;
  double plungedmgpercent = 0;
  double lplungedmgpercent = 0;
  double hplungedmgpercent = 0;

  double frostflakedmgpercent = 0;
  double frostflakebloomdmgpercent = 0;

  double hit1dmgnc = 0;
  double hit1dmgexp = 0;
  double hit1dmgc = 0;

  double hit2dmgnc = 0;
  double hit2dmgexp = 0;
  double hit2dmgc = 0;

  double hit3dmgnc = 0;
  double hit3dmgexp = 0;
  double hit3dmgc = 0;

  double hit4dmgnc = 0;
  double hit4dmgexp = 0;
  double hit4dmgc = 0;

  double hit5dmgnc = 0;
  double hit5dmgexp = 0;
  double hit5dmgc = 0;

  double hit6dmgnc = 0;
  double hit6dmgexp = 0;
  double hit6dmgc = 0;

  double plungedmgnc = 0;
  double plungedmgexp = 0;
  double plungedmgc = 0;

  double lplungedmgnc = 0;
  double lplungedmgexp = 0;
  double lplungedmgc = 0;

  double hplungedmgnc = 0;
  double hplungedmgexp = 0;
  double hplungedmgc = 0;

  double aimdmgnc = 0;
  double aimdmgexp = 0;
  double aimdmgc = 0;

  double caimdmgnc = 0;
  double caimdmgexp = 0;
  double caimdmgc = 0;

  double frostflakedmgnc = 0;
  double frostflakedmgexp = 0;
  double frostflakedmgc = 0;

  double frostflakebloomdmgnc = 0;
  double frostflakebloomdmgexp = 0;
  double frostflakebloomdmgc = 0;

  double frostflakealldmgnc = 0;
  double frostflakealldmgexp = 0;
  double frostflakealldmgc = 0;

  double trailoftheqilindmgpercent = 0;
  double trailoftheqilinhppercent = 0;
  double celestialshowerdmgpercent = 0;
  double trailoftheqilindmgnc = 0;
  double trailoftheqilindmgexp = 0;
  double trailoftheqilindmgc = 0;
  double trailoftheqilinhp = 0;
  double celestialshowerdmgnc = 0;
  double celestialshowerdmgexp = 0;
  double celestialshowerdmgc = 0;

  String _label = '';

  void _setLabel(String s) {
    if (s == null) {
      return;
    }
    setState(() => _label = s);
  }

  //ANCHOR artifact1Popup
  Future _showSimpleDialog() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Set artifact stats:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1atkpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1atkpercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1atkpercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK%:$stat1atkpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1atkpercent.toString(),
                        value: stat1atkpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1atkpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      _setLabel(stat1atkpercent.toString());
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1hppercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1hppercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1hppercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP%:$stat1hppercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1hppercent.toString(),
                        value: stat1hppercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1hppercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1defpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1defpercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1defpercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF%:$stat1defpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 43.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1defpercent.toString(),
                        value: stat1defpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1defpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1CRpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1CRpercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1CRpercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Rate%:$stat1CRpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 23.4,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1CRpercent.toString(),
                        value: stat1CRpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1CRpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1CDpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1CDpercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1CDpercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Damage%:$stat1CDpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 46.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1CDpercent.toString(),
                        value: stat1CDpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1CDpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1EMOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1EMOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1EMOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('Elemental Mastery:$stat1EM'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1EM.toString(),
                        value: stat1EM.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1EM = value.toInt();
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1ERpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1ERpercentOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1ERpercentOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('Energy Recharge%:$stat1ERpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 39,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1ERpercent.toString(),
                        value: stat1ERpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1ERpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1hpOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1hpOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1hpOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP:$stat1hp'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 1794,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1hp.toString(),
                        value: stat1hp.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1hp = value.toInt();
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1atkOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1atkOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      } else {
                                        checkstat1--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1atkOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK:$stat1atk'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 114,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1atk.toString(),
                        value: stat1atk.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1atk = value.toInt();
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat1defOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat1 < 4) {
                                      stat1defOn = value;

                                      _setLabel(stat1atkpercent.toString());

                                      if (value) {
                                        checkstat1++;
                                      }
                                    } else {
                                      if (!value) {
                                        stat1defOn = value;

                                        _setLabel(stat1atkpercent.toString());

                                        checkstat1--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF:$stat1def'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat1def.toString(),
                        value: stat1def.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat1def = value.toInt();
                            _setLabel(stat1atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  //ANCHOR artifact2Popup
  Future _showSimpleDialog2() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Set artifact stats:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2atkpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2atkpercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2atkpercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK%:$stat2atkpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2atkpercent.toString(),
                        value: stat2atkpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2atkpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      _setLabel(stat2atkpercent.toString());
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2hppercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2hppercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2hppercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP%:$stat2hppercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2hppercent.toString(),
                        value: stat2hppercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2hppercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2defpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2defpercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2defpercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF%:$stat2defpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 43.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2defpercent.toString(),
                        value: stat2defpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2defpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2CRpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2CRpercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2CRpercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Rate%:$stat2CRpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 23.4,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2CRpercent.toString(),
                        value: stat2CRpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2CRpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2CDpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2CDpercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2CDpercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Damage%:$stat2CDpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 46.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2CDpercent.toString(),
                        value: stat2CDpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2CDpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2EMOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2EMOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2EMOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('Elemental Mastery:$stat2EM'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2EM.toString(),
                        value: stat2EM.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2EM = value.toInt();
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2ERpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2ERpercentOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2ERpercentOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('Energy Recharge%:$stat2ERpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 39,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2ERpercent.toString(),
                        value: stat2ERpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2ERpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2hpOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2hpOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2hpOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP:$stat2hp'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 1794,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2hp.toString(),
                        value: stat2hp.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2hp = value.toInt();
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2atkOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2atkOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      } else {
                                        checkstat2--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2atkOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK:$stat2atk'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 114,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2atk.toString(),
                        value: stat2atk.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2atk = value.toInt();
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat2defOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat2 < 4) {
                                      stat2defOn = value;

                                      _setLabel(stat2atkpercent.toString());

                                      if (value) {
                                        checkstat2++;
                                      }
                                    } else {
                                      if (!value) {
                                        stat2defOn = value;

                                        _setLabel(stat2atkpercent.toString());

                                        checkstat2--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF:$stat2def'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat2def.toString(),
                        value: stat2def.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat2def = value.toInt();
                            _setLabel(stat2atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  //ANCHOR artifact3Popup
  Future _showSimpleDialog3() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Set artifact stats:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3atkpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3atkpercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3atkpercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK%:$stat3atkpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3atkpercent.toString(),
                        value: stat3atkpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3atkpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      _setLabel(stat3atkpercent.toString());
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3hppercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3hppercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3hppercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP%:$stat3hppercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3hppercent.toString(),
                        value: stat3hppercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3hppercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3defpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3defpercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3defpercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF%:$stat3defpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 43.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3defpercent.toString(),
                        value: stat3defpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3defpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3CRpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3CRpercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3CRpercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Rate%:$stat3CRpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 23.4,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3CRpercent.toString(),
                        value: stat3CRpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3CRpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3CDpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3CDpercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3CDpercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Damage%:$stat3CDpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 46.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3CDpercent.toString(),
                        value: stat3CDpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3CDpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3EMOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3EMOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3EMOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('Elemental Mastery:$stat3EM'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3EM.toString(),
                        value: stat3EM.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3EM = value.toInt();
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3ERpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3ERpercentOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3ERpercentOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('Energy Recharge%:$stat3ERpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 39,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3ERpercent.toString(),
                        value: stat3ERpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3ERpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3hpOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3hpOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3hpOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP:$stat3hp'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 1794,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3hp.toString(),
                        value: stat3hp.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3hp = value.toInt();
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3atkOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3atkOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      } else {
                                        checkstat3--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3atkOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK:$stat3atk'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 114,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3atk.toString(),
                        value: stat3atk.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3atk = value.toInt();
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat3defOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat3 < 4) {
                                      stat3defOn = value;

                                      _setLabel(stat3atkpercent.toString());

                                      if (value) {
                                        checkstat3++;
                                      }
                                    } else {
                                      if (!value) {
                                        stat3defOn = value;

                                        _setLabel(stat3atkpercent.toString());

                                        checkstat3--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF:$stat3def'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat3def.toString(),
                        value: stat3def.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat3def = value.toInt();
                            _setLabel(stat3atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  //ANCHOR artifact4Popup
  Future _showSimpleDialog4() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Set artifact stats:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4atkpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4atkpercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4atkpercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK%:$stat4atkpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4atkpercent.toString(),
                        value: stat4atkpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4atkpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      _setLabel(stat4atkpercent.toString());
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4hppercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4hppercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4hppercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP%:$stat4hppercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4hppercent.toString(),
                        value: stat4hppercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4hppercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4defpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4defpercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4defpercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF%:$stat4defpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 43.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4defpercent.toString(),
                        value: stat4defpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4defpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4CRpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4CRpercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4CRpercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Rate%:$stat4CRpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 23.4,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4CRpercent.toString(),
                        value: stat4CRpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4CRpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4CDpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4CDpercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4CDpercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Damage%:$stat4CDpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 46.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4CDpercent.toString(),
                        value: stat4CDpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4CDpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4EMOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4EMOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4EMOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('Elemental Mastery:$stat4EM'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4EM.toString(),
                        value: stat4EM.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4EM = value.toInt();
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4ERpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4ERpercentOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4ERpercentOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('Energy Recharge%:$stat4ERpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 39,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4ERpercent.toString(),
                        value: stat4ERpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4ERpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4hpOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4hpOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4hpOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP:$stat4hp'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 1794,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4hp.toString(),
                        value: stat4hp.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4hp = value.toInt();
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4atkOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4atkOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      } else {
                                        checkstat4--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4atkOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK:$stat4atk'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 114,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4atk.toString(),
                        value: stat4atk.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4atk = value.toInt();
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat4defOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat4 < 4) {
                                      stat4defOn = value;

                                      _setLabel(stat4atkpercent.toString());

                                      if (value) {
                                        checkstat4++;
                                      }
                                    } else {
                                      if (!value) {
                                        stat4defOn = value;

                                        _setLabel(stat4atkpercent.toString());

                                        checkstat4--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF:$stat4def'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat4def.toString(),
                        value: stat4def.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat4def = value.toInt();
                            _setLabel(stat4atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  //ANCHOR artifact5Popup
  Future _showSimpleDialog5() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Set artifact stats:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5atkpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5atkpercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5atkpercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK%:$stat5atkpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5atkpercent.toString(),
                        value: stat5atkpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5atkpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      _setLabel(stat5atkpercent.toString());
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5hppercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5hppercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5hppercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP%:$stat5hppercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 34.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5hppercent.toString(),
                        value: stat5hppercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5hppercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5defpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5defpercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5defpercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF%:$stat5defpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 43.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5defpercent.toString(),
                        value: stat5defpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5defpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5CRpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5CRpercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5CRpercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Rate%:$stat5CRpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 23.4,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5CRpercent.toString(),
                        value: stat5CRpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5CRpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5CDpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5CDpercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5CDpercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('Critical Damage%:$stat5CDpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 46.8,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5CDpercent.toString(),
                        value: stat5CDpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5CDpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5EMOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5EMOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5EMOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('Elemental Mastery:$stat5EM'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5EM.toString(),
                        value: stat5EM.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5EM = value.toInt();
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5ERpercentOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5ERpercentOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5ERpercentOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('Energy Recharge%:$stat5ERpercent'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 39,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5ERpercent.toString(),
                        value: stat5ERpercent.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5ERpercent =
                                double.parse((value).toStringAsFixed(1));
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5hpOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5hpOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5hpOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('HP:$stat5hp'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 1794,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5hp.toString(),
                        value: stat5hp.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5hp = value.toInt();
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5atkOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5atkOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      } else {
                                        checkstat5--;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5atkOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('ATK:$stat5atk'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 114,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5atk.toString(),
                        value: stat5atk.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5atk = value.toInt();
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Checkbox(
                                value: stat5defOn,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (checkstat5 < 4) {
                                      stat5defOn = value;

                                      _setLabel(stat5atkpercent.toString());

                                      if (value) {
                                        checkstat5++;
                                      }
                                    } else {
                                      if (!value) {
                                        stat5defOn = value;

                                        _setLabel(stat5atkpercent.toString());

                                        checkstat5--;
                                      }
                                    }
                                  });
                                }),
                            Text('DEF:$stat5def'),
                          ],
                        ),
                      ),
                      title: Slider(
                        min: 0,
                        max: 138,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue[50],
                        label: stat5def.toString(),
                        value: stat5def.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            stat5def = value.toInt();
                            _setLabel(stat5atkpercent.toString());
                          });
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

//ANCHOR ---home----calculation
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    //
    //ATK params

    levelatk = cleveltoatk[level];
    weaponatk = weapontoatk[weaponlv];

    basicatk = levelatk + weaponatk;

    a1percentatk = stat1atkpercentOn ? basicatk * stat1atkpercent / 100 : 0;
    a2percentatk = stat2atkpercentOn ? basicatk * stat2atkpercent / 100 : 0;
    a3percentatk = stat3atkpercentOn ? basicatk * stat3atkpercent / 100 : 0;
    a4percentatk = stat4atkpercentOn ? basicatk * stat4atkpercent / 100 : 0;
    a5percentatk = stat5atkpercentOn ? basicatk * stat5atkpercent / 100 : 0;

    weaponatkpercent = weapontoatkpercent[weaponlv];

    weaponatkpercentstat = basicatk * weaponatkpercent / 100;

    a2atk = a2atkbyLVL[pstar][plv];
    a3atkpercentMain = a3atkpercentbyLVL[sstar][slv];
    a4atkpercentMain = a4atkpercentbyLVL[gstar][glv];
    a5atkpercentMain = a5atkpercentbyLVL[cstar][clv];

    a3percentatkMain =
        (artifact3mainstatcat == 2) ? basicatk * a3atkpercentMain / 100 : 0;
    a4percentatkMain =
        artifact4mainstatcat == 2 ? basicatk * a4atkpercentMain / 100 : 0;
    a5percentatkMain =
        artifact5mainstatcat == 2 ? basicatk * a5atkpercentMain / 100 : 0;

    bonusatk = weaponatkpercentstat +
        a1percentatk +
        stat1atk +
        a2atk +
        a2percentatk +
        a3percentatkMain +
        a3percentatk +
        stat3atk +
        a4percentatkMain +
        a4percentatk +
        stat4atk +
        a5percentatkMain +
        a5percentatk +
        stat5atk;

    allatk = basicatk + bonusatk;

    //DEF params
    lvldef = baseDEFbyLV[level];

    weapondefpercent = weapontodefpercent[weaponlv];

    if (weapondefpercent != null) {
      weapondefpercentstat = lvldef * weapondefpercent / 100;
    } else {
      weapondefpercentstat = 0;
    }

    a1percentdef = stat1defpercentOn ? lvldef * stat1defpercent / 100 : 0;
    a2percentdef = stat2defpercentOn ? lvldef * stat2defpercent / 100 : 0;
    a3percentdef = stat3defpercentOn ? lvldef * stat3defpercent / 100 : 0;
    a4percentdef = stat4defpercentOn ? lvldef * stat4defpercent / 100 : 0;
    a5percentdef = stat5defpercentOn ? lvldef * stat5defpercent / 100 : 0;

    a3defpercentMain = a3defpercentbyLVL[sstar][slv];
    a4defpercentMain = a4defpercentbyLVL[gstar][glv];
    a5defpercentMain = a5defpercentbyLVL[cstar][clv];

    a3percentdefMain =
        (artifact3mainstatcat == 3) ? lvldef * a3defpercentMain / 100 : 0;
    a4percentdefMain =
        artifact4mainstatcat == 3 ? lvldef * a4defpercentMain / 100 : 0;
    a5percentdefMain =
        artifact5mainstatcat == 3 ? lvldef * a5defpercentMain / 100 : 0;

    bonusdef = weapondefpercentstat +
        a1percentdef +
        stat1def +
        a2percentdef +
        stat2def +
        a3percentdefMain +
        a3percentdef +
        stat3def +
        a4percentdefMain +
        a4percentdef +
        stat4def +
        a5percentdefMain +
        a5percentdef +
        stat5def;

    alldef = lvldef + bonusdef;

    //HP params
    lvlhp = baseHPbyLV[level];
    if (weapontoHPpercent[weaponlv] != null) {
      weaponHPpercent = weapontoHPpercent[weaponlv];
      weaponHPpercentstat = lvlhp * weaponHPpercent / 100;
    } else {
      weaponHPpercentstat = 0;
    }

    a1percenthp = stat1hppercentOn ? lvlhp * stat1hppercent / 100 : 0;
    a2percenthp = stat2hppercentOn ? lvlhp * stat2hppercent / 100 : 0;
    a3percentHP = stat3hppercentOn ? lvlhp * stat3hppercent / 100 : 0;
    a4percentHP = stat4hppercentOn ? lvlhp * stat4hppercent / 100 : 0;
    a5percentHP = stat5hppercentOn ? lvlhp * stat5hppercent / 100 : 0;

    a1hp = a1hpbyLVL[fstar][flv];
    a3HPpercentMain = a3HPpercentbyLVL[sstar][slv];
    a4HPpercentMain = a4HPpercentbyLVL[gstar][glv];
    a5HPpercentMain = a5HPpercentbyLVL[cstar][clv];

    a3percentHPMain =
        (artifact3mainstatcat == 1) ? lvlhp * a3HPpercentMain / 100 : 0;
    a4percentHPMain =
        artifact4mainstatcat == 1 ? lvlhp * a4HPpercentMain / 100 : 0;
    a5percentHPMain =
        artifact5mainstatcat == 1 ? lvlhp * a5HPpercentMain / 100 : 0;

    bonusHP = weaponHPpercentstat +
        a1percenthp +
        stat1hp +
        a1hp +
        a2percenthp +
        stat2hp +
        a3percentHPMain +
        a3percentHP +
        stat3hp +
        a4percentHPMain +
        a4percentHP +
        stat4hp +
        a5percentHPMain +
        a5percentHP +
        stat5hp;

    allHP = lvlhp + bonusHP;

    //ER params
    if (weapontoERpercent[weaponlv] != null)
      weaponERpercent = weapontoERpercent[weaponlv];

    a3ERpercentMain = a3ERpercentbyLVL[sstar][slv];
    a3percentERMain = artifact3mainstatcat == 5 ? a3ERpercentMain : 0;

    bonusER = weaponERpercent +
        a3percentERMain +
        stat1ERpercent +
        stat2ERpercent +
        stat3ERpercent +
        stat4ERpercent +
        stat5ERpercent;

    allER = 100 + bonusER;

    //EM params
    if (weapontoEM[weaponlv] != null) weaponEM = weapontoEM[weaponlv];

    a3EMmain = a3EMbyLVL[sstar][slv];
    a4EMmain = a4EMbyLVL[gstar][glv];
    a5EMmain = a5EMbyLVL[cstar][clv];
    a3EM = artifact3mainstatcat == 4 ? a3EMmain : 0;
    a4EMmain = a4EMbyLVL[sstar][slv];
    a4EM = artifact4mainstatcat == 4 ? a4EMmain : 0;
    a5EMmain = a5EMbyLVL[sstar][slv];
    a5EM = artifact5mainstatcat == 4 ? a5EMmain : 0;

    lvlEM += weaponEM;
    bonusEM =
        a3EM + a4EM + a5EM + stat1EM + stat2EM + stat3EM + stat4EM + stat5EM;

    allEM = lvlEM + bonusEM;

    //CR params
    if (baseCRbylvl[level] != null) baseCR = baseCRbylvl[level];
    if (weaponCRbylvl[weaponlv] != null) weaponCR = weaponCRbylvl[weaponlv];
    a5CRmain = a5CRbyLVL[cstar][clv];
    a5CR = artifact5mainstatcat == 5 ? a5CRmain : 0;
    baseCR += weaponCR;
    bonusCR = a5CR +
        stat1CRpercent +
        stat2CRpercent +
        stat3CRpercent +
        stat4CRpercent +
        stat5CRpercent;
    allCR = baseCR + bonusCR;

    //CD params
    if (baseCDbyLVL[level] != null) baseCD = baseCDbyLVL[level];
    if (weaponCDbyLVL[weaponlv] != null) weaponCD = weaponCDbyLVL[weaponlv];
    a5CDmain = a5CDbyLVL[cstar][clv];
    a5CD = artifact5mainstatcat == 6 ? a5CDmain : 0;
    baseCD += weaponCD;
    bonusCD = a5CD +
        stat1CDpercent +
        stat2CDpercent +
        stat3CDpercent +
        stat4CDpercent +
        stat5CDpercent;
    allCD = baseCD + bonusCD;

    //DMG params
    if (cleveltoPhysicalDMGpercent[level] != null)
      levelPhysicalDMGpercent = cleveltoPhysicalDMGpercent[level];
    if (weapontoPhysicalDMGpercent[weaponlv] != null)
      weaponPhysicalDMGpercent = weapontoPhysicalDMGpercent[weaponlv];

    a4PhysicalDMGpercentMain = a4PhysicalDMGpercentbyLVL[sstar][slv];
    a4PhysicalDMGpercent =
        artifact4mainstatcat == 5 ? a4PhysicalDMGpercentMain : 0;

    bonusPhysicalDMGpercent = levelPhysicalDMGpercent +
        weaponPhysicalDMGpercent +
        a4PhysicalDMGpercent;

    if (cleveltoPyroDMGpercent[level] != null)
      levelPyroDMGpercent = cleveltoPyroDMGpercent[level];
    if (weapontoPyroDMGpercent[weaponlv] != null)
      weaponPyroDMGpercent = weapontoPyroDMGpercent[weaponlv];

    a4PyroDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4PyroDMGpercent = artifact4mainstatcat == 6 ? a4PyroDMGpercentMain : 0;

    bonusPyroDMGpercent =
        levelPyroDMGpercent + weaponPyroDMGpercent + a4PyroDMGpercent;

    if (cleveltoHydroDMGpercent[level] != null)
      levelHydroDMGpercent = cleveltoHydroDMGpercent[level];
    if (weapontoHydroDMGpercent[weaponlv] != null)
      weaponHydroDMGpercent = weapontoHydroDMGpercent[weaponlv];

    a4HydroDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4HydroDMGpercent = artifact4mainstatcat == 7 ? a4HydroDMGpercentMain : 0;

    bonusHydroDMGpercent =
        levelHydroDMGpercent + weaponHydroDMGpercent + a4HydroDMGpercent;

    if (cleveltoCryoDMGpercent[level] != null)
      levelCryoDMGpercent = cleveltoCryoDMGpercent[level];
    if (weapontoCryoDMGpercent[weaponlv] != null)
      weaponCryoDMGpercent = weapontoCryoDMGpercent[weaponlv];

    a4CryoDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4CryoDMGpercent = artifact4mainstatcat == 8 ? a4CryoDMGpercentMain : 0;

    bonusCryoDMGpercent =
        levelCryoDMGpercent + weaponCryoDMGpercent + a4CryoDMGpercent;

    if (cleveltoElectroDMGpercent[level] != null)
      levelElectroDMGpercent = cleveltoElectroDMGpercent[level];
    if (weapontoElectroDMGpercent[weaponlv] != null)
      weaponElectroDMGpercent = weapontoElectroDMGpercent[weaponlv];

    a4ElectroDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4ElectroDMGpercent =
        artifact4mainstatcat == 9 ? a4ElectroDMGpercentMain : 0;

    bonusElectroDMGpercent =
        levelElectroDMGpercent + weaponElectroDMGpercent + a4ElectroDMGpercent;

    if (cleveltoAnemoDMGpercent[level] != null)
      levelAnemoDMGpercent = cleveltoAnemoDMGpercent[level];
    if (weapontoAnemoDMGpercent[weaponlv] != null)
      weaponAnemoDMGpercent = weapontoAnemoDMGpercent[weaponlv];

    a4AnemoDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4AnemoDMGpercent = artifact4mainstatcat == 10 ? a4AnemoDMGpercentMain : 0;

    bonusAnemoDMGpercent =
        levelAnemoDMGpercent + weaponAnemoDMGpercent + a4AnemoDMGpercent;

    if (cleveltoGeoDMGpercent[level] != null)
      levelGeoDMGpercent = cleveltoGeoDMGpercent[level];
    if (weapontoGeoDMGpercent[weaponlv] != null)
      weaponGeoDMGpercent = weapontoGeoDMGpercent[weaponlv];

    a4GeoDMGpercentMain = a4ElementDMGpercentbyLVL[sstar][slv];
    a4GeoDMGpercent = artifact4mainstatcat == 11 ? a4GeoDMGpercentMain : 0;

    bonusGeoDMGpercent =
        levelGeoDMGpercent + weaponGeoDMGpercent + a4GeoDMGpercent;

    //enemyparams
    enemyPhysicalres = eneresbytype[enemytype]['physical'];
    enemyPhysicalresv = enemyPhysicalres;
    if (enemyPhysicalres > 100) enemyPhysicalres = 100;
    enemyPyrores = eneresbytype[enemytype]['pyro'];
    enemyPyroresv = enemyPyrores;
    if (enemyPyrores > 100) enemyPyrores = 100;
    enemyHydrores = eneresbytype[enemytype]['hydro'];
    enemyHydroresv = enemyHydrores;
    if (enemyHydrores > 100) enemyHydrores = 100;
    enemyDendrores = eneresbytype[enemytype]['dendro'];
    enemyDendroresv = enemyDendrores;
    if (enemyDendrores > 100) enemyDendrores = 100;
    enemyElectrores = eneresbytype[enemytype]['electro'];
    enemyElectroresv = enemyElectrores;
    if (enemyElectrores > 100) enemyElectrores = 100;
    enemyAnemores = eneresbytype[enemytype]['anemo'];
    enemyAnemoresv = enemyAnemores;
    if (enemyAnemores > 100) enemyAnemores = 100;
    enemyCryores = eneresbytype[enemytype]['cryo'];
    enemyCryoresv = enemyCryores;
    if (enemyCryores > 100) enemyCryores = 100;
    enemyGeores = eneresbytype[enemytype]['geo'];
    enemyGeoresv = enemyGeores;
    if (enemyGeores > 100) enemyGeores = 100;

    //damagecalcparams
    hit1dmgpercent = natklvtoskill['1hitDMG'][natklv];
    hit2dmgpercent = natklvtoskill['2hitDMG'][natklv];
    hit3dmgpercent = natklvtoskill['3hitDMG'][natklv];
    hit4dmgpercent = natklvtoskill['4hitDMG'][natklv];
    hit5dmgpercent = natklvtoskill['5hitDMG'][natklv];
    hit6dmgpercent = natklvtoskill['6hitDMG'][natklv];

    plungedmgpercent = natklvtoskill['PlungeDMG'][natklv];
    lplungedmgpercent = natklvtoskill['LPlungeDMG'][natklv];
    hplungedmgpercent = natklvtoskill['HPlungeDMG'][natklv];

    aimdmgpercent = natklvtoskill['AimShootDMG'][natklv];
    aimdmgpercent = natklvtoskill['AimShootDMG'][natklv];

    caimdmgpercent = natklvtoskill['ChargedAimShootDMG'][natklv];
    caimdmgpercent = natklvtoskill['ChargedAimShootDMG'][natklv];

    frostflakedmgpercent = natklvtoskill['Frostflake Arrow DMG'][natklv];
    frostflakebloomdmgpercent =
        natklvtoskill['Frostflake Arrow Bloom DMG'][natklv];

    trailoftheqilindmgpercent =
        natklvtoskill['Trail of the Qilin DMG'][eskilllv];
    trailoftheqilinhppercent = natklvtoskill['Trail of the Qilin HP'][eskilllv];
    celestialshowerdmgpercent = natklvtoskill['Celestial Shower DMG'][eburstlv];

    hit1dmgc = allatk *
        (hit1dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit1dmgnc = allatk *
        (hit1dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit1dmgexp = allatk *
        (hit1dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hit2dmgc = allatk *
        (hit2dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit2dmgnc = allatk *
        (hit2dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit2dmgexp = allatk *
        (hit2dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hit3dmgc = allatk *
        (hit3dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit3dmgnc = allatk *
        (hit3dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit3dmgexp = allatk *
        (hit3dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hit4dmgc = allatk *
        (hit4dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit4dmgnc = allatk *
        (hit4dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit4dmgexp = allatk *
        (hit4dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hit5dmgc = allatk *
        (hit5dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit5dmgnc = allatk *
        (hit5dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit5dmgexp = allatk *
        (hit5dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hit6dmgc = allatk *
        (hit6dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit6dmgnc = allatk *
        (hit6dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hit6dmgexp = allatk *
        (hit6dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    aimdmgc = allatk *
        (aimdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    aimdmgnc = allatk *
        (aimdmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    aimdmgexp = allatk *
        (aimdmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    caimdmgc = allatk *
        (caimdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    caimdmgnc = allatk *
        (caimdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    caimdmgexp = allatk *
        (caimdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100)) *
        (1 + allCD / 100 * allCR / 100);

    plungedmgc = allatk *
        (plungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    plungedmgnc = allatk *
        (plungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    plungedmgexp = allatk *
        (plungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    lplungedmgc = allatk *
        (lplungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    lplungedmgnc = allatk *
        (lplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    lplungedmgexp = allatk *
        (lplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    hplungedmgc = allatk *
        (hplungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hplungedmgnc = allatk *
        (hplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100));

    hplungedmgexp = allatk *
        (hplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyPhysicalres / 100)) *
        (1 + allCD / 100 * allCR / 100);

    frostflakedmgc = allatk *
        (frostflakedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    frostflakedmgnc = allatk *
        (frostflakedmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    frostflakedmgexp = allatk *
        (frostflakedmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100)) *
        (1 + allCD / 100 * allCR / 100);

    frostflakebloomdmgc = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    frostflakebloomdmgnc = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    frostflakebloomdmgexp = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100)) *
        (1 + allCD / 100 * allCR / 100);

    frostflakealldmgc = frostflakebloomdmgc + frostflakedmgc;
    frostflakealldmgnc = frostflakebloomdmgnc + frostflakedmgnc;
    frostflakealldmgexp = frostflakebloomdmgexp + frostflakedmgexp;

    trailoftheqilindmgc = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    trailoftheqilindmgnc = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    trailoftheqilindmgexp = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100)) *
        (1 + allCD / 100 * allCR / 100);

    trailoftheqilinhp = allHP * trailoftheqilinhppercent / 100;

    celestialshowerdmgc = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    celestialshowerdmgnc = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100));

    celestialshowerdmgexp = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        (1 - (enemyCryores / 100)) *
        (1 + allCD / 100 * allCR / 100);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ResponsiveGridRow(children: [
            //ANCHOR ----CharacterPage----
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                //color: Colors.lightBlue[50],
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  image: DecorationImage(
                    image: AssetImage('2021010519290354247.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('2020060220525531988.png'),
                              height: 100,
                            ),
                            SelectableText(
                              'Ganyu',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 200),
                      Container(
                        height: 400,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SelectableText(
                                  'Lv: $level',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Slider(
                                  min: 1,
                                  max: 90,
                                  divisions: 9,
                                  activeColor: Colors.lightBlue,
                                  inactiveColor: Colors.lightBlue[50],
                                  label: level.toString(),
                                  value: level.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      level = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SelectableText(
                                  'Normal Attack Lv: $natklv',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Slider(
                                  min: 1,
                                  max: 15,
                                  divisions: 14,
                                  activeColor: Colors.lightBlue,
                                  inactiveColor: Colors.lightBlue[50],
                                  label: natklv.toString(),
                                  value: natklv.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      natklv = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SelectableText(
                                  'Elemental Skill Lv: $eskilllv',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Slider(
                                  min: 1,
                                  max: 15,
                                  divisions: 14,
                                  activeColor: Colors.lightBlue,
                                  inactiveColor: Colors.lightBlue[50],
                                  label: eskilllv.toString(),
                                  value: eskilllv.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      eskilllv = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SelectableText(
                                  'Elemental Burst Lv: $eburstlv',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Slider(
                                  min: 1,
                                  max: 15,
                                  divisions: 14,
                                  activeColor: Colors.lightBlue,
                                  inactiveColor: Colors.lightBlue[50],
                                  label: eburstlv.toString(),
                                  value: eburstlv.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      eburstlv = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SelectableText(
                                  'Constellation: $cons',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Slider(
                                  min: 0,
                                  max: 6,
                                  divisions: 6,
                                  activeColor: Colors.lightBlue,
                                  inactiveColor: Colors.lightBlue[50],
                                  label: cons.toString(),
                                  value: cons.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      cons = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //ANCHOR ----weapon&artifactPage----
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                color: Colors.lightGreen[50],
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 350,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),

                          //ANCHOR weapon
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {
                                    print('Card tapped.');
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      // color: Colors.lightBlue[50],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage('Weapon_Amos.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'Lv: $weaponlv',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Slider(
                                    min: 1,
                                    max: 90,
                                    divisions: 18,
                                    activeColor: Colors.lightBlue,
                                    inactiveColor: Colors.lightBlue[50],
                                    label: weaponlv.toString(),
                                    value: weaponlv.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        weaponlv = value.toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'Refinement: $weaponref',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Slider(
                                    min: 1,
                                    max: 5,
                                    divisions: 4,
                                    activeColor: Colors.lightBlue,
                                    inactiveColor: Colors.lightBlue[50],
                                    label: weaponref.toString(),
                                    value: weaponref.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        weaponref = value.toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //ANCHOR artifactset
                        Container(
                          height: 800,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SelectableText(
                                        '2 set',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SelectableText(
                                        '2 set',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              //ANCHOR artifact1
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 110,
                                        child: Column(
                                          children: [
                                            SelectableText(
                                              'Flower:',
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SelectableText(
                                              'HP',
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Star: $fstar',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 4,
                                              max: 5,
                                              divisions: 1,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: fstar.toString(),
                                              value: fstar.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  fstar = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Lv: $flv',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 1,
                                              max: 20,
                                              divisions: 5,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: flv.toString(),
                                              value: flv.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  flv = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: InkWell(
                                      onTap: _showSimpleDialog,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (!stat1atkpercentOn &&
                                                    !stat1hppercentOn &&
                                                    !stat1defpercentOn &&
                                                    !stat1atkOn &&
                                                    !stat1hpOn &&
                                                    !stat1defOn &&
                                                    !stat1CRpercentOn &&
                                                    !stat1CDpercentOn &&
                                                    !stat1EMOn &&
                                                    !stat1ERpercentOn)
                                                  Text(
                                                      'Please click to set stats'),
                                                if (stat1atkpercentOn)
                                                  Text('ATK%:$stat1atkpercent'),
                                                if (stat1hppercentOn)
                                                  Text('HP%:$stat1hppercent'),
                                                if (stat1defpercentOn)
                                                  Text('DEF%:$stat1defpercent'),
                                                if (stat1CRpercentOn)
                                                  Text(
                                                      'Critial Rate%:$stat1CRpercent'),
                                                if (stat1CDpercentOn)
                                                  Text(
                                                      'Critial Damage%:$stat1CDpercent'),
                                                if (stat1EMOn)
                                                  Text(
                                                      'Elemental Mastery%:$stat1EM'),
                                                if (stat1ERpercentOn)
                                                  Text(
                                                      'Energy Recharge%:$stat1ERpercent'),
                                                if (stat1atkOn)
                                                  Text('ATK:$stat1atk'),
                                                if (stat1hpOn)
                                                  Text('HP:$stat1hp'),
                                                if (stat1defOn)
                                                  Text('DEF:$stat1def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Visibility(
                                                  visible: false,
                                                  child: SelectableText(
                                                    _label,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
//ANCHOR artifact2
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 110.0,
                                        child: Column(
                                          children: [
                                            SelectableText(
                                              'Plume: ',
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SelectableText(
                                              'ATK',
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Star: $pstar',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 4,
                                              max: 5,
                                              divisions: 1,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: pstar.toString(),
                                              value: pstar.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  pstar = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Lv: $plv',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 1,
                                              max: 20,
                                              divisions: 5,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: plv.toString(),
                                              value: plv.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  plv = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: InkWell(
                                      onTap: _showSimpleDialog2,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (!stat2atkpercentOn &&
                                                    !stat2hppercentOn &&
                                                    !stat2defpercentOn &&
                                                    !stat2atkOn &&
                                                    !stat2hpOn &&
                                                    !stat2defOn &&
                                                    !stat2CRpercentOn &&
                                                    !stat2CDpercentOn &&
                                                    !stat2EMOn &&
                                                    !stat2ERpercentOn)
                                                  Text(
                                                      'Please click to set stats'),
                                                if (stat2atkpercentOn)
                                                  Text('ATK%:$stat2atkpercent'),
                                                if (stat2hppercentOn)
                                                  Text('HP%:$stat2hppercent'),
                                                if (stat2defpercentOn)
                                                  Text('DEF%:$stat2defpercent'),
                                                if (stat2CRpercentOn)
                                                  Text(
                                                      'Critial Rate%:$stat2CRpercent'),
                                                if (stat2CDpercentOn)
                                                  Text(
                                                      'Critial Damage%:$stat2CDpercent'),
                                                if (stat2EMOn)
                                                  Text(
                                                      'Elemental Mastery%:$stat2EM'),
                                                if (stat2ERpercentOn)
                                                  Text(
                                                      'Energy Recharge%:$stat2ERpercent'),
                                                if (stat2atkOn)
                                                  Text('ATK:$stat2atk'),
                                                if (stat2hpOn)
                                                  Text('HP:$stat2hp'),
                                                if (stat2defOn)
                                                  Text('DEF:$stat2def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Visibility(
                                                  visible: false,
                                                  child: SelectableText(
                                                    _label,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
//ANCHOR artifact3
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SelectableText(
                                      //   'Sands:',
                                      //   style: TextStyle(
                                      //     //fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //     fontSize: 15,
                                      //   ),
                                      // ),
                                      Column(
                                        children: [
                                          SelectableText(
                                            'Sands:',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            height: 50.0,
                                            width: 110.0,
                                            child: DropdownButton(
                                                value: artifact3mainstatcat,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "HP%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Energy Recharge%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 5)
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact3mainstatcat =
                                                        value;
                                                  });
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Star: $sstar',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 4,
                                              max: 5,
                                              divisions: 1,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: sstar.toString(),
                                              value: sstar.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  sstar = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Lv: $slv',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 1,
                                              max: 20,
                                              divisions: 5,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: slv.toString(),
                                              value: slv.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  slv = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: InkWell(
                                      onTap: _showSimpleDialog3,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (!stat3atkpercentOn &&
                                                    !stat3hppercentOn &&
                                                    !stat3defpercentOn &&
                                                    !stat3atkOn &&
                                                    !stat3hpOn &&
                                                    !stat3defOn &&
                                                    !stat3CRpercentOn &&
                                                    !stat3CDpercentOn &&
                                                    !stat3EMOn &&
                                                    !stat3ERpercentOn)
                                                  Text(
                                                      'Please click to set stats'),
                                                if (stat3atkpercentOn)
                                                  Text('ATK%:$stat3atkpercent'),
                                                if (stat3hppercentOn)
                                                  Text('HP%:$stat3hppercent'),
                                                if (stat3defpercentOn)
                                                  Text('DEF%:$stat3defpercent'),
                                                if (stat3CRpercentOn)
                                                  Text(
                                                      'Critial Rate%:$stat3CRpercent'),
                                                if (stat3CDpercentOn)
                                                  Text(
                                                      'Critial Damage%:$stat3CDpercent'),
                                                if (stat3EMOn)
                                                  Text(
                                                      'Elemental Mastery%:$stat3EM'),
                                                if (stat3ERpercentOn)
                                                  Text(
                                                      'Energy Recharge%:$stat3ERpercent'),
                                                if (stat3atkOn)
                                                  Text('ATK:$stat3atk'),
                                                if (stat3hpOn)
                                                  Text('HP:$stat3hp'),
                                                if (stat3defOn)
                                                  Text('DEF:$stat3def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Visibility(
                                                  visible: false,
                                                  child: SelectableText(
                                                    _label,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
//ANCHOR artifact4
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SelectableText(
                                            'Goblet:',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            height: 50.0,
                                            width: 110.0,
                                            child: DropdownButton(
                                                value: artifact4mainstatcat,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "HP%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Physical Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 5),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Pyro Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 6),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Hydro Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 7),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Cryo Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 8),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Electro Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 9),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Anemo Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 10),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Geo Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 11),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact4mainstatcat =
                                                        value;
                                                  });
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Star: $gstar',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 4,
                                              max: 5,
                                              divisions: 1,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: gstar.toString(),
                                              value: gstar.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  gstar = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Lv: $glv',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 1,
                                              max: 20,
                                              divisions: 5,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: glv.toString(),
                                              value: glv.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  glv = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: InkWell(
                                      onTap: _showSimpleDialog4,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (!stat4atkpercentOn &&
                                                    !stat4hppercentOn &&
                                                    !stat4defpercentOn &&
                                                    !stat4atkOn &&
                                                    !stat4hpOn &&
                                                    !stat4defOn &&
                                                    !stat4CRpercentOn &&
                                                    !stat4CDpercentOn &&
                                                    !stat4EMOn &&
                                                    !stat4ERpercentOn)
                                                  Text(
                                                      'Please click to set stats'),
                                                if (stat4atkpercentOn)
                                                  Text('ATK%:$stat4atkpercent'),
                                                if (stat4hppercentOn)
                                                  Text('HP%:$stat4hppercent'),
                                                if (stat4defpercentOn)
                                                  Text('DEF%:$stat4defpercent'),
                                                if (stat4CRpercentOn)
                                                  Text(
                                                      'Critial Rate%:$stat4CRpercent'),
                                                if (stat4CDpercentOn)
                                                  Text(
                                                      'Critial Damage%:$stat4CDpercent'),
                                                if (stat4EMOn)
                                                  Text(
                                                      'Elemental Mastery%:$stat4EM'),
                                                if (stat4ERpercentOn)
                                                  Text(
                                                      'Energy Recharge%:$stat4ERpercent'),
                                                if (stat4atkOn)
                                                  Text('ATK:$stat4atk'),
                                                if (stat4hpOn)
                                                  Text('HP:$stat4hp'),
                                                if (stat4defOn)
                                                  Text('DEF:$stat4def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Visibility(
                                                  visible: false,
                                                  child: SelectableText(
                                                    _label,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
//ANCHOR artifact5
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'Item_Snowswept_Memory.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SelectableText(
                                            'Circlet:',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            height: 50.0,
                                            width: 110.0,
                                            child: DropdownButton(
                                                value: artifact5mainstatcat,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "HP%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Critical Rate%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 5),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Critical Damage%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 6),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Healing Bonus%",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      value: 7),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact5mainstatcat =
                                                        value;
                                                  });
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Star: $cstar',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 4,
                                              max: 5,
                                              divisions: 1,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: cstar.toString(),
                                              value: cstar.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  cstar = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SelectableText(
                                            'Lv: $clv',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Slider(
                                              min: 1,
                                              max: 20,
                                              divisions: 5,
                                              activeColor: Colors.lightBlue,
                                              inactiveColor:
                                                  Colors.lightBlue[50],
                                              label: clv.toString(),
                                              value: clv.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  clv = value.toInt();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: InkWell(
                                      onTap: _showSimpleDialog5,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (!stat5atkpercentOn &&
                                                    !stat5hppercentOn &&
                                                    !stat5defpercentOn &&
                                                    !stat5atkOn &&
                                                    !stat5hpOn &&
                                                    !stat5defOn &&
                                                    !stat5CRpercentOn &&
                                                    !stat5CDpercentOn &&
                                                    !stat5EMOn &&
                                                    !stat5ERpercentOn)
                                                  Text(
                                                      'Please click to set stats'),
                                                if (stat5atkpercentOn)
                                                  Text('ATK%:$stat5atkpercent'),
                                                if (stat5hppercentOn)
                                                  Text('HP%:$stat5hppercent'),
                                                if (stat5defpercentOn)
                                                  Text('DEF%:$stat5defpercent'),
                                                if (stat5CRpercentOn)
                                                  Text(
                                                      'Critial Rate%:$stat5CRpercent'),
                                                if (stat5CDpercentOn)
                                                  Text(
                                                      'Critial Damage%:$stat5CDpercent'),
                                                if (stat5EMOn)
                                                  Text(
                                                      'Elemental Mastery%:$stat5EM'),
                                                if (stat5ERpercentOn)
                                                  Text(
                                                      'Energy Recharge%:$stat5ERpercent'),
                                                if (stat5atkOn)
                                                  Text('ATK:$stat5atk'),
                                                if (stat5hpOn)
                                                  Text('HP:$stat5hp'),
                                                if (stat5defOn)
                                                  Text('DEF:$stat5def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Visibility(
                                                  visible: false,
                                                  child: SelectableText(
                                                    _label,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //ANCHOR ----StatPage----
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                color: Colors.yellow[50],
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //ANCHOR ***BasicPanel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Basic Panel',
                                style: TextStyle(fontSize: 20),
                              ),

                              //ANCHOR ATK

                              SizedBox(height: 10),
                              SelectableText(
                                'ATK:$basicatk + ' +
                                    double.parse(bonusatk.toStringAsFixed(1))
                                        .toString() +
                                    ' = ' +
                                    double.parse(allatk.toStringAsFixed(1))
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statATK:stats
                                    //level:Colors.red
                                    //weapon:Colors.blue
                                    //weapon%:Colors.green
                                    //a1:Colors.yellow
                                    //a1%:Colors.yellow[700]
                                    //a2:Colors.pink
                                    //a2%:Colors.pink[700]
                                    //a3%:Colors.blueGrey
                                    //a3:Colors.blueGrey[700]
                                    //a4%:Colors.purple
                                    //a4:Colors.purple[700]
                                    //a5%:Colors.teal
                                    //a5:Colors.teal[700]
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'level',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  '$levelatk',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.blue,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'weapon',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  '$weaponatk',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.green,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'weapon%($weaponatkpercent)',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  double.parse(
                                                          weaponatkpercentstat
                                                              .toStringAsFixed(
                                                                  1))
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (stat1atkOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat1atk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1atkpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1atkpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a1percentatk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.pink,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'a2',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  a2atk.toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (stat2atkpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2atkpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a2percentatk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 2)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a3atkpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentatkMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3atkpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3atkpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentatk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3atkOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat3atk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 2)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($a4atkpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentatkMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4atkpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4atkpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentatk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4atkOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat4atk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 2)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($a5atkpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentatkMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5atkpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5atkpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentatk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5atkOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat5atk
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statATK:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: levelatk / 7,
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: weaponatk / 7,
                                              height: 20,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: weaponatk / 7,
                                              height: 20,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                        if (stat1atkOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1atk / 7,
                                                height: 20,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        if (stat1atkpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a1percentatk / 7,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: a2atk / 7,
                                              height: 20,
                                              color: Colors.pink,
                                            ),
                                          ],
                                        ),
                                        if (stat2atkpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a2percentatk / 7,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 2)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentatkMain / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3atkpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentatk / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3atkOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3atk / 7,
                                                height: 20,
                                                color: Colors.blueGrey[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 2)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentatkMain / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4atkpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentatk / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4atkOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4atk / 7,
                                                height: 20,
                                                color: Colors.purple[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 2)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentatkMain / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5atkpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentatk / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5atkOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5atk / 7,
                                                height: 20,
                                                color: Colors.teal[700],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //ANCHOR HP

                              SizedBox(height: 10),
                              SelectableText(
                                'HP:$lvlhp + ' +
                                    double.parse(bonusHP.toStringAsFixed(1))
                                        .toString() +
                                    ' = ' +
                                    double.parse(allHP.toStringAsFixed(1))
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statHP:stats
                                    //level:Colors.red
                                    //weapon:Colors.blue
                                    //weapon%:Colors.green
                                    //a1:Colors.yellow
                                    //a1%:Colors.yellow[700]
                                    //a2:Colors.pink
                                    //a2%:Colors.pink[700]
                                    //a3%:Colors.blueGrey
                                    //a3:Colors.blueGrey[700]
                                    //a4%:Colors.purple
                                    //a4:Colors.purple[700]
                                    //a5%:Colors.teal
                                    //a5:Colors.teal[700]
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'level',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  '$lvlhp',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (weaponHPpercentstat > 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blue,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponHPpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(
                                                            weaponHPpercentstat
                                                                .toStringAsFixed(
                                                                    1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1hpOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat1hp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1hppercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1hppercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a1percenthp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.yellow,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'a1',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  a1hp.toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (stat2hpOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat2hp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2hppercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2hppercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a2percenthp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 1)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a3HPpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentHPMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3hppercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3hppercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentHP
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3hpOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat3hp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 1)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($a4HPpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentHPMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4hppercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4hppercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentHP
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4hpOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat4hp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 1)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($a5HPpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentHPMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5hppercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5hppercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentHP
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5hpOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat5hp
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statHP:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: lvlhp / 75,
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        if (weaponHPpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponHPpercentstat / 75,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (stat1hpOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1hp / 75,
                                                height: 20,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        if (stat1hppercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a1percenthp / 75,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: a1hp / 75,
                                              height: 20,
                                              color: Colors.yellow,
                                            ),
                                          ],
                                        ),
                                        if (stat2hpOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat2hp / 75,
                                                height: 20,
                                                color: Colors.pink,
                                              ),
                                            ],
                                          ),
                                        if (stat2hppercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a2percenthp / 50,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 1)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentHPMain / 75,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3hppercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentHP / 75,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3hpOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3hp / 75,
                                                height: 20,
                                                color: Colors.blueGrey[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 1)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentHPMain / 75,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4hppercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentHP / 50,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4hpOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4hp / 75,
                                                height: 20,
                                                color: Colors.purple[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 1)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentHPMain / 75,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5hppercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentHP / 75,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5hpOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5hp / 75,
                                                height: 20,
                                                color: Colors.teal[700],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //ANCHOR DEF
                              SelectableText(
                                'DEF:$lvldef + ' +
                                    double.parse(bonusdef.toStringAsFixed(1))
                                        .toString() +
                                    ' = ' +
                                    double.parse(alldef.toStringAsFixed(1))
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statDEF:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'level',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  '$lvldef',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (weapondefpercentstat != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weapondefpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(
                                                            weapondefpercentstat
                                                                .toStringAsFixed(
                                                                    1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1defOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat1def
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1defpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1defpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a1percentdef
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2defpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2defpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a2percentdef
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 3)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a3defpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentdefMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3defpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3defpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a3percentdef
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3defOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat3def
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 3)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($a4defpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentdefMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4defpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4defpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a4percentdef
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4defOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat4def
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 3)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($a5defpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentdefMain
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5defpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5defpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(a5percentdef
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5defOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    double.parse(stat5def
                                                            .toStringAsFixed(1))
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statDEF:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: lvldef / 7,
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        if (weapondefpercentstat != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weapondefpercentstat / 7,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (stat1defOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1def / 7,
                                                height: 20,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        if (stat1defpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a1percentdef / 7,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        if (stat2defpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a2percentdef / 7,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 3)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentdefMain / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3defpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3percentdef / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3defOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3def / 7,
                                                height: 20,
                                                color: Colors.blueGrey[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 3)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentdefMain / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4defpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4percentdef / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4defOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4def / 7,
                                                height: 20,
                                                color: Colors.purple[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 3)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentdefMain / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5defpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5percentdef / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5defOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5def / 7,
                                                height: 20,
                                                color: Colors.teal[700],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //ANCHOR ER
                              SelectableText(
                                'Energy Recharge:100% + ' +
                                    double.parse(bonusER.toStringAsFixed(1))
                                        .toString() +
                                    '% = ' +
                                    double.parse(allER.toStringAsFixed(1))
                                        .toString() +
                                    '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statER:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'baseER%(100)',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (weaponERpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1ERpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1ERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2ERpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2ERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 5)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a3ERpercentMain)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3ERpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3ERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4ERpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4ERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5ERpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5ERpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statER:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: 100,
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        if (weaponERpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponERpercent,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (stat1ERpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1ERpercent,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        if (stat2ERpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat2ERpercent,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 5)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3ERpercentMain,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3ERpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3ERpercent,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat4ERpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4ERpercent,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat5ERpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5ERpercent,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ANCHOR ***CritPanel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            //ANCHOR CR

                            children: [
                              SelectableText(
                                'Crit Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),

                              SelectableText(
                                'Critical Rate:' +
                                    double.parse(baseCR.toStringAsFixed(1))
                                        .toString() +
                                    '% + ' +
                                    double.parse(bonusCR.toStringAsFixed(1))
                                        .toString() +
                                    '% = ' +
                                    double.parse(allCR.toStringAsFixed(1))
                                        .toString() +
                                    '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statCR:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: [
                                                SelectableText(
                                                  'baseCR%',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SelectableText(
                                                  '$baseCR',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (weaponCR != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponCR)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1CRpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1CRpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2CRpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2CRpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3CRpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3CRpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4CRpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4CRpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 5)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($a5CR)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5CRpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5CRpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statCR:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: baseCR * 2,
                                                height: 20,
                                                color: Colors.red),
                                          ],
                                        ),
                                        if (weaponCR != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponCR * 2,
                                                height: 20,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        if (stat1CRpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1CRpercent * 2,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        if (stat2CRpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat2CRpercent * 2,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (stat3CRpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3CRpercent * 2,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat4CRpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4CRpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 5)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5CR * 2,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5CRpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5CRpercent * 2,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //ANCHOR CD
                              SelectableText(
                                'Critical Damage:' +
                                    double.parse(baseCD.toStringAsFixed(1))
                                        .toString() +
                                    '% + ' +
                                    double.parse(bonusCD.toStringAsFixed(1))
                                        .toString() +
                                    '% = ' +
                                    double.parse(allCD.toStringAsFixed(1))
                                        .toString() +
                                    '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statCD:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if ((baseCD - weaponCD) != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'baseCD%',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    '$baseCD',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponCD != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponCD)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1CDpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1%($stat1CDpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2CDpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink[700],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2%($stat2CDpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3CDpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($stat3CDpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4CDpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4%($stat4CDpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 6)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($a5CD)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5CDpercentOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5%($stat5CDpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statCD:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if ((baseCD - weaponCD) != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: baseCD * 2,
                                                  height: 20,
                                                  color: Colors.red),
                                            ],
                                          ),
                                        if (weaponCD != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponCD * 2,
                                                height: 20,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        if (stat1CDpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1CDpercent * 2,
                                                height: 20,
                                                color: Colors.yellow[700],
                                              ),
                                            ],
                                          ),
                                        if (stat2CDpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat2CDpercent * 2,
                                                height: 20,
                                                color: Colors.pink[700],
                                              ),
                                            ],
                                          ),
                                        if (stat3CDpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3CDpercent * 2,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat4CDpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4CDpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 6)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5CD * 2,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5CDpercentOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5CDpercent * 2,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //ANCHOR ***Damageplus Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Damageplus Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              //ANCHOR Physical Damage Title
                              if (bonusPhysicalDMGpercent != 0)
                                SelectableText(
                                  'Physical Damage:' +
                                      double.parse(bonusPhysicalDMGpercent
                                              .toStringAsFixed(1))
                                          .toString() +
                                      '%',
                                  style: TextStyle(fontSize: 15),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statPhysicalDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelPhysicalDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelPhysicalDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponPhysicalDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponPhysicalDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 5)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4PhysicalDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statPhysicalDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelPhysicalDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    levelPhysicalDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponPhysicalDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    weaponPhysicalDMGpercent *
                                                        2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 5)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4PhysicalDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Pyro Damage Title
                                    if (bonusPyroDMGpercent != 0)
                                      SelectableText(
                                        'Pyro Damage:' +
                                            double.parse(bonusPyroDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statPyroDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelPyroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelPyroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponPyroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponPyroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 6)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4PyroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statPyroDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelPyroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: levelPyroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponPyroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponPyroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 6)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4PyroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Hydro Damage Title
                                    if (bonusHydroDMGpercent != 0)
                                      SelectableText(
                                        'Hydro Damage:' +
                                            double.parse(bonusHydroDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statHydroDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelHydroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelHydroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponHydroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponHydroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 7)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4HydroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statHydroDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelHydroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: levelHydroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponHydroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    weaponHydroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 7)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4HydroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Cryo Damage Title
                                    if (bonusCryoDMGpercent != 0)
                                      SelectableText(
                                        'Cryo Damage:' +
                                            double.parse(bonusCryoDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statCryoDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelCryoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelCryoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponCryoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponCryoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 8)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4CryoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statCryoDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelCryoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: levelCryoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponCryoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponCryoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 8)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4CryoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Electro Damage Title
                                    if (bonusElectroDMGpercent != 0)
                                      SelectableText(
                                        'Electro Damage:' +
                                            double.parse(bonusElectroDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statElectroDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelElectroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelElectroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponElectroDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponElectroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 9)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4ElectroDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statElectroDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelElectroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    levelElectroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponElectroDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    weaponElectroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 9)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4ElectroDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Anemo Damage Title
                                    if (bonusAnemoDMGpercent != 0)
                                      SelectableText(
                                        'Anemo Damage:' +
                                            double.parse(bonusAnemoDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statAnemoDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelAnemoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelAnemoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponAnemoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponAnemoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 10)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4AnemoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statAnemoDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelAnemoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: levelAnemoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponAnemoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width:
                                                    weaponAnemoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 10)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4AnemoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR Geo Damage Title
                                    if (bonusGeoDMGpercent != 0)
                                      SelectableText(
                                        'Geo Damage:' +
                                            double.parse(bonusGeoDMGpercent
                                                    .toStringAsFixed(1))
                                                .toString() +
                                            '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statGeoDMG:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelGeoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'chara%($levelGeoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponGeoDMGpercent != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon%($weaponGeoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 11)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3%($a4GeoDMGpercent)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    //ANCHOR statGeoDMG:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (levelGeoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: levelGeoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        if (weaponGeoDMGpercent != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponGeoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 11)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4GeoDMGpercent * 2,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ANCHOR ***Reaction Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Reaction Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),

                              //ANCHOR EM
                              SelectableText(
                                'Elemental Mastery:$lvlEM + ' +
                                    double.parse(bonusEM.toStringAsFixed(1))
                                        .toString() +
                                    ' = ' +
                                    double.parse(allEM.toStringAsFixed(1))
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statEM:stats
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (lvlEM != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.red,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'baseEM',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    '$lvlEM',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (weaponEM != 0)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blue,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'weapon($weaponEM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat1EMOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.yellow,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a1($stat1EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat2EMOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.pink,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a2($stat2EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 4)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3($a3EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat3EMOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.blueGrey,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a3($stat3EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 4)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4($a4EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat4EMOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.purple,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a4($stat4EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 4)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5($a5EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (stat5EMOn == true)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.teal,
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    'a5($stat5EM)',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    //ANCHOR statEM:bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: lvlEM / 7,
                                                height: 20,
                                                color: Colors.red),
                                          ],
                                        ),
                                        if (weaponEM != 0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: weaponEM / 7,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (stat1EMOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat1EM / 7,
                                                height: 20,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        if (stat2EMOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat2EM / 7,
                                                height: 20,
                                                color: Colors.pink,
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a3EM / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3EMOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat3EM / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a4EM / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4EMOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat4EM / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: a5EM / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5EMOn == true)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: stat5EM / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ANCHOR ***EnemyResistance Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'EnemyResistance Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'Enemytype: ',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    child: DropdownButton(
                                        value: enemytype,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "Hilichurl",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Ruin Guard",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            value: 2,
                                          ),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Treasure Hoarder",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 3),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Andrius, Dominator of Wolves",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 4),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            enemytype = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Physical',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyPhysicalresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Pyro',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyPyroresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Hydro',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyHydroresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Dendro',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyDendroresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Electro',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyElectroresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Anemo',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyAnemoresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Cryo',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.blue[100],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyCryoresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectableText(
                                        'Geo',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        '$enemyGeoresv',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //ANCHOR ***EnemyDefence Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'EnemyDefence Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'EnemyLv: $enemylv',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Slider(
                                    min: 1,
                                    max: 100,
                                    activeColor: Colors.lightBlue,
                                    inactiveColor: Colors.lightBlue[50],
                                    label: enemylv.toString(),
                                    value: enemylv.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        enemylv = value.toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'EnemyDefenceDebuff%: $enemydefdebuff%',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Slider(
                                    min: 0,
                                    max: 100,
                                    activeColor: Colors.lightBlue,
                                    inactiveColor: Colors.lightBlue[50],
                                    label: enemydefdebuff.toString(),
                                    value: enemydefdebuff.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        enemydefdebuff = value.toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //ANCHOR ----DamagePage----
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                color: Colors.red[50],
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Normal ATK DMG Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              //ANCHOR Charged Aim Shoot Damage
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SelectableText(
                                            'Charged Aim Shoot Damage:($caimdmgpercent%)',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Non-Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(
                                                  caimdmgnc.toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[200],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Expectation:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(
                                                  caimdmgexp.toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[400],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(
                                                  caimdmgc.toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[600],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: caimdmgc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[600],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: caimdmgexp / 50,
                                              height: 20,
                                              color: Colors.lightBlue[400],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: caimdmgnc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[200],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Text(
                                //   "Reaction DMG",
                                //   style: TextStyle(
                                //     fontSize: 12.0,
                                //   ),
                                // ),
                                children: <Widget>[
                                  Row(
                                      //ANCHOR 1-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '1-Hit Damage:($hit1dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit1dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit1dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit1dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit1dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit1dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit1dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR 2-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '2-Hit Damage:($hit2dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit2dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit2dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit2dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit2dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit2dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit2dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR 3-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '3-Hit Damage:($hit3dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit3dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit3dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit3dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit3dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit3dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit3dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR 4-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '4-Hit Damage:($hit4dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit4dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit4dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit4dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit4dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit4dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit4dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR 5-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '5-Hit Damage:($hit5dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit5dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit5dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit5dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit5dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit5dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit5dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR 6-Hit Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          '6-Hit Damage:($hit6dmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit6dmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit6dmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hit6dmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit6dmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit6dmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hit6dmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR Aim Shoot Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Aim Shoot Damage:($aimdmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                aimdmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                aimdmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(aimdmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: aimdmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: aimdmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: aimdmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR Plunge Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Plunge Damage:($plungedmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                plungedmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                plungedmgexp.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                plungedmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: plungedmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: plungedmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: plungedmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR Low Plunge Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Low Plunge Damage:($lplungedmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                lplungedmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(lplungedmgexp
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                lplungedmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: lplungedmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: lplungedmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: lplungedmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      //ANCHOR High Plunge Damage
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'High Plunge Damage:($hplungedmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hplungedmgnc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(hplungedmgexp
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(
                                                hplungedmgc.toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hplungedmgc / 50,
                                            height: 20,
                                            color: Colors.grey[900],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hplungedmgexp / 50,
                                            height: 20,
                                            color: Colors.grey[700],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: hplungedmgnc / 50,
                                            height: 20,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              //ANCHOR Frostflake Arrow
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SelectableText(
                                            'Frostflake Arrow:($frostflakedmgpercent%)',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Non-Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakedmgnc
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[200],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Expectation:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakedmgexp
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[400],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakedmgc
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[600],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakedmgc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[600],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakedmgexp / 50,
                                              height: 20,
                                              color: Colors.lightBlue[400],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakedmgnc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[200],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Melt:(' +
                                              double.parse((100 *
                                                          1.5 *
                                                          (1 +
                                                              (1 * 25 * allEM) /
                                                                  (9 *
                                                                      (allEM +
                                                                          1400))))
                                                      .toStringAsFixed(1))
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakedmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakedmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakedmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        //alignment: Alignment.bottomRight,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakedmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakedmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakedmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              //ANCHOR Frostflake Arrow Bloom
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SelectableText(
                                            'Frostflake Arrow Bloom:($frostflakebloomdmgpercent%)',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Non-Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakebloomdmgnc
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[200],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Expectation:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakebloomdmgexp
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[400],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakebloomdmgc
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[600],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakebloomdmgc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[600],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakebloomdmgexp / 50,
                                              height: 20,
                                              color: Colors.lightBlue[400],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakebloomdmgnc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[200],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Melt:(' +
                                              double.parse((100 *
                                                          1.5 *
                                                          (1 +
                                                              (1 * 25 * allEM) /
                                                                  (9 *
                                                                      (allEM +
                                                                          1400))))
                                                      .toStringAsFixed(1))
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakebloomdmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakebloomdmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakebloomdmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakebloomdmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakebloomdmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakebloomdmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              //ANCHOR Frostflake All
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SelectableText(
                                            'Frostflake Arrow All',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Non-Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse((frostflakealldmgnc)
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[200],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Expectation:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakealldmgexp
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[400],
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          'Crit:',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SelectableText(
                                          double.parse(frostflakealldmgc
                                                  .toStringAsFixed(1))
                                              .toString(),
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[600],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakealldmgc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[600],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakealldmgexp / 50,
                                              height: 20,
                                              color: Colors.lightBlue[400],
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: frostflakealldmgnc / 50,
                                              height: 20,
                                              color: Colors.lightBlue[200],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Melt:(' +
                                              double.parse((100 *
                                                          1.5 *
                                                          (1 +
                                                              (1 * 25 * allEM) /
                                                                  (9 *
                                                                      (allEM +
                                                                          1400))))
                                                      .toStringAsFixed(1))
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakealldmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakealldmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((frostflakealldmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakealldmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakealldmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (frostflakealldmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Elemental Skill Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),

                              //ANCHOR Trail of the Qilin HP
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SelectableText(
                                      'Trail of the Qilin HP:($trailoftheqilinhp)',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 500),
                                        width: trailoftheqilinhp / 500,
                                        height: 20,
                                        color: Colors.grey[900],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              //ANCHOR Trail of the Qilin DMG
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Trail of the Qilin DMG:($trailoftheqilindmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(trailoftheqilindmgnc
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(trailoftheqilindmgexp
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(trailoftheqilindmgc
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: trailoftheqilindmgc / 50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: trailoftheqilindmgexp / 50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: trailoftheqilindmgnc / 50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Melt:(' +
                                              double.parse((100 *
                                                          1.5 *
                                                          (1 +
                                                              (1 * 25 * allEM) /
                                                                  (9 *
                                                                      (allEM +
                                                                          1400))))
                                                      .toStringAsFixed(1))
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((trailoftheqilindmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((trailoftheqilindmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((trailoftheqilindmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (trailoftheqilindmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (trailoftheqilindmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (trailoftheqilindmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Elemental Burst Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              //ANCHOR Celestial Shower DMG
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Celestial Shower/per Ice Shard:($celestialshowerdmgpercent%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(celestialshowerdmgnc
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse(celestialshowerdmgexp
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((celestialshowerdmgc)
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: celestialshowerdmgc / 50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: celestialshowerdmgexp / 50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: celestialshowerdmgnc / 50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SelectableText(
                                          'Melt:(' +
                                              double.parse((100 *
                                                          1.5 *
                                                          (1 +
                                                              (1 * 25 * allEM) /
                                                                  (9 *
                                                                      (allEM +
                                                                          1400))))
                                                      .toStringAsFixed(1))
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SelectableText(
                                        'Non-Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((celestialshowerdmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[200],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Expectation:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((celestialshowerdmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        'Crit:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SelectableText(
                                        double.parse((celestialshowerdmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400))))
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (celestialshowerdmgc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[600],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (celestialshowerdmgexp *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[400],
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: (celestialshowerdmgnc *
                                                    1.5 *
                                                    (1 +
                                                        (1 * 25 * allEM) /
                                                            (9 *
                                                                (allEM +
                                                                    1400)))) /
                                                50,
                                            height: 20,
                                            color: Colors.lightBlue[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //ANCHOR ----Footer----
            ResponsiveGridCol(
              xs: 12,
              md: 12,
              lg: 12,
              child: Container(
                height: 100,
                color: Colors.grey[50],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SelectableText(
                        'Provided by yunlu18.net',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.favorite),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
