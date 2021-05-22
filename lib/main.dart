import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      title: 'Genshin Damage Calculator & Visualizer',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Genshin Damage Calculator & Visualizer'),
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

  Map<int, int> cleveltoatk = {1: 26, 10: 26, 20: 68, 30: 68, 40: 135, 50: 173, 60: 217, 70: 256, 80: 295, 90: 335};

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

  Map<int, int> weapontoatk = {1: 46, 5: 62, 10: 82, 15: 102, 20: 122, 25: 173, 30: 194, 35: 214, 40: 235, 45: 287, 50: 308, 55: 361, 60: 382, 65: 435, 70: 457, 75: 510, 80: 532, 85: 586, 90: 608};

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

  Map<int, double> electroReactionBaseBYlv = {
    1: 8,
    2: 9,
    3: 9,
    4: 10,
    5: 11,
    6: 12,
    7: 12,
    8: 13,
    9: 16,
    10: 17,
    11: 18,
    12: 20,
    13: 22,
    14: 23,
    15: 27,
    16: 29,
    17: 31,
    18: 34,
    19: 37,
    20: 40,
    21: 42,
    22: 46,
    23: 48,
    24: 51,
    25: 53,
    26: 56,
    27: 59,
    28: 61,
    29: 64,
    30: 68,
    31: 71,
    32: 74,
    33: 77,
    34: 80,
    35: 84,
    36: 88,
    37: 91,
    38: 96,
    39: 99,
    40: 103,
    41: 107,
    42: 111,
    43: 117,
    44: 121,
    45: 128,
    46: 133,
    47: 140,
    48: 147,
    49: 154,
    50: 161,
    51: 168,
    52: 174,
    53: 182,
    54: 189,
    55: 199,
    56: 208,
    57: 217,
    58: 226,
    59: 236,
    60: 244,
    61: 254,
    62: 266,
    63: 278,
    64: 290,
    65: 303,
    66: 314,
    67: 326,
    68: 337,
    69: 348,
    70: 360,
    71: 371,
    72: 382,
    73: 391,
    74: 401,
    75: 414,
    76: 427,
    77: 438,
    78: 450,
    79: 461,
    80: 472,
    81: 483,
    82: 494,
    83: 507,
    84: 518,
    85: 532,
    86: 544,
    87: 557,
    88: 570,
    89: 586,
    90: 601
  };

  int lvldef = 0;

  Map<int, int> baseDEFbyLV = {1: 49, 10: 49, 20: 127, 30: 169, 40: 253, 50: 326, 60: 409, 70: 482, 80: 556, 90: 630};
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
  Map<int, double> weapontoCRpercent = {};
  double bonusCR = 0;
  double allCR = 0;

  double baseCD = 0;
  double weaponCD = 0;
  double bonusCD = 0;
  double allCD = 0;

  Map<int, double> baseCDbyLVL = {1: 50, 10: 50, 20: 50, 30: 50, 40: 50, 50: 59.6, 60: 69.2, 70: 69.2, 80: 78.8, 90: 88.4};

  Map<int, double> weapontoCDpercent = {};

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
  double weaponBonus1NormalATKDMGpercent = 0;
  double weaponBonus2NormalATKDMGpercent = 0;
  double weaponBonus1ChargedATKDMGpercent = 0;
  double weaponBonus2ChargedATKDMGpercent = 0;
  double bloomWeaponBonus2ChargedATKDMGpercent = 0;
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

  double bonusNormalATKDMGpercent = 0;
  double bonusChargedATKDMGpercent = 0;
  double bloomBonusChargedATKDMGpercent = 0;
  double bonusPhysicalDMGpercent = 0;
  double bonusPyroDMGpercent = 0;
  double bonusHydroDMGpercent = 0;
  double bonusCryoDMGpercent = 0;
  double bonusElectroDMGpercent = 0;
  double bonusAnemoDMGpercent = 0;
  double bonusGeoDMGpercent = 0;
  double bonusBurstDMGpercent = 0;
  double bonusDMGpercent = 0;

  int weaponatk = 0;
  int basicatk = 0;
  int basicdef = 0;

  String weaponselect = 'amos';

  var weapontopng = {
    'amos': AssetImage('images/weapon/Weapon_Amos.png'),
    'skywardharp': AssetImage('images/weapon/Weapon_Skyward_Harp.png'),
    'alleyhunter': AssetImage('images/weapon/Weapon_Alley_Hunter.png'),
    'blackcliffwarbow': AssetImage('images/weapon/Weapon_Blackcliff_Warbow.png'),
    'compoundbow': AssetImage('images/weapon/Weapon_Compound_Bow.png'),
    'elegyfortheend': AssetImage('images/weapon/Weapon_Elegy_for_the_End.png'),
    'favoniuswarbow': AssetImage('images/weapon/Weapon_Favonius_Warbow.png'),
    'prototypecrescent': AssetImage('images/weapon/Weapon_Prototype_Crescent.png'),
    'rust': AssetImage('images/weapon/Weapon_Rust.png'),
    'sacrificialbow': AssetImage('images/weapon/Weapon_Sacrificial_Bow.png'),
    'thestringless': AssetImage('images/weapon/Weapon_The_Stringless.png'),
    'theviridescenthunt': AssetImage('images/weapon/Weapon_The_Viridescent_Hunt.png'),
    'windblumeode': AssetImage('images/weapon/Weapon_Windblume_Ode.png'),
    'slingshot': AssetImage('images/weapon/Weapon_Slingshot.png'),
    'sharpshooteroath': AssetImage('images/weapon/Weapon_Sharpshooter_Oath.png'),
    'recurvebow': AssetImage('images/weapon/Weapon_Recurve_Bow.png'),
    'messenger': AssetImage('images/weapon/Weapon_Messenger.png'),
    'ebonybow': AssetImage('images/weapon/Weapon_Ebony_Bow.png')
  };

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
  //
//ANCHOR artifactsetstat
  String artifactsetAselect = 'blizzard';
  String artifactsetBselect = 'blizzard';

  var artifactsettopng = {
    'blizzard': AssetImage('images/Item_Snowswept_Memory.png'),
    'troupe': AssetImage('images/Item_Troupes_Dawnlight.png'),
    'royal': AssetImage('images/Item_Royal_Flora.png'),
    'gladiator': AssetImage('images/Item_Gladiator_Nostalgia.png'),
    'maiden': AssetImage('images/Item_Maiden\'s_Distant_Love.png'),
    'thunderbird': AssetImage('images/Item_Thunderbird\'s_Mercy.png'),
    'thundersoother': AssetImage('images/Item_Thundersoother\'s_Heart.png')
  };

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
  double enemyPhysicalres = 10;
  double enemyPyrores = 10;
  double enemyHydrores = 10;
  double enemyDendrores = 10;
  double enemyElectrores = 10;
  double enemyAnemores = 10;
  double enemyCryores = 10;
  double enemyGeores = 10;
  int enemyPhysicalresv = 10;
  int enemyPyroresv = 10;
  int enemyHydroresv = 10;
  int enemyDendroresv = 10;
  int enemyElectroresv = 10;
  int enemyAnemoresv = 10;
  int enemyCryoresv = 10;
  int enemyGeoresv = 10;

  var eneresbytype = {
    1: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //1 -> Hilichurl
    2: {'physical': 70, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //2 -> Ruin Guard
    3: {'physical': -20, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //3 -> Treasure Hoarder
    4: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 999, 'cryo': 999, 'geo': 10}, //4 -> Andrius, Dominator of Wolves
    5: {'physical': 10, 'pyro': 999, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //5 -> Pyro Slime
    6: {'physical': 10, 'pyro': 10, 'hydro': 999, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //6 -> Hydro Slime
    7: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 999, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //7 -> Dendro Slime
    8: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 999, 'anemo': 10, 'cryo': 10, 'geo': 10}, //8 -> Electro Slime
    9: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 999, 'cryo': 10, 'geo': 10}, //9 -> Anemo Slime
    10: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 999, 'geo': 10}, //10-> Cryo Slime
    11: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 999}, //11-> Geo Slime
    12: {'physical': 30, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //12-> Mitachurl
    13: {'physical': 10, 'pyro': 50, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //13-> Pyro Samachurl
    14: {'physical': 10, 'pyro': 10, 'hydro': 50, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //14-> Hydro Samachurl
    15: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 50, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //15-> Dendro Samachurl
    16: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 50, 'cryo': 10, 'geo': 10}, //16-> Anemo Samachurl
    17: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 50}, //17-> Geo Samachurl
    18: {'physical': 50, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 70}, //18-> Stonehide Lawachurl
    19: {'physical': 50, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //19-> Ruin Hunter
    20: {'physical': 35, 'pyro': 75, 'hydro': 35, 'dendro': 35, 'electro': 35, 'anemo': 35, 'cryo': 35, 'geo': 35}, //20-> Pyro Flower
    21: {'physical': 35, 'pyro': 35, 'hydro': 35, 'dendro': 35, 'electro': 35, 'anemo': 35, 'cryo': 75, 'geo': 35}, //21-> Cryo Flower
    22: {'physical': 10, 'pyro': 50, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //22-> Pyro Flower(Stunned)
    23: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 50, 'geo': 10}, //23-> Cryo Flower(Stunned)
    24: {'physical': -20, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //24-> Fatui Skirmisher
    25: {'physical': 80, 'pyro': 110, 'hydro': 110, 'dendro': 110, 'electro': 110, 'anemo': 110, 'cryo': 110, 'geo': 110}, //25-> Fatui Skirmisher(Shielded)
    26: {'physical': -20, 'pyro': 50, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //26-> Fatui Pyro Agent
    27: {'physical': -20, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 50, 'anemo': 10, 'cryo': 10, 'geo': 10}, //27-> Fatui Electro Cincin Mage
    28: {'physical': 30, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 50}, //28-> Geovishap Hatchling
    29: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //29-> Abyss Mage
    30: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 999, 'anemo': 10, 'cryo': 10, 'geo': 10}, //30-> Electro Hypostasis
    31: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 999, 'cryo': 10, 'geo': 10}, //31-> Anemo Hypostasis
    32: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 999}, //32-> Geo Hypostasis
    33: {'physical': 130, 'pyro': 170, 'hydro': 110, 'dendro': 110, 'electro': 110, 'anemo': 110, 'cryo': 110, 'geo': 110}, //33-> Pyro Regisvine
    34: {'physical': 130, 'pyro': 110, 'hydro': 110, 'dendro': 110, 'electro': 110, 'anemo': 110, 'cryo': 170, 'geo': 110}, //34-> Cryo Regisvine
    35: {'physical': 30, 'pyro': 70, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //35-> Pyro Regisvine(Stunned)
    36: {'physical': 30, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 70, 'geo': 10}, //36-> Cryo Regisvine(Stunned)
    37: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 10, 'cryo': 10, 'geo': 10}, //37-> Dvalin
    38: {'physical': 10, 'pyro': 10, 'hydro': 10, 'dendro': 10, 'electro': 10, 'anemo': 999, 'cryo': 999, 'geo': 10} //38-> Andrius
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

  double echoingballaddmgnc = 0;
  double echoingballaddmgexp = 0;
  double echoingballaddmgc = 0;

  double overloadDMGpercent = 0;
  double superconductDMGpercent = 0;
  double electrochargedDMGpercent = 0;
  double shatteredDMGpercent = 0;
  double swirlDMGpercent = 0;
  double vaporizeDMGpercent = 0;
  double meltDMGpercent = 0;

  double overloadDMG = 0;
  double superconductDMG = 0;
  double electrochargedDMG = 0;
  double shatteredDMG = 0;
  double swirlDMGonPyro = 0;
  double swirlDMGonCryo = 0;
  double swirlDMGonHydro = 0;
  double swirlDMGonElectro = 0;

//ANCHOR optionsstat
  bool undividedHeartOn = false;
  bool harmonyOn = false;

  bool constellation1On = false;

  bool blizzardstrayer2On = true;
  bool blizzardstrayer41On = true;
  bool blizzardstrayer42On = true;
  bool troupesdawnlight2on = false;
  bool troupesdawnlight4on = false;
  bool royalflora2On = false;
  bool royalflora4On = false;
  bool gladiator2On = false;
  bool gladiator4On = false;
  bool maiden2On = false;
  bool maiden4On = false;
  bool thunderbird2On = false;
  bool thunderbird4On = false;
  bool thundersoother2On = false;
  bool thundersoother4On = false;

  bool strongWilled1On = true;
  bool strongWilled2On = true;
  int strongWilled2Times = 1;

  bool echoingBalladOn = false;

  bool unreturningOn = false;

  bool pyro2On = false;
  bool cryo2On = false;
  bool zhonglieOn = false;
  bool dragonslayerOn = false;
  int bennetbasicatk = 500;
  int bennetqlv = 8;
  bool bennetqOn = false;
  var bennetqlvtoratio = {
    1: 56,
    2: 60.2,
    3: 64.4,
    4: 70,
    5: 74.2,
    6: 78.4,
    7: 84,
    8: 89.6,
    9: 95.2,
    10: 100.8,
    11: 106.4,
    12: 112,
    13: 119,
    14: 126,
    15: 133,
  };

  int monaqlv = 8;
  bool monaqOn = false;
  var monaqlvtoratio = {
    1: 42,
    2: 44,
    3: 46,
    4: 48,
    5: 50,
    6: 52,
    7: 54,
    8: 56,
    9: 58,
    10: 60,
    11: 60,
    12: 60,
    13: 60,
    14: 60,
    15: 60,
  };

  bool manualatkOn = false;
  int manualatk = 0;
  bool manualatkpercentOn = false;
  int manualatkpercent = 0;

  bool manualCRpercentOn = false;
  int manualCRpercent = 0;
  bool manualCDpercentOn = false;
  int manualCDpercent = 0;

  bool manualEMOn = false;
  int manualEM = 0;

  bool manualDMGpercentOn = false;
  int manualDMGpercent = 0;

  bool manualresdebuffOn = false;
  int manualresdebuff = 0;

  int noblesseBonus = 20;

  String _label = '';

  void _setLabel(String s) {
    if (s == null) {
      return;
    }
    setState(() => _label = s);
  }

  //ANCHOR footerstat
  int dmgscale = 10;
  int statscale = 10;

  //ANCHOR artifactstatcontrol
  void artifactstatcontrol(String t, String s) {
    if (t == "A")
      artifactsetAselect = s;
    else if (t == "B") artifactsetBselect = s;

    if (artifactsetAselect == 'blizzard' && artifactsetBselect == 'blizzard') {
      blizzardstrayer2On = true;
      blizzardstrayer41On = true;
      blizzardstrayer42On = true;
    } else if (artifactsetAselect == 'blizzard' || artifactsetBselect == 'blizzard') {
      blizzardstrayer2On = true;
      blizzardstrayer41On = false;
      blizzardstrayer42On = false;
    } else {
      blizzardstrayer2On = false;
      blizzardstrayer41On = false;
      blizzardstrayer42On = false;
    }

    if (artifactsetAselect == 'troupe' && artifactsetBselect == 'troupe') {
      troupesdawnlight2on = true;
      troupesdawnlight4on = true;
    } else if (artifactsetAselect == 'troupe' || artifactsetBselect == 'troupe') {
      troupesdawnlight2on = true;
      troupesdawnlight4on = false;
    } else {
      troupesdawnlight2on = false;
      troupesdawnlight4on = false;
    }

    if (artifactsetAselect == 'royal' && artifactsetBselect == 'royal') {
      royalflora2On = true;
      royalflora4On = true;
    } else if (artifactsetAselect == 'royal' || artifactsetBselect == 'royal') {
      royalflora2On = true;
      royalflora4On = false;
    } else {
      royalflora2On = false;
      royalflora4On = false;
    }

    if (artifactsetAselect == 'gladiator' && artifactsetBselect == 'gladiator') {
      gladiator2On = true;
      gladiator4On = true;
    } else if (artifactsetAselect == 'gladiator' || artifactsetBselect == 'gladiator') {
      gladiator2On = true;
      gladiator4On = false;
    } else {
      gladiator2On = false;
      gladiator4On = false;
    }

    if (artifactsetAselect == 'maiden' && artifactsetBselect == 'maiden') {
      maiden2On = false;
      maiden4On = false;
    } else if (artifactsetAselect == 'maiden' || artifactsetBselect == 'maiden') {
      maiden2On = false;
      maiden4On = false;
    } else {
      maiden2On = false;
      maiden4On = false;
    }

    if (artifactsetAselect == 'thunderbird' && artifactsetBselect == 'thunderbird') {
      thunderbird2On = true;
      thunderbird4On = true;
    } else if (artifactsetAselect == 'thunderbird' || artifactsetBselect == 'thunderbird') {
      thunderbird2On = true;
      thunderbird4On = false;
    } else {
      thunderbird2On = false;
      thunderbird4On = false;
    }

    if (artifactsetAselect == 'thundersoother' && artifactsetBselect == 'thundersoother') {
      thundersoother2On = false;
      thundersoother4On = true;
    } else if (artifactsetAselect == 'thundersoother' || artifactsetBselect == 'thundersoother') {
      thundersoother2On = false;
      thundersoother4On = false;
    } else {
      thundersoother2On = false;
      thundersoother4On = false;
    }
  }

  //ANCHOR weaponstatcontrol
  void weaponstatcontrol(String ws) {
    weaponselect = ws;

    //reset weapon sub stat
    weapontoatkpercent = {};
    weapontodefpercent = {};
    weapontoERpercent = {};
    weapontoPhysicalDMGpercent = {};
    weapontoPyroDMGpercent = {};
    weapontoHydroDMGpercent = {};
    weapontoCryoDMGpercent = {};
    weapontoElectroDMGpercent = {};
    weapontoAnemoDMGpercent = {};
    weapontoGeoDMGpercent = {};
    weapontoHPpercent = {};
    weapontoEM = {};
    weapontoCRpercent = {};
    weapontoCDpercent = {};

    weaponHPpercent = 0;
    weaponHPpercentstat = 0;
    weaponatkpercent = 0;
    weaponatkpercentstat = 0;
    weapondefpercent = 0;
    weapondefpercentstat = 0;
    weaponERpercent = 0;
    weaponCR = 0;
    weaponCD = 0;
    weaponEM = 0;

    weaponPhysicalDMGpercent = 0;
    weaponPyroDMGpercent = 0;
    weaponHydroDMGpercent = 0;
    weaponCryoDMGpercent = 0;
    weaponElectroDMGpercent = 0;
    weaponAnemoDMGpercent = 0;
    weaponGeoDMGpercent = 0;

    weaponBonus1NormalATKDMGpercent = 0;
    weaponBonus2NormalATKDMGpercent = 0;
    weaponBonus1ChargedATKDMGpercent = 0;
    weaponBonus2ChargedATKDMGpercent = 0;
    bloomWeaponBonus2ChargedATKDMGpercent = 0;

    if (weaponselect == "amos") {
      strongWilled1On = true;
      strongWilled2On = true;
      weapontoatk = {1: 46, 5: 62, 10: 82, 15: 102, 20: 122, 25: 173, 30: 194, 35: 214, 40: 235, 45: 287, 50: 308, 55: 361, 60: 382, 65: 435, 70: 457, 75: 510, 80: 532, 85: 586, 90: 608};
      weapontoatkpercent = {
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
    } else {
      strongWilled1On = false;
      strongWilled2On = false;
    }

    if (weaponselect == "skywardharp") {
      echoingBalladOn = true;
      weapontoatk = {1: 48, 5: 65, 10: 87, 15: 110, 20: 133, 25: 188, 30: 212, 35: 236, 40: 261, 45: 316, 50: 341, 55: 398, 60: 423, 65: 480, 70: 506, 75: 563, 80: 590, 85: 648, 90: 674};
      weapontoCRpercent = {
        1: 4.8,
        5: 5.6,
        10: 6.5,
        15: 7.5,
        20: 8.5,
        25: 9.5,
        30: 10.4,
        35: 11.4,
        40: 12.4,
        45: 13.3,
        50: 14.3,
        55: 15.3,
        60: 16.2,
        65: 17.2,
        70: 18.2,
        75: 19.1,
        80: 20.1,
        85: 21.1,
        90: 22.1
      };
    } else {
      echoingBalladOn = false;
    }

    if (weaponselect == "prototypecrescent") {
      unreturningOn = true;
      weapontoatk = {1: 42, 5: 56, 10: 74, 15: 91, 20: 109, 25: 152, 30: 170, 35: 187, 40: 205, 45: 248, 50: 266, 55: 306, 60: 327, 65: 370, 70: 388, 75: 431, 80: 449, 85: 492, 90: 510};
      weapontoatkpercent = {
        1: 9,
        5: 10.5,
        10: 12.3,
        15: 14.1,
        20: 15.9,
        25: 17.7,
        30: 19.5,
        35: 21.4,
        40: 23.2,
        45: 25,
        50: 26.8,
        55: 28.6,
        60: 30.4,
        65: 32.3,
        70: 34.1,
        75: 35.7,
        80: 37.7,
        85: 39.5,
        90: 41.3
      };
    } else {
      unreturningOn = false;
    }
  }

  //ANCHOR weaponPopup
  Future _showSimpleDialogw() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Select Weapon:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/weapon/Weapon_Amos.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              "Amos' Bow",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        weaponstatcontrol('amos');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/weapon/Weapon_Skyward_Harp.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              'Skyward Harp',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        weaponstatcontrol('skywardharp');
                      });
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Elegy_for_the_End.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Elegy for the End',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('elegyfortheend');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Favonius_Warbow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Favonius Warbow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('favoniuswarbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Windblume_Ode.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Windblume Ode',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('windblumeode');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Alley_Hunter.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Alley Hunter',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('alleyhunter');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Blackcliff_Warbow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Blackcliff Warbow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('blackcliffwarbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_The_Viridescent_Hunt.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'The Viridescent Hunt',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('theviridescenthunt');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/weapon/Weapon_Prototype_Crescent.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              'Prototype Crescent',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        weaponstatcontrol('prototypecrescent');
                      });
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Compound_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Compound Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('compoundbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_The_Stringless.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'The Stringless',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('thestringless');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage('images/weapon/Weapon_Rust.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Rust',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('rust');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Royal_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Royal Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('royalbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Sacrificial_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Sacrificial Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('sacrificialbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Slingshot.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Slingshot',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('slingshot');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Sharpshooter_Oath.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             "Sharpshooter's Oath",
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('sharpshootersoath');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Messenger.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Messenger',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('messenger');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Recurve_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Recurve Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('recurvebow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Raven_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Raven Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('ravenbow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                  // SimpleDialogOption(
                  //   child: Container(
                  //     width: 400,
                  //     height: 150,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             child: Container(
                  //               width: 140,
                  //               height: 140,
                  //               decoration: BoxDecoration(
                  //                 // color: Colors.lightBlue[50],
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(10)),
                  //                 image: DecorationImage(
                  //                   image: AssetImage(
                  //                       'weapon/Weapon_Ebony_Bow.png'),
                  //                   fit: BoxFit.contain,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: Text(
                  //             'Ebony Bow',
                  //             style: TextStyle(
                  //               //fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       weaponstatcontrol('ebonybow');
                  //     });
                  //     Navigator.pop(
                  //       context,
                  //       "user1",
                  //     );
                  //   },
                  // ),
                ],
              );
            },
          );
        });

    _setLabel(result);
  }

  //ANCHOR artifactsetAPopup
  Future _showSimpleDialogasA() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Select Artifact 2-Set A:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Snowswept_Memory.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Blizzard Strayer',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'blizzard');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Troupes_Dawnlight.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Troupe's Dawnlight",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'troupe');
                      });
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Royal_Flora.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Noblesse Oblige',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'royal');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Gladiator_Nostalgia.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Gladiator\'s Finale',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'gladiator');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Maiden\'s_Distant_Love.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Maiden Beloved',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'maiden');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Thunderbird\'s_Mercy.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Thundering Fury',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'thunderbird');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Thundersoother\'s_Heart.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Thundersoother',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("A", 'thundersoother');
                      });

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

  //ANCHOR artifactsetBPopup
  Future _showSimpleDialogasB() async {
    String result = "";
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: Text('Select Artifact 2-Set B:'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Snowswept_Memory.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Blizzard Strayer',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'blizzard');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Troupes_Dawnlight.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Troupe's Dawnlight",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'troupe');
                      });
                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Royal_Flora.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Noblesse Oblige',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'royal');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Gladiator_Nostalgia.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Gladiator\'s Finale',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'gladiator');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Maiden\'s_Distant_Love.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Maiden Beloved',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'maiden');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Thunderbird\'s_Mercy.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Thundering Fury',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'thunderbird');
                      });

                      Navigator.pop(
                        context,
                        "user1",
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: AssetImage('images/Item_Thundersoother\'s_Heart.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Thundersoother',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        artifactstatcontrol("B", 'thundersoother');
                      });

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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1atkpercent < 34.8) stat1atkpercent = num.parse((stat1atkpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1atkpercent > 0) stat1atkpercent = num.parse((stat1atkpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1atkpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1hppercent < 34.8) stat1hppercent = num.parse((stat1hppercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1hppercent > 0) stat1hppercent = num.parse((stat1hppercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1hppercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1defpercent < 43.8) stat1defpercent = num.parse((stat1defpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1defpercent > 0) stat1defpercent = num.parse((stat1defpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1defpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1CRpercent < 23.4) stat1CRpercent = num.parse((stat1CRpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1CRpercent > 0) stat1CRpercent = num.parse((stat1CRpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1CRpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1CDpercent < 46.8) stat1CDpercent = num.parse((stat1CDpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1CDpercent > 0) stat1CDpercent = num.parse((stat1CDpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1CDpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1EM < 138) stat1EM = num.parse((stat1EM + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1EM > 0) stat1EM = num.parse((stat1EM - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1ERpercent < 39) stat1ERpercent = num.parse((stat1ERpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1ERpercent > 0) stat1ERpercent = num.parse((stat1ERpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat1ERpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1hp < 1794) stat1hp = num.parse((stat1hp + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1hp > 0) stat1hp = num.parse((stat1hp - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1atk < 114) stat1atk = num.parse((stat1atk + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1atk > 0) stat1atk = num.parse((stat1atk - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1def < 138) stat1def = num.parse((stat1def + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat1def > 0) stat1def = num.parse((stat1def - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2atkpercent < 34.8) stat2atkpercent = num.parse((stat2atkpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2atkpercent > 0) stat2atkpercent = num.parse((stat2atkpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2atkpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2hppercent < 34.8) stat2hppercent = num.parse((stat2hppercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2hppercent > 0) stat2hppercent = num.parse((stat2hppercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2hppercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2defpercent < 43.8) stat2defpercent = num.parse((stat2defpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2defpercent > 0) stat2defpercent = num.parse((stat2defpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2defpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2CRpercent < 23.4) stat2CRpercent = num.parse((stat2CRpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2CRpercent > 0) stat2CRpercent = num.parse((stat2CRpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2CRpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2CDpercent < 46.8) stat2CDpercent = num.parse((stat2CDpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2CDpercent > 0) stat2CDpercent = num.parse((stat2CDpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2CDpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2EM < 138) stat2EM = num.parse((stat2EM + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2EM > 0) stat2EM = num.parse((stat2EM - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2ERpercent < 39) stat2ERpercent = num.parse((stat2ERpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2ERpercent > 0) stat2ERpercent = num.parse((stat2ERpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat2ERpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2hp < 1794) stat2hp = num.parse((stat2hp + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2hp > 0) stat2hp = num.parse((stat2hp - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2atk < 114) stat2atk = num.parse((stat2atk + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2atk > 0) stat2atk = num.parse((stat2atk - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2def < 138) stat2def = num.parse((stat2def + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat2def > 0) stat2def = num.parse((stat2def - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3atkpercent < 34.8) stat3atkpercent = num.parse((stat3atkpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3atkpercent > 0) stat3atkpercent = num.parse((stat3atkpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3atkpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3hppercent < 34.8) stat3hppercent = num.parse((stat3hppercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3hppercent > 0) stat3hppercent = num.parse((stat3hppercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3hppercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3defpercent < 43.8) stat3defpercent = num.parse((stat3defpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3defpercent > 0) stat3defpercent = num.parse((stat3defpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3defpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3CRpercent < 23.4) stat3CRpercent = num.parse((stat3CRpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3CRpercent > 0) stat3CRpercent = num.parse((stat3CRpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3CRpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3CDpercent < 46.8) stat3CDpercent = num.parse((stat3CDpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3CDpercent > 0) stat3CDpercent = num.parse((stat3CDpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3CDpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3EM < 138) stat3EM = num.parse((stat3EM + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3EM > 0) stat3EM = num.parse((stat3EM - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3ERpercent < 39) stat3ERpercent = num.parse((stat3ERpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3ERpercent > 0) stat3ERpercent = num.parse((stat3ERpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat3ERpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3hp < 1794) stat3hp = num.parse((stat3hp + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3hp > 0) stat3hp = num.parse((stat3hp - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3atk < 114) stat3atk = num.parse((stat3atk + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3atk > 0) stat3atk = num.parse((stat3atk - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3def < 138) stat3def = num.parse((stat3def + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat3def > 0) stat3def = num.parse((stat3def - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4atkpercent < 34.8) stat4atkpercent = num.parse((stat4atkpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4atkpercent > 0) stat4atkpercent = num.parse((stat4atkpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4atkpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4hppercent < 34.8) stat4hppercent = num.parse((stat4hppercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4hppercent > 0) stat4hppercent = num.parse((stat4hppercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4hppercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4defpercent < 43.8) stat4defpercent = num.parse((stat4defpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4defpercent > 0) stat4defpercent = num.parse((stat4defpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4defpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4CRpercent < 23.4) stat4CRpercent = num.parse((stat4CRpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4CRpercent > 0) stat4CRpercent = num.parse((stat4CRpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4CRpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4CDpercent < 46.8) stat4CDpercent = num.parse((stat4CDpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4CDpercent > 0) stat4CDpercent = num.parse((stat4CDpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4CDpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4EM < 138) stat4EM = num.parse((stat4EM + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4EM > 0) stat4EM = num.parse((stat4EM - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4ERpercent < 39) stat4ERpercent = num.parse((stat4ERpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4ERpercent > 0) stat4ERpercent = num.parse((stat4ERpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat4ERpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4hp < 1794) stat4hp = num.parse((stat4hp + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4hp > 0) stat4hp = num.parse((stat4hp - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4atk < 114) stat4atk = num.parse((stat4atk + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4atk > 0) stat4atk = num.parse((stat4atk - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4def < 138) stat4def = num.parse((stat4def + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat4def > 0) stat4def = num.parse((stat4def - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5atkpercent < 34.8) stat5atkpercent = num.parse((stat5atkpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5atkpercent > 0) stat5atkpercent = num.parse((stat5atkpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5atkpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5hppercent < 34.8) stat5hppercent = num.parse((stat5hppercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5hppercent > 0) stat5hppercent = num.parse((stat5hppercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5hppercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5defpercent < 43.8) stat5defpercent = num.parse((stat5defpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5defpercent > 0) stat5defpercent = num.parse((stat5defpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5defpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5CRpercent < 23.4) stat5CRpercent = num.parse((stat5CRpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5CRpercent > 0) stat5CRpercent = num.parse((stat5CRpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5CRpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5CDpercent < 46.8) stat5CDpercent = num.parse((stat5CDpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5CDpercent > 0) stat5CDpercent = num.parse((stat5CDpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5CDpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5EM < 138) stat5EM = num.parse((stat5EM + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5EM > 0) stat5EM = num.parse((stat5EM - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5ERpercent < 39) stat5ERpercent = num.parse((stat5ERpercent + 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5ERpercent > 0) stat5ERpercent = num.parse((stat5ERpercent - 0.1).toStringAsFixed(1));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                            stat5ERpercent = double.parse((value).toStringAsFixed(1));
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5hp < 1794) stat5hp = num.parse((stat5hp + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5hp > 0) stat5hp = num.parse((stat5hp - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5atk < 114) stat5atk = num.parse((stat5atk + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5atk > 0) stat5atk = num.parse((stat5atk - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      horizontalTitleGap: -10,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 130,
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
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_drop_up, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5def < 138) stat5def = num.parse((stat5def + 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 22.0, color: Colors.blue),
                                  onTap: () {
                                    setState(() {
                                      if (stat5def > 0) stat5def = num.parse((stat5def - 1).toStringAsFixed(0));
                                    });
                                  },
                                ),
                              ],
                            ),
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

    //bonusNormalATK
    bonusNormalATKDMGpercent = (strongWilled1On ? (9 + weaponref * 3) : 0) + (strongWilled2On ? (6 + weaponref * 2) * strongWilled2Times : 0) as double;
    //bonusChargedATK
    bonusChargedATKDMGpercent = (strongWilled1On ? (9 + weaponref * 3) : 0) + (strongWilled2On ? (6 + weaponref * 2) * strongWilled2Times : 0) + (troupesdawnlight4on ? 35 : 0) as double;
//bonusBurstATK
    bonusBurstDMGpercent = (royalflora2On ? 20 : 0) as double;
//bonusDMG
    bonusDMGpercent = (monaqOn ? monaqlvtoratio[monaqlv] : 0) + (thundersoother4On ? 35 : 0) + (manualDMGpercentOn ? manualDMGpercent : 0) as double;

    if (strongWilled2Times <= 3) {
      bloomBonusChargedATKDMGpercent = (strongWilled1On ? (9 + weaponref * 3) : 0) + (strongWilled2On ? (6 + weaponref * 2) * (strongWilled2Times + 2) : 0) + (troupesdawnlight4on ? 35 : 0) as double;
    } else {
      bloomBonusChargedATKDMGpercent = (strongWilled1On ? (9 + weaponref * 3) : 0) + (strongWilled2On ? (6 + weaponref * 2) * 5 : 0) + (troupesdawnlight4on ? 35 : 0) as double;
    }

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

    if (weaponatkpercent != null) {
      weaponatkpercentstat = basicatk * weaponatkpercent / 100;
    } else {
      weaponatkpercent = 0;
    }

    a2atk = a2atkbyLVL[pstar][plv];
    a3atkpercentMain = a3atkpercentbyLVL[sstar][slv];
    a4atkpercentMain = a4atkpercentbyLVL[gstar][glv];
    a5atkpercentMain = a5atkpercentbyLVL[cstar][clv];

    a3percentatkMain = (artifact3mainstatcat == 2) ? basicatk * a3atkpercentMain / 100 : 0;
    a4percentatkMain = artifact4mainstatcat == 2 ? basicatk * a4atkpercentMain / 100 : 0;
    a5percentatkMain = artifact5mainstatcat == 2 ? basicatk * a5atkpercentMain / 100 : 0;

    bonusatk = weaponatkpercentstat +
        a1percentatk +
        (stat1atkOn ? stat1atk : 0) +
        a2atk +
        a2percentatk +
        a3percentatkMain +
        a3percentatk +
        (stat3atkOn ? stat3atk : 0) +
        a4percentatkMain +
        a4percentatk +
        (stat4atkOn ? stat4atk : 0) +
        a5percentatkMain +
        a5percentatk +
        (stat5atkOn ? stat5atk : 0) +
        (unreturningOn ? basicatk * (27 + weaponref * 9) / 100 : 0) +
        (pyro2On ? basicatk * 25 / 100 : 0) +
        (gladiator2On ? basicatk * 18 / 100 : 0) +
        (royalflora4On ? basicatk * 20 / 100 : 0) +
        (dragonslayerOn ? basicatk * 48 / 100 : 0) +
        (bennetqOn ? bennetbasicatk * bennetqlvtoratio[bennetqlv] / 100 : 0) +
        (manualatkOn ? manualatk : 0) +
        (manualatkpercentOn ? basicatk * manualatkpercent / 100 : 0);

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

    a3percentdefMain = (artifact3mainstatcat == 3) ? lvldef * a3defpercentMain / 100 : 0;
    a4percentdefMain = artifact4mainstatcat == 3 ? lvldef * a4defpercentMain / 100 : 0;
    a5percentdefMain = artifact5mainstatcat == 3 ? lvldef * a5defpercentMain / 100 : 0;

    bonusdef = weapondefpercentstat +
        a1percentdef +
        (stat1defOn ? stat1def : 0) +
        a2percentdef +
        (stat2defOn ? stat1def : 0) +
        a3percentdefMain +
        a3percentdef +
        (stat3defOn ? stat3def : 0) +
        a4percentdefMain +
        a4percentdef +
        (stat4defOn ? stat4def : 0) +
        a5percentdefMain +
        a5percentdef +
        (stat5defOn ? stat5def : 0);

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

    a3percentHPMain = (artifact3mainstatcat == 1) ? lvlhp * a3HPpercentMain / 100 : 0;
    a4percentHPMain = artifact4mainstatcat == 1 ? lvlhp * a4HPpercentMain / 100 : 0;
    a5percentHPMain = artifact5mainstatcat == 1 ? lvlhp * a5HPpercentMain / 100 : 0;

    bonusHP = weaponHPpercentstat +
        a1percenthp +
        (stat1hpOn ? stat1hp : 0) +
        a1hp +
        a2percenthp +
        (stat2hpOn ? stat2hp : 0) +
        a3percentHPMain +
        a3percentHP +
        (stat3hpOn ? stat3hp : 0) +
        a4percentHPMain +
        a4percentHP +
        (stat4hpOn ? stat4hp : 0) +
        a5percentHPMain +
        a5percentHP +
        (stat5hpOn ? stat5hp : 0);

    allHP = lvlhp + bonusHP;

    //ER params
    if (weapontoERpercent[weaponlv] != null) weaponERpercent = weapontoERpercent[weaponlv];

    a3ERpercentMain = a3ERpercentbyLVL[sstar][slv];
    a3percentERMain = artifact3mainstatcat == 5 ? a3ERpercentMain : 0;

    bonusER = weaponERpercent +
        a3percentERMain +
        (stat1ERpercentOn ? stat1ERpercent : 0) +
        (stat2ERpercentOn ? stat2ERpercent : 0) +
        (stat3ERpercentOn ? stat3ERpercent : 0) +
        (stat4ERpercentOn ? stat4ERpercent : 0) +
        (stat5ERpercentOn ? stat5ERpercent : 0);

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
    bonusEM = a3EM +
        a4EM +
        a5EM +
        (stat1EMOn ? stat1EM : 0) +
        (stat2EMOn ? stat2EM : 0) +
        (stat3EMOn ? stat3EM : 0) +
        (stat4EMOn ? stat4EM : 0) +
        (stat5EMOn ? stat5EM : 0) +
        (troupesdawnlight2on ? 80 : 0) +
        (manualEMOn ? manualEM : 0);

    allEM = lvlEM + bonusEM;

    //CR params
    if (baseCRbylvl[level] != null) {
      baseCR = baseCRbylvl[level];
    } else {
      baseCR = 5;
    }

    if (weapontoCRpercent[weaponlv] != null) {
      weaponCR = weapontoCRpercent[weaponlv];
    } else {
      weaponCR = 0;
    }

    a5CRmain = a5CRbyLVL[cstar][clv];
    a5CR = artifact5mainstatcat == 5 ? a5CRmain : 0;
    //baseCR += weaponCR;
    bonusCR = weaponCR +
        a5CR +
        (stat1CRpercentOn ? stat1CRpercent : 0) +
        (stat2CRpercentOn ? stat2CRpercent : 0) +
        (stat3CRpercentOn ? stat3CRpercent : 0) +
        (stat4CRpercentOn ? stat4CRpercent : 0) +
        (stat5CRpercentOn ? stat5CRpercent : 0) +
        (undividedHeartOn ? 20 : 0) +
        (blizzardstrayer41On ? 20 : 0) +
        (blizzardstrayer42On ? 20 : 0) +
        (cryo2On ? 15 : 0) +
        (manualCRpercentOn ? manualCRpercent : 0);
    allCR = baseCR + bonusCR;

    //CD params
    if (baseCDbyLVL[level] != null) baseCD = baseCDbyLVL[level];
    if (weapontoCDpercent[weaponlv] != null) weaponCD = weapontoCDpercent[weaponlv];
    a5CDmain = a5CDbyLVL[cstar][clv];
    a5CD = artifact5mainstatcat == 6 ? a5CDmain : 0;
    //baseCD += weaponCD;
    bonusCD = weaponCD +
        a5CD +
        (stat1CDpercentOn ? stat1CDpercent : 0) +
        (stat2CDpercentOn ? stat2CDpercent : 0) +
        (stat3CDpercentOn ? stat3CDpercent : 0) +
        (stat4CDpercentOn ? stat4CDpercent : 0) +
        (stat5CDpercentOn ? stat5CDpercent : 0) +
        (echoingBalladOn ? (15 + weaponref * 5) : 0) +
        (manualCDpercentOn ? manualCDpercent : 0);
    allCD = baseCD + bonusCD;

    //DMG params
    if (cleveltoPhysicalDMGpercent[level] != null) levelPhysicalDMGpercent = cleveltoPhysicalDMGpercent[level];
    if (weapontoPhysicalDMGpercent[weaponlv] != null) weaponPhysicalDMGpercent = weapontoPhysicalDMGpercent[weaponlv];

    a4PhysicalDMGpercentMain = a4PhysicalDMGpercentbyLVL[gstar][glv];
    a4PhysicalDMGpercent = artifact4mainstatcat == 5 ? a4PhysicalDMGpercentMain : 0;

    bonusPhysicalDMGpercent = levelPhysicalDMGpercent + weaponPhysicalDMGpercent + a4PhysicalDMGpercent;

    if (cleveltoPyroDMGpercent[level] != null) levelPyroDMGpercent = cleveltoPyroDMGpercent[level];
    if (weapontoPyroDMGpercent[weaponlv] != null) weaponPyroDMGpercent = weapontoPyroDMGpercent[weaponlv];

    a4PyroDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4PyroDMGpercent = artifact4mainstatcat == 6 ? a4PyroDMGpercentMain : 0;

    bonusPyroDMGpercent = levelPyroDMGpercent + weaponPyroDMGpercent + a4PyroDMGpercent;

    if (cleveltoHydroDMGpercent[level] != null) levelHydroDMGpercent = cleveltoHydroDMGpercent[level];
    if (weapontoHydroDMGpercent[weaponlv] != null) weaponHydroDMGpercent = weapontoHydroDMGpercent[weaponlv];

    a4HydroDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4HydroDMGpercent = artifact4mainstatcat == 7 ? a4HydroDMGpercentMain : 0;

    bonusHydroDMGpercent = levelHydroDMGpercent + weaponHydroDMGpercent + a4HydroDMGpercent;

    if (cleveltoCryoDMGpercent[level] != null) levelCryoDMGpercent = cleveltoCryoDMGpercent[level];
    if (weapontoCryoDMGpercent[weaponlv] != null) weaponCryoDMGpercent = weapontoCryoDMGpercent[weaponlv];

    a4CryoDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4CryoDMGpercent = artifact4mainstatcat == 8 ? a4CryoDMGpercentMain : 0;

    bonusCryoDMGpercent = levelCryoDMGpercent + weaponCryoDMGpercent + a4CryoDMGpercent + (blizzardstrayer2On ? 15 : 0) + (harmonyOn ? 20 : 0);

    if (cleveltoElectroDMGpercent[level] != null) levelElectroDMGpercent = cleveltoElectroDMGpercent[level];
    if (weapontoElectroDMGpercent[weaponlv] != null) weaponElectroDMGpercent = weapontoElectroDMGpercent[weaponlv];

    a4ElectroDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4ElectroDMGpercent = artifact4mainstatcat == 9 ? a4ElectroDMGpercentMain : 0;

    bonusElectroDMGpercent = levelElectroDMGpercent + weaponElectroDMGpercent + a4ElectroDMGpercent + (thunderbird2On == true ? 15 : 0);

    if (cleveltoAnemoDMGpercent[level] != null) levelAnemoDMGpercent = cleveltoAnemoDMGpercent[level];
    if (weapontoAnemoDMGpercent[weaponlv] != null) weaponAnemoDMGpercent = weapontoAnemoDMGpercent[weaponlv];

    a4AnemoDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4AnemoDMGpercent = artifact4mainstatcat == 10 ? a4AnemoDMGpercentMain : 0;

    bonusAnemoDMGpercent = levelAnemoDMGpercent + weaponAnemoDMGpercent + a4AnemoDMGpercent;

    if (cleveltoGeoDMGpercent[level] != null) levelGeoDMGpercent = cleveltoGeoDMGpercent[level];
    if (weapontoGeoDMGpercent[weaponlv] != null) weaponGeoDMGpercent = weapontoGeoDMGpercent[weaponlv];

    a4GeoDMGpercentMain = a4ElementDMGpercentbyLVL[gstar][glv];
    a4GeoDMGpercent = artifact4mainstatcat == 11 ? a4GeoDMGpercentMain : 0;

    bonusGeoDMGpercent = levelGeoDMGpercent + weaponGeoDMGpercent + a4GeoDMGpercent;

    //enemyparams

    enemyPhysicalresv = eneresbytype[enemytype]['physical'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyPhysicalresv < 0)
      enemyPhysicalres = 1 - enemyPhysicalresv / 2 / 100;
    else if (enemyPhysicalresv < 76)
      enemyPhysicalres = 1 - enemyPhysicalresv / 100;
    else if (enemyPhysicalresv < 800)
      enemyPhysicalres = 1 / (4 * enemyPhysicalresv / 100 + 1);
    else
      enemyPhysicalres = 0;

    enemyPyroresv = eneresbytype[enemytype]['pyro'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyPyroresv < 0)
      enemyPyrores = 1 - enemyPyroresv / 2 / 100;
    else if (enemyPyroresv < 76)
      enemyPyrores = 1 - enemyPyroresv / 100;
    else if (enemyPyroresv < 800)
      enemyPyrores = 1 / (4 * enemyPyroresv / 100 + 1);
    else
      enemyPyrores = 0;

    enemyHydroresv = eneresbytype[enemytype]['hydro'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyHydroresv < 0)
      enemyHydrores = 1 - enemyHydroresv / 2 / 100;
    else if (enemyHydroresv < 76)
      enemyHydrores = 1 - enemyHydroresv / 100;
    else if (enemyHydroresv < 800)
      enemyHydrores = 1 / (4 * enemyHydroresv / 100 + 1);
    else
      enemyHydrores = 0;

    enemyDendroresv = eneresbytype[enemytype]['dendro'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyDendroresv < 0)
      enemyDendrores = 1 - enemyDendroresv / 2 / 100;
    else if (enemyDendroresv < 76)
      enemyDendrores = 1 - enemyDendroresv / 100;
    else if (enemyDendroresv < 800)
      enemyDendrores = 1 / (4 * enemyDendroresv / 100 + 1);
    else
      enemyDendrores = 0;

    enemyElectroresv = eneresbytype[enemytype]['electro'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyElectroresv < 0)
      enemyElectrores = 1 - enemyElectroresv / 2 / 100;
    else if (enemyElectroresv < 76)
      enemyElectrores = 1 - enemyElectroresv / 100;
    else if (enemyElectroresv < 800)
      enemyElectrores = 1 / (4 * enemyElectroresv / 100 + 1);
    else
      enemyElectrores = 0;

    enemyAnemoresv = eneresbytype[enemytype]['anemo'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyAnemoresv < 0)
      enemyAnemores = 1 - enemyAnemoresv / 2 / 100;
    else if (enemyAnemoresv < 76)
      enemyAnemores = 1 - enemyAnemoresv / 100;
    else if (enemyAnemoresv < 800)
      enemyAnemores = 1 / (4 * enemyAnemoresv / 100 + 1);
    else
      enemyAnemores = 0;

    enemyCryoresv = eneresbytype[enemytype]['cryo'] - (constellation1On ? 15 : 0) - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyCryoresv < 0)
      enemyCryores = 1 - enemyCryoresv / 2 / 100;
    else if (enemyCryoresv < 76)
      enemyCryores = 1 - enemyCryoresv / 100;
    else if (enemyCryoresv < 800)
      enemyCryores = 1 / (4 * enemyCryoresv / 100 + 1);
    else
      enemyCryores = 0;

    enemyGeoresv = eneresbytype[enemytype]['geo'] - (zhonglieOn ? 20 : 0) - (manualresdebuffOn ? manualresdebuff : 0);
    if (enemyGeoresv < 0)
      enemyGeores = 1 - enemyGeoresv / 2 / 100;
    else if (enemyGeoresv < 76)
      enemyGeores = 1 - enemyGeoresv / 100;
    else if (enemyGeoresv < 800)
      enemyGeores = 1 / (4 * enemyGeoresv / 100 + 1);
    else
      enemyGeores = 0;

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
    frostflakebloomdmgpercent = natklvtoskill['Frostflake Arrow Bloom DMG'][natklv];

    trailoftheqilindmgpercent = natklvtoskill['Trail of the Qilin DMG'][eskilllv];
    trailoftheqilinhppercent = natklvtoskill['Trail of the Qilin HP'][eskilllv];
    celestialshowerdmgpercent = natklvtoskill['Celestial Shower DMG'][eburstlv];

    superconductDMGpercent = (1 + (2.4 * 25 * allEM / (9 * (allEM + 1400))) + (thunderbird4On == true ? 0.4 : 0)) * 100;
    superconductDMG = electroReactionBaseBYlv[level] * 1 * superconductDMGpercent / 100 * enemyCryores;

    overloadDMGpercent = (1 + (2.4 * 25 * allEM / (9 * (allEM + 1400))) + (thunderbird4On == true ? 0.4 : 0)) * 100;
    overloadDMG = electroReactionBaseBYlv[level] * 4 * overloadDMGpercent / 100 * enemyPyrores;

    electrochargedDMGpercent = (1 + (2.4 * 25 * allEM / (9 * (allEM + 1400))) + (thunderbird4On == true ? 0.4 : 0)) * 100;
    electrochargedDMG = electroReactionBaseBYlv[level] * 2.4 * electrochargedDMGpercent / 100 * enemyElectrores;

    shatteredDMGpercent = (1 + (2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100;
    shatteredDMG = electroReactionBaseBYlv[level] * 3 * shatteredDMGpercent / 100 * enemyPhysicalres;

    vaporizeDMGpercent = 100 * (1 + (1 * 25 * allEM) / (9 * (allEM + 1400)));
    meltDMGpercent = 100 * (1 + (1 * 25 * allEM) / (9 * (allEM + 1400)));

    swirlDMGpercent = (1 + (2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100;
    swirlDMGonHydro = electroReactionBaseBYlv[level] * 1.2 * swirlDMGpercent / 100 * enemyHydrores;
    swirlDMGonPyro = electroReactionBaseBYlv[level] * 1.2 * swirlDMGpercent / 100 * enemyPyrores;
    swirlDMGonElectro = electroReactionBaseBYlv[level] * 1.2 * swirlDMGpercent / 100 * enemyElectrores;
    swirlDMGonCryo = electroReactionBaseBYlv[level] * 1.2 * swirlDMGpercent / 100 * enemyCryores;

    hit1dmgc = allatk *
        (hit1dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit1dmgnc = allatk *
        (hit1dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit1dmgexp = allatk *
        (hit1dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hit2dmgc = allatk *
        (hit2dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit2dmgnc = allatk *
        (hit2dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit2dmgexp = allatk *
        (hit2dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hit3dmgc = allatk *
        (hit3dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit3dmgnc = allatk *
        (hit3dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit3dmgexp = allatk *
        (hit3dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hit4dmgc = allatk *
        (hit4dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit4dmgnc = allatk *
        (hit4dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit4dmgexp = allatk *
        (hit4dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hit5dmgc = allatk *
        (hit5dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit5dmgnc = allatk *
        (hit5dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit5dmgexp = allatk *
        (hit5dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hit6dmgc = allatk *
        (hit6dmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit6dmgnc = allatk *
        (hit6dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hit6dmgexp = allatk *
        (hit6dmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusNormalATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    aimdmgc = allatk *
        (aimdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    aimdmgnc = allatk *
        (aimdmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    aimdmgexp = allatk *
        (aimdmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    caimdmgc = allatk *
        (caimdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    caimdmgnc = allatk *
        (caimdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    caimdmgexp = allatk *
        (caimdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    plungedmgc = allatk *
        (plungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    plungedmgnc = allatk *
        (plungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    plungedmgexp = allatk *
        (plungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    lplungedmgc = allatk *
        (lplungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    lplungedmgnc = allatk *
        (lplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    lplungedmgexp = allatk *
        (lplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    hplungedmgc = allatk *
        (hplungedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hplungedmgnc = allatk *
        (hplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    hplungedmgexp = allatk *
        (hplungedmgpercent / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    frostflakedmgc = allatk *
        (frostflakedmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    frostflakedmgnc = allatk *
        (frostflakedmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    frostflakedmgexp = allatk *
        (frostflakedmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    frostflakebloomdmgc = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100 + bloomBonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    frostflakebloomdmgnc = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bloomBonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    frostflakebloomdmgexp = allatk *
        (frostflakebloomdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bloomBonusChargedATKDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    frostflakealldmgc = frostflakebloomdmgc + frostflakedmgc;
    frostflakealldmgnc = frostflakebloomdmgnc + frostflakedmgnc;
    frostflakealldmgexp = frostflakebloomdmgexp + frostflakedmgexp;

    trailoftheqilindmgc = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    trailoftheqilindmgnc = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    trailoftheqilindmgexp = allatk *
        (trailoftheqilindmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    trailoftheqilinhp = allHP * trailoftheqilinhppercent / 100;

    celestialshowerdmgc = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + allCD / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusBurstDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    celestialshowerdmgnc = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusBurstDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores;

    celestialshowerdmgexp = allatk *
        (celestialshowerdmgpercent / 100) *
        (1 + bonusCryoDMGpercent / 100 + bonusBurstDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyCryores *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    echoingballaddmgc = allatk *
        (125 / 100) *
        (1 + allCD / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres;

    echoingballaddmgnc =
        allatk * (125 / 100) * (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) * (100 + level) / ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) * enemyPhysicalres;

    echoingballaddmgexp = allatk *
        (125 / 100) *
        (1 + bonusPhysicalDMGpercent / 100 + bonusDMGpercent / 100) *
        (100 + level) /
        ((1 - enemydefdebuff / 100) * (100 + enemylv) + 100 + level) *
        enemyPhysicalres *
        (1 + allCD / 100 * (allCR < 100 ? allCR : 100) / 100);

    //screenadjust
    double heightadjust = (MediaQuery.of(context).size.height - 200 > 800) ? (MediaQuery.of(context).size.height - 200) : 800;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            SizedBox(width: 10),
            Container(
              width: 120,
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  ' ver Ganyu 0.9',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
              ),
              //color: Colors.white,
            )
          ],
        ),
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
                height: heightadjust,
                //color: Colors.lightBlue[50],
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  image: DecorationImage(
                    image: AssetImage('images/2021010519290354247.png'),
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
                        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/2020060220525531988.png'),
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
                        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                height: heightadjust,
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),

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
                                  onTap: _showSimpleDialogw,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      // color: Colors.lightBlue[50],
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: weapontopng[weaponselect],
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: _showSimpleDialogasA,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: artifactsettopng[artifactsetAselect],
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: _showSimpleDialogasB,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: artifactsettopng[artifactsetBselect],
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage('images/Icon_Flower_of_Life.png'),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Text('Please click to set stats'),
                                                if (stat1atkpercentOn) Text('ATK%:$stat1atkpercent'),
                                                if (stat1hppercentOn) Text('HP%:$stat1hppercent'),
                                                if (stat1defpercentOn) Text('DEF%:$stat1defpercent'),
                                                if (stat1CRpercentOn) Text('Critial Rate%:$stat1CRpercent'),
                                                if (stat1CDpercentOn) Text('Critial Damage%:$stat1CDpercent'),
                                                if (stat1EMOn) Text('Elemental Mastery:$stat1EM'),
                                                if (stat1ERpercentOn) Text('Energy Recharge%:$stat1ERpercent'),
                                                if (stat1atkOn) Text('ATK:$stat1atk'),
                                                if (stat1hpOn) Text('HP:$stat1hp'),
                                                if (stat1defOn) Text('DEF:$stat1def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage('images/Icon_Plume_of_Death.png'),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Text('Please click to set stats'),
                                                if (stat2atkpercentOn) Text('ATK%:$stat2atkpercent'),
                                                if (stat2hppercentOn) Text('HP%:$stat2hppercent'),
                                                if (stat2defpercentOn) Text('DEF%:$stat2defpercent'),
                                                if (stat2CRpercentOn) Text('Critial Rate%:$stat2CRpercent'),
                                                if (stat2CDpercentOn) Text('Critial Damage%:$stat2CDpercent'),
                                                if (stat2EMOn) Text('Elemental Mastery:$stat2EM'),
                                                if (stat2ERpercentOn) Text('Energy Recharge%:$stat2ERpercent'),
                                                if (stat2atkOn) Text('ATK:$stat2atk'),
                                                if (stat2hpOn) Text('HP:$stat2hp'),
                                                if (stat2defOn) Text('DEF:$stat2def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage('images/Icon_Sands_of_Eon.png'),
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
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Energy Recharge%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 5)
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact3mainstatcat = value;
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Text('Please click to set stats'),
                                                if (stat3atkpercentOn) Text('ATK%:$stat3atkpercent'),
                                                if (stat3hppercentOn) Text('HP%:$stat3hppercent'),
                                                if (stat3defpercentOn) Text('DEF%:$stat3defpercent'),
                                                if (stat3CRpercentOn) Text('Critial Rate%:$stat3CRpercent'),
                                                if (stat3CDpercentOn) Text('Critial Damage%:$stat3CDpercent'),
                                                if (stat3EMOn) Text('Elemental Mastery:$stat3EM'),
                                                if (stat3ERpercentOn) Text('Energy Recharge%:$stat3ERpercent'),
                                                if (stat3atkOn) Text('ATK:$stat3atk'),
                                                if (stat3hpOn) Text('HP:$stat3hp'),
                                                if (stat3defOn) Text('DEF:$stat3def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage('images/Icon_Goblet_of_Eonothem.png'),
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
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Physical Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 5),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Pyro Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 6),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Hydro Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 7),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Cryo Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 8),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Electro Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 9),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Anemo Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 10),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Geo Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 11),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact4mainstatcat = value;
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Text('Please click to set stats'),
                                                if (stat4atkpercentOn) Text('ATK%:$stat4atkpercent'),
                                                if (stat4hppercentOn) Text('HP%:$stat4hppercent'),
                                                if (stat4defpercentOn) Text('DEF%:$stat4defpercent'),
                                                if (stat4CRpercentOn) Text('Critial Rate%:$stat4CRpercent'),
                                                if (stat4CDpercentOn) Text('Critial Damage%:$stat4CDpercent'),
                                                if (stat4EMOn) Text('Elemental Mastery:$stat4EM'),
                                                if (stat4ERpercentOn) Text('Energy Recharge%:$stat4ERpercent'),
                                                if (stat4atkOn) Text('ATK:$stat4atk'),
                                                if (stat4hpOn) Text('HP:$stat4hp'),
                                                if (stat4defOn) Text('DEF:$stat4def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.blue.withAlpha(30),
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: Colors.lightBlue[50],
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage('images/Icon_Circlet_of_Logos.png'),
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
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      "ATK%",
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "DEF%",
                                                        style: TextStyle(fontSize: 15),
                                                      ),
                                                      value: 3),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Elemental Mastery",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 4),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Critical Rate%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 5),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Critical Damage%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 6),
                                                  DropdownMenuItem(
                                                      child: Text(
                                                        "Healing Bonus%",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      value: 7),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    artifact5mainstatcat = value;
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              inactiveColor: Colors.lightBlue[50],
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Text('Please click to set stats'),
                                                if (stat5atkpercentOn) Text('ATK%:$stat5atkpercent'),
                                                if (stat5hppercentOn) Text('HP%:$stat5hppercent'),
                                                if (stat5defpercentOn) Text('DEF%:$stat5defpercent'),
                                                if (stat5CRpercentOn) Text('Critial Rate%:$stat5CRpercent'),
                                                if (stat5CDpercentOn) Text('Critial Damage%:$stat5CDpercent'),
                                                if (stat5EMOn) Text('Elemental Mastery:$stat5EM'),
                                                if (stat5ERpercentOn) Text('Energy Recharge%:$stat5ERpercent'),
                                                if (stat5atkOn) Text('ATK:$stat5atk'),
                                                if (stat5hpOn) Text('HP:$stat5hp'),
                                                if (stat5defOn) Text('DEF:$stat5def'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                height: heightadjust,
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Basic Panel',
                                style: TextStyle(fontSize: 20),
                              ),

                              //ANCHOR ATK

                              SizedBox(height: 10),
                              SelectableText(
                                'ATK:$basicatk + ' + double.parse(bonusatk.toStringAsFixed(1)).toString() + ' = ' + double.parse(allatk.toStringAsFixed(1)).toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
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
                                    //pyro2On:Colors.red
                                    //gladiator2On:Colors.purple
                                    //royalflora4On:Colors.purple

                                    FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ANCHOR statATK:stats
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildStatRow(Colors.red, 'level', '$levelatk'),
                                              buildStatRow(Colors.blue, 'weapon', '$weaponatk'),
                                              if (weaponatkpercent != 0) buildStatRow(Colors.green, 'weapon%($weaponatkpercent)', double.parse(weaponatkpercentstat.toStringAsFixed(1)).toString()),
                                              if (stat1atkOn == true) buildStatRow(Colors.red, 'a1', double.parse(stat1atk.toStringAsFixed(1)).toString()),
                                              if (stat1atkpercentOn == true) buildStatRow(Colors.yellow[700], 'a1%($stat1atkpercent)', double.parse(a1percentatk.toStringAsFixed(1)).toString()),
                                              buildStatRow(Colors.pink, 'a2', a2atk.toString()),
                                              if (stat2atkpercentOn == true) buildStatRow(Colors.pink[700], 'a2%($stat2atkpercent)', double.parse(a2percentatk.toStringAsFixed(1)).toString()),
                                              if (artifact3mainstatcat == 2) buildStatRow(Colors.blueGrey, 'a3%($a3atkpercentMain)', double.parse(a3percentatkMain.toStringAsFixed(1)).toString()),
                                              if (stat3atkpercentOn == true) buildStatRow(Colors.blueGrey, 'a3%($stat3atkpercent)', double.parse(a3percentatk.toStringAsFixed(1)).toString()),
                                              if (stat3atkOn == true) buildStatRow(Colors.blueGrey[700], 'a3', double.parse(stat3atk.toStringAsFixed(1)).toString()),
                                              if (artifact4mainstatcat == 2) buildStatRow(Colors.purple, 'a4%($a4atkpercentMain)', double.parse(a4percentatkMain.toStringAsFixed(1)).toString()),
                                              if (stat4atkpercentOn == true) buildStatRow(Colors.purple, 'a4%($stat4atkpercent)', double.parse(a4percentatk.toStringAsFixed(1)).toString()),
                                              if (stat4atkOn == true) buildStatRow(Colors.purple[700], 'a4', double.parse(stat4atk.toStringAsFixed(1)).toString()),
                                              if (artifact5mainstatcat == 2) buildStatRow(Colors.teal, 'a5%($a5atkpercentMain)', double.parse(a5percentatkMain.toStringAsFixed(1)).toString()),
                                              if (stat5atkpercentOn == true) buildStatRow(Colors.teal, 'a5%($stat5atkpercent)', double.parse(a5percentatk.toStringAsFixed(1)).toString()),
                                              if (stat5atkOn == true) buildStatRow(Colors.teal[700], 'a5', double.parse(stat5atk.toStringAsFixed(1)).toString()),
                                              if (pyro2On == true) buildStatRow(Colors.red, '2 pyro(25%)', (basicatk * 25 / 100).toStringAsFixed(1)),
                                              if (gladiator2On == true) buildStatRow(Colors.red, 'Gladiator2(18%)', (basicatk * 18 / 100).toStringAsFixed(1)),
                                              if (royalflora4On == true) buildStatRow(Colors.blue, 'Noblesse4(20%)', (basicatk * 20 / 100).toStringAsFixed(1)),
                                              if (unreturningOn == true)
                                                buildStatRow(
                                                    Colors.tealAccent, 'Unreturning(' + (27 + weaponref * 9).toStringAsFixed(1) + '%)', (basicatk * (27 + weaponref * 9) / 100).toStringAsFixed(1)),
                                              if (dragonslayerOn) buildStatRow(Colors.grey, 'Dragon Slayers(48%)', (basicatk * 48 / 100).toStringAsFixed(1)),
                                              if (bennetqOn) buildStatRow(Colors.red, 'Bennet(burst)', (bennetbasicatk * bennetqlvtoratio[bennetqlv] / 100).toStringAsFixed(1)),
                                              if (manualatkOn) buildStatRow(Colors.red[300], 'Manual:ATK', (manualatk.toStringAsFixed(1))),
                                              if (manualatkpercentOn) buildStatRow(Colors.red[300], 'Manual:ATK%($manualatkpercent)', ((basicatk * manualatkpercent / 100).toStringAsFixed(1))),
                                            ],
                                          ),
                                          //ANCHOR statATK:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildstatbar(Colors.red, levelatk),
                                              buildstatbar(Colors.blue, weaponatk),
                                              buildstatbar(Colors.green, weaponatkpercentstat),
                                              if (stat1atkOn == true) buildstatbar(Colors.yellow, stat1atk),
                                              if (stat1atkpercentOn == true) buildstatbar(Colors.yellow[700], a1percentatk),
                                              buildstatbar(Colors.pink, a2atk),
                                              if (stat2atkpercentOn == true) buildstatbar(Colors.pink[700], a2percentatk),
                                              if (artifact3mainstatcat == 2) buildstatbar(Colors.blueGrey, a3percentatkMain),
                                              if (stat3atkpercentOn == true) buildstatbar(Colors.blueGrey, a3percentatk),
                                              if (stat3atkOn == true) buildstatbar(Colors.blueGrey[700], stat3atk),
                                              if (artifact4mainstatcat == 2) buildstatbar(Colors.purple, a4percentatkMain),
                                              if (stat4atkpercentOn == true) buildstatbar(Colors.purple, a4percentatk),
                                              if (stat4atkOn == true) buildstatbar(Colors.purple[700], stat4atk),
                                              if (artifact5mainstatcat == 2) buildstatbar(Colors.teal, a5percentatkMain),
                                              if (stat5atkpercentOn == true) buildstatbar(Colors.teal, a5percentatk),
                                              if (stat5atkOn == true) buildstatbar(Colors.teal[700], stat5atk),
                                              if (pyro2On == true) buildstatbar(Colors.red, (basicatk * 25 / 100)),
                                              if (gladiator2On == true) buildstatbar(Colors.red, (basicatk * 18 / 100)),
                                              if (royalflora4On == true) buildstatbar(Colors.blue, (basicatk * 20 / 100)),
                                              if (unreturningOn == true) buildstatbar(Colors.tealAccent, (basicatk * (27 + weaponref * 9) / 100)),
                                              if (dragonslayerOn) buildstatbar(Colors.grey, (basicatk * 48 / 100)),
                                              if (bennetqOn) buildstatbar(Colors.red, (bennetbasicatk * bennetqlvtoratio[bennetqlv] / 100)),
                                              if (manualatkOn) buildstatbar(Colors.red[300], (manualatk)),
                                              if (manualatkpercentOn) buildstatbar(Colors.red[300], (basicatk * manualatkpercent / 100)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //ANCHOR HP

                              SizedBox(height: 10),
                              SelectableText(
                                'HP:$lvlhp + ' + double.parse(bonusHP.toStringAsFixed(1)).toString() + ' = ' + double.parse(allHP.toStringAsFixed(1)).toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      SelectableText(
                                                        '$lvlhp',
                                                        style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(weaponHPpercentstat.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat1hp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a1percenthp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      SelectableText(
                                                        a1hp.toString(),
                                                        style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat2hp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a2percenthp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a3percentHPMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a3percentHP.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat3hp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a4percentHPMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a4percentHP.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat4hp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a5percentHPMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a5percentHP.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat5hp.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),

                                          //ANCHOR statHP:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildstatbarhp(Colors.red, lvlhp),
                                              if (weaponHPpercent != 0) buildstatbarhp(Colors.blue, weaponHPpercentstat),
                                              if (stat1hpOn == true) buildstatbarhp(Colors.yellow, stat1hp),
                                              if (stat1hppercentOn == true) buildstatbarhp(Colors.yellow[700], a1percenthp),
                                              buildstatbarhp(Colors.yellow, a1hp),
                                              if (stat2hpOn == true) buildstatbarhp(Colors.pink, stat2hp),
                                              if (stat2hppercentOn == true) buildstatbarhp(Colors.pink[700], a2percenthp),
                                              if (artifact3mainstatcat == 1) buildstatbarhp(Colors.blueGrey, a3percentHPMain),
                                              if (stat3hppercentOn == true) buildstatbarhp(Colors.blueGrey, a3percentHP),
                                              if (stat3hpOn == true) buildstatbarhp(Colors.blueGrey[700], stat3hp),
                                              if (artifact4mainstatcat == 1) buildstatbarhp(Colors.purple, a4percentHPMain),
                                              if (stat4hppercentOn == true) buildstatbarhp(Colors.purple, a4percentHP),
                                              if (stat4hpOn == true) buildstatbarhp(Colors.purple[700], stat4hp),
                                              if (artifact5mainstatcat == 1) buildstatbarhp(Colors.teal, a5percentHPMain),
                                              if (stat5hppercentOn == true) buildstatbarhp(Colors.teal, a5percentHP),
                                              if (stat5hpOn == true) buildstatbarhp(Colors.teal[700], stat5hp),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //ANCHOR DEF
                              SelectableText(
                                'DEF:$lvldef + ' + double.parse(bonusdef.toStringAsFixed(1)).toString() + ' = ' + double.parse(alldef.toStringAsFixed(1)).toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ANCHOR statDEF:stats
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      SelectableText(
                                                        '$lvldef',
                                                        style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(weapondefpercentstat.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat1def.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a1percentdef.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a2percentdef.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a3percentdefMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a3percentdef.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat3def.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a4percentdefMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a4percentdef.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat4def.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a5percentdefMain.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(a5percentdef.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
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
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                        SelectableText(
                                                          double.parse(stat5def.toStringAsFixed(1)).toString(),
                                                          style: TextStyle(fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),

                                          //ANCHOR statDEF:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildstatbar(Colors.red, lvldef),
                                              if (weapondefpercentstat != 0) buildstatbar(Colors.blue, weapondefpercentstat),
                                              if (stat1defOn == true) buildstatbar(Colors.yellow, stat1def),
                                              if (stat1defpercentOn == true) buildstatbar(Colors.yellow[700], a1percentdef),
                                              if (stat2defpercentOn == true) buildstatbar(Colors.pink[700], a2percentdef),
                                              if (artifact3mainstatcat == 3) buildstatbar(Colors.blueGrey, a3percentdefMain),
                                              if (stat3defpercentOn == true) buildstatbar(Colors.blueGrey, a3percentdef),
                                              if (stat3defOn == true) buildstatbar(Colors.blueGrey[700], stat3def),
                                              if (artifact4mainstatcat == 3) buildstatbar(Colors.purple, a4percentdefMain),
                                              if (stat4defpercentOn == true) buildstatbar(Colors.purple, a4percentdef),
                                              if (stat4defOn == true) buildstatbar(Colors.purple[700], stat4def),
                                              if (artifact5mainstatcat == 3) buildstatbar(Colors.teal, a5percentdefMain),
                                              if (stat5defpercentOn == true) buildstatbar(Colors.teal, a5percentdef),
                                              if (stat5defOn == true) buildstatbar(Colors.teal[700], stat5def),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //ANCHOR ER
                              SelectableText(
                                'Energy Recharge:100% + ' + double.parse(bonusER.toStringAsFixed(1)).toString() + '% = ' + double.parse(allER.toStringAsFixed(1)).toString() + '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ANCHOR statER:stats
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildStatRow(Colors.red, 'baseER%', '100'),
                                              if (weaponERpercent != 0) buildStatRow(Colors.green, 'weapon%', '$weaponERpercent'),
                                              if (stat1ERpercentOn == true) buildStatRow(Colors.yellow[700], 'a1%', '$stat1ERpercent'),
                                              if (stat2ERpercentOn == true) buildStatRow(Colors.pink[700], 'a2%', '$stat2ERpercent'),
                                              if (artifact3mainstatcat == 5) buildStatRow(Colors.blueGrey, 'a3%', '$a3ERpercentMain'),
                                              if (stat3ERpercentOn == true) buildStatRow(Colors.blueGrey, 'a3%', '$stat3ERpercent'),
                                              if (stat4ERpercentOn == true) buildStatRow(Colors.purple, 'a4%', '$stat4ERpercent'),
                                              if (stat5ERpercentOn == true) buildStatRow(Colors.teal, 'a5%', '$stat5ERpercent'),
                                            ],
                                          ),

                                          //ANCHOR statER:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AnimatedContainer(
                                                    curve: Curves.easeIn,
                                                    duration: Duration(milliseconds: 500),
                                                    width: 100,
                                                    height: 20,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                              if (weaponERpercent != 0)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: weaponERpercent,
                                                      height: 20,
                                                      color: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              if (stat1ERpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat1ERpercent,
                                                      height: 20,
                                                      color: Colors.yellow[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat2ERpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat2ERpercent,
                                                      height: 20,
                                                      color: Colors.pink[700],
                                                    ),
                                                  ],
                                                ),
                                              if (artifact3mainstatcat == 5)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: a3ERpercentMain,
                                                      height: 20,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ],
                                                ),
                                              if (stat3ERpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat3ERpercent,
                                                      height: 20,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ],
                                                ),
                                              if (stat4ERpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat4ERpercent,
                                                      height: 20,
                                                      color: Colors.purple,
                                                    ),
                                                  ],
                                                ),
                                              if (stat5ERpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ANCHOR ***CritPanel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                    double.parse(baseCR.toStringAsFixed(1)).toString() +
                                    '% + ' +
                                    double.parse(bonusCR.toStringAsFixed(1)).toString() +
                                    '% = ' +
                                    double.parse(allCR.toStringAsFixed(1)).toString() +
                                    '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ANCHOR statCR:stats
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildStatRow(Colors.red, 'character', '$baseCR'),
                                              if (weaponCR != 0) buildStatRow(Colors.blue[700], 'weapon', '$weaponCR'),
                                              if (stat1CRpercentOn == true) buildStatRow(Colors.yellow[700], 'a1', '$stat1CRpercent'),
                                              if (stat2CRpercentOn == true) buildStatRow(Colors.pink[700], 'a2', '$stat2CRpercent'),
                                              if (stat3CRpercentOn == true) buildStatRow(Colors.blueGrey, 'a3', '$stat3CRpercent'),
                                              if (stat4CRpercentOn == true) buildStatRow(Colors.purple, 'a4', '$stat4CRpercent'),
                                              if (artifact5mainstatcat == 5) buildStatRow(Colors.purple, 'a5', '$a5CR'),
                                              if (stat5CRpercentOn == true) buildStatRow(Colors.teal, 'a5', '$stat5CRpercent'),
                                              if (undividedHeartOn == true) buildStatRow(Colors.amber, 'Undevided Heart', '20'),
                                              if (blizzardstrayer41On == true) buildStatRow(Colors.blue[300], 'Blizzard Strayer 4 set(cryo)', '20'),
                                              if (blizzardstrayer42On == true) buildStatRow(Colors.blue[400], 'Blizzard Strayer 4 set(frozen)', '20'),
                                              if (cryo2On == true) buildStatRow(Colors.blue[200], '2 Cryo', '15'),
                                              if (manualCRpercentOn) buildStatRow(Colors.red[300], 'Manual', ((manualCRpercent).toStringAsFixed(1))),
                                            ],
                                          ),

                                          //ANCHOR statCR:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AnimatedContainer(curve: Curves.easeIn, duration: Duration(milliseconds: 500), width: baseCR * 2, height: 20, color: Colors.red),
                                                ],
                                              ),
                                              if (weaponCR != 0)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: weaponCR * 2,
                                                      height: 20,
                                                      color: Colors.blue[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat1CRpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat1CRpercent * 2,
                                                      height: 20,
                                                      color: Colors.yellow[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat2CRpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat2CRpercent * 2,
                                                      height: 20,
                                                      color: Colors.pink[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat3CRpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat3CRpercent * 2,
                                                      height: 20,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ],
                                                ),
                                              if (stat4CRpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat4CRpercent * 2,
                                                      height: 20,
                                                      color: Colors.purple,
                                                    ),
                                                  ],
                                                ),
                                              if (artifact5mainstatcat == 5)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: a5CR * 2,
                                                      height: 20,
                                                      color: Colors.teal,
                                                    ),
                                                  ],
                                                ),
                                              if (stat5CRpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat5CRpercent * 2,
                                                      height: 20,
                                                      color: Colors.teal,
                                                    ),
                                                  ],
                                                ),
                                              if (undividedHeartOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: 40,
                                                      height: 20,
                                                      color: Colors.amber,
                                                    ),
                                                  ],
                                                ),
                                              if (blizzardstrayer41On == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: 40,
                                                      height: 20,
                                                      color: Colors.blue[300],
                                                    ),
                                                  ],
                                                ),
                                              if (blizzardstrayer42On == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: 40,
                                                      height: 20,
                                                      color: Colors.blue[400],
                                                    ),
                                                  ],
                                                ),
                                              if (cryo2On == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: 30,
                                                      height: 20,
                                                      color: Colors.blue[200],
                                                    ),
                                                  ],
                                                ),
                                              if (manualCRpercentOn) buildstatbarpercent(Colors.red[300], manualCRpercent),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //ANCHOR CD
                              SelectableText(
                                'Critical Damage:' +
                                    double.parse(baseCD.toStringAsFixed(1)).toString() +
                                    '% + ' +
                                    double.parse(bonusCD.toStringAsFixed(1)).toString() +
                                    '% = ' +
                                    double.parse(allCD.toStringAsFixed(1)).toString() +
                                    '%',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //ANCHOR statCD:stats
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              buildStatRow(Colors.red, 'character', '$baseCD'),
                                              if (weaponCD != 0) buildStatRow(Colors.blue, 'weapon', '$weaponCD'),
                                              if (stat1CDpercentOn == true) buildStatRow(Colors.yellow[700], 'a1', '$stat1CDpercent'),
                                              if (stat2CDpercentOn == true) buildStatRow(Colors.pink[700], 'a2', '$stat2CDpercent'),
                                              if (stat3CDpercentOn == true) buildStatRow(Colors.blueGrey, 'a3', '$stat3CDpercent'),
                                              if (stat4CDpercentOn == true) buildStatRow(Colors.blueGrey, 'a4', '$stat4CDpercent'),
                                              if (artifact5mainstatcat == 6) buildStatRow(Colors.teal, 'a5', '$a5CD'),
                                              if (stat5CDpercentOn == true) buildStatRow(Colors.teal, 'a5', '$stat5CDpercent'),
                                              if (echoingBalladOn == true) buildStatRow(Colors.tealAccent, 'Echoing Ballad1', (15 + weaponref * 5).toString()),
                                              if (manualCDpercentOn) buildStatRow(Colors.red[300], 'Manual', ((manualCDpercent).toStringAsFixed(1))),
                                            ],
                                          ),

                                          //ANCHOR statCD:bar
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              if ((baseCD - weaponCD) != 0)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(curve: Curves.easeIn, duration: Duration(milliseconds: 500), width: baseCD * 2, height: 20, color: Colors.red),
                                                  ],
                                                ),
                                              if (weaponCD != 0)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: weaponCD * 2,
                                                      height: 20,
                                                      color: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              if (stat1CDpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat1CDpercent * 2,
                                                      height: 20,
                                                      color: Colors.yellow[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat2CDpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat2CDpercent * 2,
                                                      height: 20,
                                                      color: Colors.pink[700],
                                                    ),
                                                  ],
                                                ),
                                              if (stat3CDpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat3CDpercent * 2,
                                                      height: 20,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ],
                                                ),
                                              if (stat4CDpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat4CDpercent * 2,
                                                      height: 20,
                                                      color: Colors.purple,
                                                    ),
                                                  ],
                                                ),
                                              if (artifact5mainstatcat == 6)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: a5CD * 2,
                                                      height: 20,
                                                      color: Colors.teal,
                                                    ),
                                                  ],
                                                ),
                                              if (stat5CDpercentOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: stat5CDpercent * 2,
                                                      height: 20,
                                                      color: Colors.teal,
                                                    ),
                                                  ],
                                                ),
                                              if (echoingBalladOn == true)
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedContainer(
                                                      curve: Curves.easeIn,
                                                      duration: Duration(milliseconds: 500),
                                                      width: (15 + weaponref * 5) * 2 as double,
                                                      height: 20,
                                                      color: Colors.tealAccent,
                                                    ),
                                                  ],
                                                ),
                                              if (manualCDpercentOn) buildstatbarpercent(Colors.red[300], manualCDpercent),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //ANCHOR ***Damageplus Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Damageplus Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    if (bonusNormalATKDMGpercent != 0)
                                      SelectableText(
                                        'Normal Attack Damage:' + double.parse(bonusNormalATKDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statNormalATKDMG:stats
                                    if (bonusNormalATKDMGpercent != 0)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (strongWilled1On) buildStatRow(Colors.purple[300], 'strong Willed1', (9 + weaponref * 3).toString()),
                                          if (strongWilled2On) buildStatRow(Colors.blue[300], 'strong Willed2', ((6 + weaponref * 2) * strongWilled2Times).toString()),
                                        ],
                                      ),
                                    //ANCHOR statNormalATKDMG:bar
                                    if (bonusNormalATKDMGpercent != 0)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (strongWilled1On)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(milliseconds: 500),
                                                  width: (9 + weaponref * 3) * 2 as double,
                                                  height: 20,
                                                  color: Colors.purple[300],
                                                ),
                                              ],
                                            ),
                                          if (strongWilled2On)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(milliseconds: 500),
                                                  width: ((6 + weaponref * 2) * strongWilled2Times) * 2 * 2 as double,
                                                  height: 20,
                                                  color: Colors.blue[300],
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    if (bonusChargedATKDMGpercent != 0)
                                      SelectableText(
                                        'Charged Attack Damage:' + double.parse(bonusChargedATKDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statChargedATKDMG:stats
                                    if (bonusChargedATKDMGpercent != 0)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (strongWilled1On) buildStatRow(Colors.purple[300], 'strong Willed1', (9 + weaponref * 3).toString()),
                                          if (strongWilled2On) buildStatRow(Colors.blue[300], 'strong Willed2', ((6 + weaponref * 2) * strongWilled2Times).toString()),
                                          if (troupesdawnlight4on) buildStatRow(Colors.green[400], "Troupe's Dawnlight 4 set", "35"),
                                        ],
                                      ),
                                    //ANCHOR statChargedATKDMG:bar
                                    if (bonusChargedATKDMGpercent != 0)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (strongWilled1On)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(milliseconds: 500),
                                                  width: (9 + weaponref * 3) * 2 as double,
                                                  height: 20,
                                                  color: Colors.purple[300],
                                                ),
                                              ],
                                            ),
                                          if (strongWilled2On)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(milliseconds: 500),
                                                  width: ((6 + weaponref * 2) * strongWilled2Times) * 2 * 2 as double,
                                                  height: 20,
                                                  color: Colors.blue[300],
                                                ),
                                              ],
                                            ),
                                          if (troupesdawnlight4on)
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(milliseconds: 500),
                                                  width: 35 * 2 as double,
                                                  height: 20,
                                                  color: Colors.green[400],
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    //ANCHOR Physical Damage Title
                                    if (bonusPhysicalDMGpercent != 0)
                                      SelectableText(
                                        'Physical Damage:' + double.parse(bonusPhysicalDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statPhysicalDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelPhysicalDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelPhysicalDMGpercent'),
                                        if (weaponPhysicalDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponPhysicalDMGpercent'),
                                        if (artifact4mainstatcat == 5) buildStatRow(Colors.purple, 'a4', '$a4PhysicalDMGpercent'),
                                      ],
                                    ),
                                    //ANCHOR statPhysicalDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelPhysicalDMGpercent != 0) buildstatbarpercent(Colors.red, levelPhysicalDMGpercent),
                                        if (weaponPhysicalDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponPhysicalDMGpercent),
                                        if (artifact4mainstatcat == 5) buildstatbarpercent(Colors.purple, a4PhysicalDMGpercent),
                                      ],
                                    ),
                                    //ANCHOR Pyro Damage Title
                                    if (bonusPyroDMGpercent != 0)
                                      SelectableText(
                                        'Pyro Damage:' + double.parse(bonusPyroDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statPyroDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelPyroDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelPyroDMGpercent'),
                                        if (weaponPyroDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponPyroDMGpercent'),
                                        if (artifact4mainstatcat == 6) buildStatRow(Colors.purple, 'a4', '$a4PyroDMGpercent'),
                                      ],
                                    ),
                                    //ANCHOR statPyroDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelPyroDMGpercent != 0) buildstatbarpercent(Colors.red, levelPyroDMGpercent),
                                        if (weaponPyroDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponPyroDMGpercent),
                                        if (artifact4mainstatcat == 6) buildstatbarpercent(Colors.purple, a4PyroDMGpercent),
                                      ],
                                    ),
                                    //ANCHOR Hydro Damage Title
                                    if (bonusHydroDMGpercent != 0)
                                      SelectableText(
                                        'Hydro Damage:' + double.parse(bonusHydroDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statHydroDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelHydroDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelHydroDMGpercent'),
                                        if (weaponHydroDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponHydroDMGpercent'),
                                        if (artifact4mainstatcat == 7) buildStatRow(Colors.purple, 'a4', '$a4HydroDMGpercent'),
                                      ],
                                    ),
                                    //ANCHOR statHydroDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelHydroDMGpercent != 0) buildstatbarpercent(Colors.red, levelHydroDMGpercent),
                                        if (weaponHydroDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponHydroDMGpercent),
                                        if (artifact4mainstatcat == 7) buildstatbarpercent(Colors.purple, a4HydroDMGpercent),
                                      ],
                                    ),
                                    //ANCHOR Cryo Damage Title
                                    if (bonusCryoDMGpercent != 0)
                                      SelectableText(
                                        'Cryo Damage:' + double.parse(bonusCryoDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statCryoDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelCryoDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelCryoDMGpercent'),
                                        if (weaponCryoDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponCryoDMGpercent'),
                                        if (artifact4mainstatcat == 8) buildStatRow(Colors.purple, 'a4', '$a4CryoDMGpercent'),
                                        if (blizzardstrayer2On) buildStatRow(Colors.blue[300], 'Blizzard Strayer 2 Set', '15'),
                                        if (harmonyOn) buildStatRow(Colors.amber, 'Harmony between Heaven and Earth', '20'),
                                      ],
                                    ),
                                    //ANCHOR statCryoDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelCryoDMGpercent != 0) buildstatbarpercent(Colors.red, levelCryoDMGpercent),
                                        if (weaponCryoDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponCryoDMGpercent),
                                        if (artifact4mainstatcat == 8) buildstatbarpercent(Colors.purple, a4CryoDMGpercent),
                                        if (blizzardstrayer2On) buildstatbarpercent(Colors.blue[300], 15),
                                        if (harmonyOn) buildstatbarpercent(Colors.amber, 20),
                                      ],
                                    ),
                                    //ANCHOR Electro Damage Title
                                    if (bonusElectroDMGpercent != 0)
                                      SelectableText(
                                        'Electro Damage:' + double.parse(bonusElectroDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statElectroDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelElectroDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelElectroDMGpercent'),
                                        if (weaponElectroDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponElectroDMGpercent'),
                                        if (artifact4mainstatcat == 9) buildStatRow(Colors.purple, 'a4', '$a4ElectroDMGpercent'),
                                        if (thunderbird2On) buildStatRow(Colors.purple[400], 'Thundering Fury 2 Set', '15'),
                                      ],
                                    ),
                                    //ANCHOR statElectroDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelElectroDMGpercent != 0) buildstatbarpercent(Colors.red, levelElectroDMGpercent),
                                        if (weaponElectroDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponElectroDMGpercent),
                                        if (artifact4mainstatcat == 9) buildstatbarpercent(Colors.purple, a4ElectroDMGpercent),
                                        if (thunderbird2On) buildstatbarpercent(Colors.purple[400], 15)
                                      ],
                                    ),
                                    //ANCHOR Anemo Damage Title
                                    if (bonusAnemoDMGpercent != 0)
                                      SelectableText(
                                        'Anemo Damage:' + double.parse(bonusAnemoDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statAnemoDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelAnemoDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelAnemoDMGpercent'),
                                        if (weaponAnemoDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponAnemoDMGpercent'),
                                        if (artifact4mainstatcat == 10) buildStatRow(Colors.purple, 'a4', '$a4AnemoDMGpercent'),
                                      ],
                                    ),
                                    //ANCHOR statAnemoDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelAnemoDMGpercent != 0) buildstatbarpercent(Colors.red, levelAnemoDMGpercent),
                                        if (weaponAnemoDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponAnemoDMGpercent),
                                        if (artifact4mainstatcat == 10) buildstatbarpercent(Colors.purple, a4AnemoDMGpercent),
                                      ],
                                    ),
                                    //ANCHOR Geo Damage Title
                                    if (bonusGeoDMGpercent != 0)
                                      SelectableText(
                                        'Geo Damage:' + double.parse(bonusGeoDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statGeoDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelGeoDMGpercent != 0) buildStatRow(Colors.red, 'character', '$levelGeoDMGpercent'),
                                        if (weaponGeoDMGpercent != 0) buildStatRow(Colors.green, 'weapon', '$weaponGeoDMGpercent'),
                                        if (artifact4mainstatcat == 11) buildStatRow(Colors.purple, 'a4', '$a4GeoDMGpercent'),
                                      ],
                                    ),
                                    //ANCHOR statGeoDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (levelGeoDMGpercent != 0) buildstatbarpercent(Colors.red, levelGeoDMGpercent),
                                        if (weaponGeoDMGpercent != 0) buildstatbarpercent(Colors.blue, weaponGeoDMGpercent),
                                        if (artifact4mainstatcat == 11) buildstatbarpercent(Colors.purple, a4GeoDMGpercent),
                                      ],
                                    ),

                                    //ANCHOR Elemental Burst Damage Title
                                    if (bonusBurstDMGpercent != 0)
                                      SelectableText(
                                        'Elemental Burst Damage:' + double.parse(bonusBurstDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statBurstDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (royalflora2On) buildStatRow(Colors.blue, 'Noblesse Oblige 2 Set', '20'),
                                      ],
                                    ),
                                    //ANCHOR statBurstDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (royalflora2On) buildstatbarpercent(Colors.blue, 20),
                                      ],
                                    ),
                                    //ANCHOR  Damage Bonus Title
                                    if (bonusDMGpercent != 0)
                                      SelectableText(
                                        'Damage Bonus:' + double.parse(bonusDMGpercent.toStringAsFixed(1)).toString() + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statBonusDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (monaqOn) buildStatRow(Colors.purple[300], 'Mona(burst)', (monaqlvtoratio[monaqlv] * 1).toStringAsFixed(1)),
                                        if (thundersoother4On) buildStatRow(Color(0xFF6480FF), 'Thundersoother 4 Set', '35'),
                                        if (manualDMGpercentOn) buildStatRow(Colors.red[300], 'Manual', ((manualDMGpercent).toStringAsFixed(1))),
                                      ],
                                    ),
                                    //ANCHOR statBonusDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (monaqOn) buildstatbarpercent(Colors.purple[300], (monaqlvtoratio[monaqlv] * 1)),
                                        if (thundersoother4On) buildstatbarpercent(Color(0xFF6480FF), 35),
                                        if (manualDMGpercentOn) buildstatbarpercent(Colors.red[300], manualDMGpercent),
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Reaction Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),

                              //ANCHOR EM
                              SelectableText(
                                'Elemental Mastery:$lvlEM + ' + double.parse(bonusEM.toStringAsFixed(1)).toString() + ' = ' + double.parse(allEM.toStringAsFixed(1)).toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    //ANCHOR statEM:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    '$lvlEM',
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
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
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (troupesdawnlight2on)
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.green[400],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    "Troupe's Dawnlight 2 set",
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                  SelectableText(
                                                    "80",
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (manualEMOn) buildStatRow(Colors.red[300], 'Manual', ((manualEM).toStringAsFixed(1))),
                                      ],
                                    ),

                                    //ANCHOR statEM:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(curve: Curves.easeIn, duration: Duration(milliseconds: 500), width: lvlEM / 7, height: 20, color: Colors.red),
                                          ],
                                        ),
                                        if (weaponEM != 0)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: weaponEM / 7,
                                                height: 20,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        if (stat1EMOn == true)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: stat1EM / 7,
                                                height: 20,
                                                color: Colors.yellow,
                                              ),
                                            ],
                                          ),
                                        if (stat2EMOn == true)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: stat2EM / 7,
                                                height: 20,
                                                color: Colors.pink,
                                              ),
                                            ],
                                          ),
                                        if (artifact3mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: a3EM / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (stat3EMOn == true)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: stat3EM / 7,
                                                height: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        if (artifact4mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: a4EM / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (stat4EMOn == true)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: stat4EM / 7,
                                                height: 20,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        if (artifact5mainstatcat == 4)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: a5EM / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (stat5EMOn == true)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: stat5EM / 7,
                                                height: 20,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        if (troupesdawnlight2on)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: Duration(milliseconds: 500),
                                                width: 80 / 7,
                                                height: 20,
                                                color: Colors.green[400],
                                              ),
                                            ],
                                          ),
                                        if (manualEMOn) buildstatbar(Colors.red[300], manualEM),
                                      ],
                                    ),
                                    //ANCHOR Vaporize Damage Title
                                    if (vaporizeDMGpercent > 100)
                                      SelectableText(
                                        'Vaporize Damage Plus:' + (vaporizeDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statVaporizeDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((1 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                      ],
                                    ),
                                    //ANCHOR statVaporizeDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((1 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                      ],
                                    ),
                                    //ANCHOR Melt Damage Title
                                    if (meltDMGpercent > 100)
                                      SelectableText(
                                        'Melt Damage Plus:' + (meltDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statMeltDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((1 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                      ],
                                    ),
                                    //ANCHOR statMeltDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((1 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                      ],
                                    ),

                                    //ANCHOR Superconduct Damage Title
                                    if (superconductDMGpercent > 100)
                                      SelectableText(
                                        'Superconduct Damage Plus:' + (superconductDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statSuperconductDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                        if (thunderbird4On) buildStatRow(Colors.purple[400], 'Thundering Fury 4 Set', '40'),
                                      ],
                                    ),
                                    //ANCHOR statSuperconductDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                        if (thunderbird4On) buildstatbarpercent(Colors.purple[400], 40),
                                      ],
                                    ),
                                    //ANCHOR Overloaded Damage Title
                                    if (overloadDMGpercent > 100)
                                      SelectableText(
                                        'Overloaded Damage Plus:' + (overloadDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statOverloadedDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                        if (thunderbird4On) buildStatRow(Colors.purple[400], 'Thundering Fury 4 Set', '40'),
                                      ],
                                    ),
                                    //ANCHOR statOverloadedDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                        if (thunderbird4On) buildstatbarpercent(Colors.purple[400], 40),
                                      ],
                                    ),
                                    //ANCHOR Electro-Charged Damage Title
                                    if (electrochargedDMGpercent > 100)
                                      SelectableText(
                                        'Electro-Charge Damage Plus:' + (electrochargedDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statElectro-ChargedDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                        if (thunderbird4On) buildStatRow(Colors.purple[400], 'Thundering Fury 4 Set', '40'),
                                      ],
                                    ),
                                    //ANCHOR statElectro-ChargedDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                        if (thunderbird4On) buildstatbarpercent(Colors.purple[400], 40),
                                      ],
                                    ),
                                    //ANCHOR Shattered Damage Title
                                    if (shatteredDMGpercent > 100)
                                      SelectableText(
                                        'Shattered Damage Plus:' + (shatteredDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statShatteredDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                      ],
                                    ),
                                    //ANCHOR statShatteredDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
                                      ],
                                    ),
                                    //ANCHOR Swirl Damage Title
                                    if (shatteredDMGpercent > 100)
                                      SelectableText(
                                        'Swirl Damage Plus:' + (swirlDMGpercent - 100).toStringAsFixed(1) + '%',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    //ANCHOR statShatteredDMG:stats
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildStatRow(Colors.amber[400], 'EM', (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100).toStringAsFixed(1)),
                                      ],
                                    ),
                                    //ANCHOR statShatteredDMG:bar
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (allEM != 0) buildstatbarpercent(Colors.amber[400], (((2.4 * 25 * allEM / (9 * (allEM + 1400)))) * 100)),
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 5),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Hydro Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 6),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Dendro Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 7),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Electro Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 8),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Anemo Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 9),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Cryo Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 10),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Geo Slime",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 11),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Mitachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 12),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Samachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 13),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Hydro Samachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 14),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Dendro Samachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 15),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Anemo Samachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 16),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Geo Samachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 17),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Stonehide Lawachurl",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 18),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Ruin Hunter",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 19),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Flower",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 20),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Cryo Flower",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 21),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Flower(Stunned)",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 22),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Cryo Flower(Stunned)",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 23),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Fatui Skirmisher",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 24),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Fatui Skirmisher(Shielded)",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 25),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Fatui Pyro Agent",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 26),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Fatui Electro Cincin Mage",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 27),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Geovishap Hatchling",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 28),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Abyss Mage",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 29),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Electro Hypostasis",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 30),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Anemo Hypostasis",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 31),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Geo Hypostasis",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 32),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Regisvine",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 33),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Cryo Regisvine",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 34),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Pyro Regisvine(Stunned)",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 35),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Cryo Regisvine(Stunned)",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 36),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Dvalin",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 37),
                                          DropdownMenuItem(
                                              child: Text(
                                                "Andrius",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              value: 38),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        //ANCHOR ***Options Panel***
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Options Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              //ANCHOR CharacterOptions
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                initiallyExpanded: true,
                                title: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Character',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                                children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Talents',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                    FilterChip(
                                      selectedColor: Colors.amber,
                                      backgroundColor: Colors.amber[200],
                                      label: Text('Undivided Heart: CRIT Rate + 20%'),
                                      selected: undividedHeartOn,
                                      onSelected: (bool value) {
                                        setState(() {
                                          undividedHeartOn = value;
                                        });
                                      },
                                    ),
                                    FilterChip(
                                      selectedColor: Colors.amber,
                                      backgroundColor: Colors.amber[200],
                                      label: Text('Harmony between Heaven and Earth: Cryo DMG + 20%'),
                                      selected: harmonyOn,
                                      onSelected: (bool value) {
                                        setState(() {
                                          harmonyOn = value;
                                        });
                                      },
                                    ),
                                  ]),
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Constellation',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                    FilterChip(
                                      label: Text('Constellation1: Enemy Cryo Res -15%'),
                                      selected: constellation1On,
                                      onSelected: (bool value) {
                                        setState(() {
                                          constellation1On = value;
                                        });
                                      },
                                    ),
                                  ]),
                                  SizedBox(height: 10),
                                ],
                              ),
                              //ANCHOR WeaponOptions

                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Weapon',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                                children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Weapon bonus',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  if (strongWilled1On)
                                    Column(
                                      children: [
                                        Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                          FilterChip(
                                            label: Text('Strong-Willed1: Normal and Charged Attack DMG + ' + (9 + weaponref * 3).toString() + '%'),
                                            selected: true,
                                            selectedColor: Colors.purple[300],
                                            onSelected: (bool value) {
                                              setState(() {});
                                            },
                                          ),
                                          FilterChip(
                                            label: Text('Strong-Willed2: ' + (6 + weaponref * 2).toString() + '% every 0.1s the arrow is in the air for up to 5 times.'),
                                            selected: true,
                                            selectedColor: Colors.blue[300],
                                            onSelected: (bool value) {
                                              setState(() {});
                                            },
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                        Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                          ChoiceChip(
                                            label: Text('0.1s'),
                                            selected: (strongWilled2Times == 1),
                                            onSelected: (bool value) {
                                              setState(() {
                                                strongWilled2Times = 1;
                                              });
                                            },
                                          ),
                                          ChoiceChip(
                                            label: Text('0.2s'),
                                            selected: (strongWilled2Times == 2),
                                            onSelected: (bool value) {
                                              setState(() {
                                                strongWilled2Times = 2;
                                              });
                                            },
                                          ),
                                          ChoiceChip(
                                            label: Text('0.3s'),
                                            selected: (strongWilled2Times == 3),
                                            onSelected: (bool value) {
                                              setState(() {
                                                strongWilled2Times = 3;
                                              });
                                            },
                                          ),
                                          ChoiceChip(
                                            label: Text('0.4s'),
                                            selected: (strongWilled2Times == 4),
                                            onSelected: (bool value) {
                                              setState(() {
                                                strongWilled2Times = 4;
                                              });
                                            },
                                          ),
                                          ChoiceChip(
                                            label: Text('0.5s'),
                                            selected: (strongWilled2Times == 5),
                                            onSelected: (bool value) {
                                              setState(() {
                                                strongWilled2Times = 5;
                                              });
                                            },
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  if (echoingBalladOn)
                                    Column(
                                      children: [
                                        Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                          FilterChip(
                                            label: Text('Echoing Ballad1: Crit DMG + ' + (15 + weaponref * 5).toString() + '%'),
                                            selected: true,
                                            selectedColor: Colors.tealAccent,
                                            onSelected: (bool value) {
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          FilterChip(
                                            label: Text(
                                                'Echoing Ballad2: ' + (50 + weaponref * 10).toString() + '% chance get a 125% Physical ATK AoE DMG every ' + (4.5 - weaponref * 0.5).toString() + 's'),
                                            selected: true,
                                            onSelected: (bool value) {
                                              setState(() {});
                                            },
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  if (weaponselect == 'prototypecrescent')
                                    Column(
                                      children: [
                                        Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                          FilterChip(
                                            label: Text('Unreturning: Charged Attack hits on weak points + 10% Movement SPD & ' + (27 + weaponref * 9).toString() + '% ATK for 10s'),
                                            selected: unreturningOn,
                                            selectedColor: Colors.tealAccent,
                                            onSelected: (bool value) {
                                              setState(() {
                                                unreturningOn = value;
                                              });
                                            },
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                ],
                              ),

                              //ANCHOR ArifactOptions

                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Artifact',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                                children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Artifact Bonus',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                    if (artifactsetAselect == 'blizzard' || artifactsetBselect == 'blizzard')
                                      FilterChip(
                                        label: Text('2 set: Cryo DMG +15%'),
                                        selectedColor: Colors.blue[300],
                                        backgroundColor: Colors.blue[200],
                                        selected: blizzardstrayer2On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            blizzardstrayer2On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'blizzard' && artifactsetBselect == 'blizzard')
                                      FilterChip(
                                        label: Text('4 set: Crit Rate +20%(cryo)'),
                                        selectedColor: Colors.blue[300],
                                        backgroundColor: Colors.blue[200],
                                        selected: blizzardstrayer41On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            blizzardstrayer41On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'blizzard' && artifactsetBselect == 'blizzard')
                                      FilterChip(
                                        label: Text('4 set: Crit Rate +20%(frozen)'),
                                        selectedColor: Colors.blue[400],
                                        backgroundColor: Colors.blue[300],
                                        selected: blizzardstrayer42On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            blizzardstrayer42On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'troupe' || artifactsetBselect == 'troupe')
                                      FilterChip(
                                        label: Text('2 set: em +80 '),
                                        selectedColor: Colors.green[400],
                                        backgroundColor: Colors.green[300],
                                        selected: troupesdawnlight2on,
                                        onSelected: (bool value) {
                                          setState(() {
                                            troupesdawnlight2on = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'troupe' && artifactsetBselect == 'troupe')
                                      FilterChip(
                                        label: Text('4 set: Charged Atk +35% '),
                                        selectedColor: Colors.green[400],
                                        backgroundColor: Colors.green[300],
                                        selected: troupesdawnlight4on,
                                        onSelected: (bool value) {
                                          setState(() {
                                            troupesdawnlight4on = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'royal' || artifactsetBselect == 'royal')
                                      FilterChip(
                                        label: Text('2 set: Elemental Burst DMG +20% '),
                                        selectedColor: Colors.blue,
                                        backgroundColor: Colors.blue[200],
                                        selected: royalflora2On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            royalflora2On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'royal' && artifactsetBselect == 'royal')
                                      FilterChip(
                                        label: Text('4 set: Using an Elemental Burst increases all party members\' ATK by 20% for 12s '),
                                        selectedColor: Colors.blue,
                                        backgroundColor: Colors.blue[200],
                                        selected: royalflora4On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            royalflora4On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'gladiator' || artifactsetBselect == 'gladiator')
                                      FilterChip(
                                        label: Text('2 set: ATK +18% '),
                                        selectedColor: Colors.red[400],
                                        backgroundColor: Colors.red[300],
                                        selected: gladiator2On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            gladiator2On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'gladiator' && artifactsetBselect == 'gladiator')
                                      FilterChip(
                                        label: Text('4 set: Increase Normal Attack DMG by 35% (Using sword/claymore/poleram) '),
                                        selectedColor: Colors.red[400],
                                        backgroundColor: Colors.red[300],
                                        selected: gladiator4On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            gladiator4On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'maiden' || artifactsetBselect == 'maiden')
                                      FilterChip(
                                        label: Text('2 set: Character Healing Effectiveness +15% '),
                                        selectedColor: Colors.grey,
                                        backgroundColor: Colors.grey,
                                        selected: maiden2On,
                                        onSelected: (bool value) {},
                                      ),
                                    if (artifactsetAselect == 'maiden' && artifactsetBselect == 'maiden')
                                      FilterChip(
                                        label: Text('4 set: Healing Received +20% '),
                                        selectedColor: Colors.grey,
                                        backgroundColor: Colors.grey,
                                        selected: maiden4On,
                                        onSelected: (bool value) {},
                                      ),
                                    if (artifactsetAselect == 'thunderbird' || artifactsetBselect == 'thunderbird')
                                      FilterChip(
                                        label: Text('2 set: Electro DMG Bonus +15% '),
                                        selectedColor: Colors.purple[400],
                                        backgroundColor: Colors.purple[300],
                                        selected: thunderbird2On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            thunderbird2On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'thunderbird' && artifactsetBselect == 'thunderbird')
                                      FilterChip(
                                        label: Text('4 set: Superconduct DMG  +40% '),
                                        selectedColor: Colors.purple[400],
                                        backgroundColor: Colors.purple[300],
                                        selected: thunderbird4On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            thunderbird4On = value;
                                          });
                                        },
                                      ),
                                    if (artifactsetAselect == 'thundersoother' || artifactsetBselect == 'thundersoother')
                                      FilterChip(
                                        label: Text('2 set: Electro RES +40% '),
                                        selectedColor: Colors.grey,
                                        backgroundColor: Colors.grey,
                                        selected: thundersoother2On,
                                        onSelected: (bool value) {},
                                      ),
                                    if (artifactsetAselect == 'thundersoother' && artifactsetBselect == 'thundersoother')
                                      FilterChip(
                                        label: Text('4 set: DMG Against Opponents Affected By Electro +35% '),
                                        selectedColor: Color(0xFF6446E6),
                                        backgroundColor: Color(0xFF6480FF),
                                        selected: thundersoother4On,
                                        onSelected: (bool value) {
                                          setState(() {
                                            thundersoother4On = value;
                                          });
                                        },
                                      ),
                                  ]),
                                  SizedBox(height: 10),
                                ],
                              ),

                              //ANCHOR UsualOptions
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Usual Buffs',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                                children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Elemental Resonance',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                    FilterChip(
                                      selectedColor: Colors.red,
                                      backgroundColor: Colors.red[200],
                                      label: Text('2 Pyro: ATK + 25%'),
                                      selected: pyro2On,
                                      onSelected: (bool value) {
                                        setState(() {
                                          pyro2On = value;
                                        });
                                      },
                                    ),
                                    FilterChip(
                                      selectedColor: Colors.blue[200],
                                      backgroundColor: Colors.blue[50],
                                      label: Text('2 Cryo: Crit Rate +15%'),
                                      selected: cryo2On,
                                      onSelected: (bool value) {
                                        setState(() {
                                          cryo2On = value;
                                        });
                                      },
                                    ),
                                  ]),
                                  SizedBox(height: 10),
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Character Buffs',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
                                    FilterChip(
                                      selectedColor: Colors.yellow,
                                      backgroundColor: Colors.yellow[200],
                                      label: Text('Zhongli(skill):Enemy All res - 20%'),
                                      selected: zhonglieOn,
                                      onSelected: (bool value) {
                                        setState(() {
                                          zhonglieOn = value;
                                        });
                                      },
                                    ),
                                    FilterChip(
                                      selectedColor: Colors.grey,
                                      backgroundColor: Colors.grey[200],
                                      label: Text('Thrilling Tales of Dragon Slayers(R5): ATK +48%'),
                                      selected: dragonslayerOn,
                                      onSelected: (bool value) {
                                        setState(() {
                                          dragonslayerOn = value;
                                        });
                                      },
                                    ),
                                  ]),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.red,
                                        backgroundColor: Colors.red[200],
                                        label: Text('Bennet(burst)'),
                                        selected: bennetqOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            bennetqOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bennet Basic atk:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "500",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                bennetbasicatk = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SelectableText(
                                        'Bennet Burst lv:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        //height: 50.0,
                                        width: 50.0,
                                        child: DropdownButton(
                                            //isExpanded: true,
                                            value: bennetqlv,
                                            iconSize: 20,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text(
                                                  "1",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "2",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 2,
                                              ),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 3),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 4),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 5),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "6",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 6,
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "7",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 7,
                                              ),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "8",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 8),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "9",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 9),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "10",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 10),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "11",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 11),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "12",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 12),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "13",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 13),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                bennetqlv = value;
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.purple[300],
                                        backgroundColor: Colors.purple[200],
                                        label: Text('Mona(burst)'),
                                        selected: monaqOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            monaqOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SelectableText(
                                        'Mona Burst lv:',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        //height: 50.0,
                                        width: 50.0,
                                        child: DropdownButton(
                                            //isExpanded: true,
                                            value: monaqlv,
                                            iconSize: 20,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text(
                                                  "1",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "2",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 2,
                                              ),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 3),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 4),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 5),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "6",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 6,
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  "7",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                value: 7,
                                              ),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "8",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 8),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "9",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 9),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "10",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 10),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "11",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 11),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "12",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 12),
                                              DropdownMenuItem(
                                                  child: Text(
                                                    "13",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  value: 13),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                monaqlv = value;
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),

                              //ANCHOR Manual Adjusts
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                    SelectableText(
                                      'Manual Adjusts',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('ATK'),
                                        selected: manualatkOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualatkOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bonus atk:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualatk = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('Crit Rate%'),
                                        selected: manualCRpercentOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualCRpercentOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bonus Crit Rate%:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualCRpercent = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('ATK%'),
                                        selected: manualatkpercentOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualatkpercentOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bonus atk%:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualatkpercent = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('Crit Damage%'),
                                        selected: manualCDpercentOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualCDpercentOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 120,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bonus Crit Damage%:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualCDpercent = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('EM'),
                                        selected: manualEMOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualEMOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Bonus EM:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualEM = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('Damage Bonus%'),
                                        selected: manualDMGpercentOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualDMGpercentOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Damage Bonus%:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualDMGpercent = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FilterChip(
                                        selectedColor: Colors.red[300],
                                        backgroundColor: Colors.red[200],
                                        label: Text('RES debuff'),
                                        selected: manualresdebuffOn,
                                        onSelected: (bool value) {
                                          setState(() {
                                            manualresdebuffOn = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 120,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            textAlignVertical: TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                                            decoration: InputDecoration(
                                              // prefixIcon: Text("basic atk"),
                                              labelText: 'Enemy Res Decrease:',

                                              contentPadding: EdgeInsets.all(5),
                                              //isDense: true,
                                            ),
                                            //maxLength: 4,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            initialValue: "0",
                                            // onSaved: (input) => bennetbasicatk = num.tryParse(input),
                                            onChanged: (value) {
                                              setState(() {
                                                manualresdebuff = num.tryParse(value) ?? 0;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 10,
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
            //ANCHOR ----DamagePage----
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: heightadjust,
                color: Colors.red[50],
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                title: builddamagebarwithcrit(
                                    Colors.black, 'Charged Aim Shoot Damage:($caimdmgpercent%)', Colors.lightBlue[200], Colors.lightBlue[400], Colors.lightBlue[600], caimdmgnc, caimdmgexp, caimdmgc),
                                children: <Widget>[
                                  builddamagebarwithcrit(Colors.black, '1-Hit Damage:($hit1dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit1dmgnc, hit1dmgexp, hit1dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, '2-Hit Damage:($hit2dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit2dmgnc, hit2dmgexp, hit2dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, '3-Hit Damage:($hit3dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit3dmgnc, hit3dmgexp, hit3dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, '4-Hit Damage:($hit4dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit4dmgnc, hit4dmgexp, hit4dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, '5-Hit Damage:($hit5dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit5dmgnc, hit5dmgexp, hit5dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, '6-Hit Damage:($hit6dmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hit6dmgnc, hit6dmgexp, hit6dmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.black, 'Aim Shoot Damage:($aimdmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], aimdmgnc, aimdmgexp, aimdmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(
                                      Colors.black, 'Plunge Damage:($plungedmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], plungedmgnc, plungedmgexp, plungedmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(
                                      Colors.black, 'Low Plunge Damage:($lplungedmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], lplungedmgnc, lplungedmgexp, lplungedmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(
                                      Colors.black, 'High Plunge Damage:($hplungedmgpercent%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], hplungedmgnc, hplungedmgexp, hplungedmgc),
                                  SizedBox(height: 10),
                                  builddamagebarwithcrit(Colors.red, 'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)', Colors.lightBlue[200], Colors.lightBlue[400],
                                      Colors.lightBlue[600], caimdmgnc * 1.5 * meltDMGpercent / 100, caimdmgexp * 1.5 * meltDMGpercent / 100, caimdmgc * 1.5 * meltDMGpercent / 100),
                                  SizedBox(height: 10),
                                ],
                              ),
                              //ANCHOR Frostflake Arrow
                              ExpansionTile(
                                  tilePadding: EdgeInsets.all(0),
                                  childrenPadding: EdgeInsets.all(0),
                                  title: builddamagebarwithcrit(Colors.black, 'Frostflake Arrow:($frostflakedmgpercent%)', Colors.lightBlue[200], Colors.lightBlue[400], Colors.lightBlue[600],
                                      frostflakedmgnc, frostflakedmgexp, frostflakedmgc),
                                  children: <Widget>[
                                    builddamagebarwithcrit(
                                        Colors.red,
                                        'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)',
                                        Colors.lightBlue[200],
                                        Colors.lightBlue[400],
                                        Colors.lightBlue[600],
                                        frostflakedmgnc * 1.5 * meltDMGpercent / 100,
                                        frostflakedmgexp * 1.5 * meltDMGpercent / 100,
                                        frostflakedmgc * 1.5 * meltDMGpercent / 100),
                                    SizedBox(height: 10),
                                  ]),
                              //ANCHOR Frostflake Arrow Bloom
                              ExpansionTile(
                                  tilePadding: EdgeInsets.all(0),
                                  childrenPadding: EdgeInsets.all(0),
                                  title: builddamagebarwithcrit(Colors.black, 'Frostflake Bloom:($frostflakebloomdmgpercent%)', Colors.lightBlue[200], Colors.lightBlue[400], Colors.lightBlue[600],
                                      frostflakebloomdmgnc, frostflakebloomdmgexp, frostflakebloomdmgc),
                                  children: <Widget>[
                                    builddamagebarwithcrit(
                                        Colors.red,
                                        'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)',
                                        Colors.lightBlue[200],
                                        Colors.lightBlue[400],
                                        Colors.lightBlue[600],
                                        frostflakebloomdmgnc * 1.5 * meltDMGpercent / 100,
                                        frostflakebloomdmgexp * 1.5 * meltDMGpercent / 100,
                                        frostflakebloomdmgc * 1.5 * meltDMGpercent / 100),
                                    SizedBox(height: 10),
                                  ]),
                              //ANCHOR Frostflake All
                              ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                childrenPadding: EdgeInsets.all(0),
                                title: builddamagebarwithcrit(Colors.black, 'Frostflake Arrow All', Colors.lightBlue[200], Colors.lightBlue[400], Colors.lightBlue[600], frostflakealldmgnc,
                                    frostflakealldmgexp, frostflakealldmgc),
                                children: <Widget>[
                                  builddamagebarwithcrit(
                                      Colors.red,
                                      'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)',
                                      Colors.lightBlue[200],
                                      Colors.lightBlue[400],
                                      Colors.lightBlue[600],
                                      frostflakealldmgnc * 1.5 * meltDMGpercent / 100,
                                      frostflakealldmgexp * 1.5 * meltDMGpercent / 100,
                                      frostflakealldmgc * 1.5 * meltDMGpercent / 100),
                                  SizedBox(height: 10),
                                ],
                              ),
                              if (echoingBalladOn)
                                //ANCHOR Echoing Ballad Physical AoE
                                builddamagebarwithcrit(Colors.black, 'Echoing Ballad Physical AoE:(125%)', Colors.grey[500], Colors.grey[700], Colors.grey[900], echoingballaddmgnc,
                                    echoingballaddmgexp, echoingballaddmgc),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Elemental Skill Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),

                              //ANCHOR Trail of the Qilin HP
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
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
                                title: builddamagebarwithcrit(Colors.black, 'Trail of the Qilin DMG:($trailoftheqilindmgpercent)', Colors.lightBlue[200], Colors.lightBlue[400], Colors.lightBlue[600],
                                    trailoftheqilindmgnc, trailoftheqilindmgexp, trailoftheqilindmgc),
                                children: <Widget>[
                                  builddamagebarwithcrit(
                                      Colors.red,
                                      'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)',
                                      Colors.lightBlue[200],
                                      Colors.lightBlue[400],
                                      Colors.lightBlue[600],
                                      trailoftheqilindmgnc * 1.5 * meltDMGpercent / 100,
                                      trailoftheqilindmgexp * 1.5 * meltDMGpercent / 100,
                                      trailoftheqilindmgc * 1.5 * meltDMGpercent / 100),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                  title: builddamagebarwithcrit(Colors.black, 'Celestial Shower/per Ice Shard:($celestialshowerdmgpercent%)', Colors.lightBlue[200], Colors.lightBlue[400],
                                      Colors.lightBlue[600], celestialshowerdmgnc, celestialshowerdmgexp, celestialshowerdmgc),
                                  children: <Widget>[
                                    builddamagebarwithcrit(
                                        Colors.red,
                                        'Melt:(' + double.parse((meltDMGpercent * 1.5).toStringAsFixed(1)).toString() + '%)',
                                        Colors.lightBlue[200],
                                        Colors.lightBlue[400],
                                        Colors.lightBlue[600],
                                        celestialshowerdmgnc * 1.5 * meltDMGpercent / 100,
                                        celestialshowerdmgexp * 1.5 * meltDMGpercent / 100,
                                        celestialshowerdmgc * 1.5 * meltDMGpercent / 100),
                                    SizedBox(height: 10),
                                  ]),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              SelectableText(
                                'Elemental Reactions Panel',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              //ANCHOR Superconduct DMG
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                SelectableText(
                                  'Superconduct:(' + superconductDMGpercent.toStringAsFixed(1) + '%)',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(superconductDMG.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: superconductDMG / 50,
                                        height: 20,
                                        color: Colors.lightBlue[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //ANCHOR Overloaded DMG
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                SelectableText(
                                  'Overloaded:(' + (overloadDMGpercent * 4).toStringAsFixed(1) + '%)',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(overloadDMG.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.red[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: overloadDMG / 50,
                                        height: 20,
                                        color: Colors.red[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //ANCHOR Electro-Charged DMG
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                SelectableText(
                                  'Electro-Charged:(' + (electrochargedDMGpercent * 2.4).toStringAsFixed(1) + '% * 2)',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(electrochargedDMG.toStringAsFixed(1)).toString() + ' * 2',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.purple[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: electrochargedDMG / 50,
                                        height: 20,
                                        color: Colors.purple[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //ANCHOR Shattered DMG
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                SelectableText(
                                  'Shattered:(' + shatteredDMGpercent.toStringAsFixed(1) + '%)',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(shatteredDMG.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: shatteredDMG / 50,
                                        height: 20,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //ANCHOR swirl DMG
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                SelectableText(
                                  'Swirl:(' + swirlDMGpercent.toStringAsFixed(1) + '%)',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG on Cryo:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(swirlDMGonCryo.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: swirlDMGonCryo / 50,
                                        height: 20,
                                        color: Colors.lightBlue[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG on Pyro:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(swirlDMGonPyro.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.red[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: swirlDMGonPyro / 50,
                                        height: 20,
                                        color: Colors.red[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG on Hydro:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(swirlDMGonHydro.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.blue[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: swirlDMGonHydro / 50,
                                        height: 20,
                                        color: Colors.blue[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SelectableText(
                                    'DMG on Electro:',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SelectableText(
                                    double.parse(swirlDMGonElectro.toStringAsFixed(1)).toString(),
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.purple[400],
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
                                        duration: Duration(milliseconds: 500),
                                        width: swirlDMGonElectro / 50,
                                        height: 20,
                                        color: Colors.purple[400],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SelectableText(
                            'Stat scale',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Slider(
                            min: 1,
                            max: 10,
                            divisions: 9,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey[200],
                            label: statscale.toString(),
                            value: statscale.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                statscale = value.toInt();
                              });
                            },
                          ),
                          SelectableText(
                            'Dmg scale',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Slider(
                            min: 1,
                            max: 10,
                            divisions: 9,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey[200],
                            label: dmgscale.toString(),
                            value: dmgscale.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                dmgscale = value.toInt();
                              });
                            },
                          ),
                        ],
                      ),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.favorite),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

//ANCHOR method:damagebarbuilder(crit)
  FractionallySizedBox builddamagebarwithcrit(Color titlec, String title, Color noncritc, Color expc, Color critc, var noncrit, var exp, var crit) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                SelectableText(
                  title,
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: titlec,
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
                    double.parse((noncrit).toStringAsFixed(1)).toString(),
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: noncritc,
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
                    double.parse(exp.toStringAsFixed(1)).toString(),
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: expc,
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
                    double.parse(crit.toStringAsFixed(1)).toString(),
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: critc,
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
                        duration: Duration(milliseconds: 500),
                        width: crit / 50 * dmgscale / 10,
                        height: 20,
                        color: critc,
                      ),
                      AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 500),
                        width: exp / 50 * dmgscale / 10,
                        height: 20,
                        color: expc,
                      ),
                      AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 500),
                        width: noncrit / 50 * dmgscale / 10,
                        height: 20,
                        color: noncritc,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//ANCHOR method:statbarbuilder
  Column buildstatbar(Color color, var a) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          width: a / 7 * statscale / 10,
          height: 20,
          color: color,
        ),
      ],
    );
  }

//ANCHOR method:statbarbuilder(HP)
  Column buildstatbarhp(Color color, var a) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          width: a / 75 * statscale / 10,
          height: 20,
          color: color,
        ),
      ],
    );
  }

//ANCHOR method:statbarbuilder:percent
  Column buildstatbarpercent(Color color, var a) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          width: a * 2,
          height: 20,
          color: color,
        ),
      ],
    );
  }

//ANCHOR method:statbuilder
  Row buildStatRow(Color color, String a, String b) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        Column(
          children: [
            SelectableText(
              a,
              style: TextStyle(fontSize: 10),
            ),
            SelectableText(
              b,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
