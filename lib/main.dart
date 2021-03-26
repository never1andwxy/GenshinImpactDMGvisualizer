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

  double weaponatkpercent = 0;
  double weaponatkpercentstat = 0;
  double bonusatk = 0;
  double allatk = 0;

  int weaponatk = 0;
  int basicatk = 0;

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

//ANCHOR artifact3stat
  int sstar = 5;
  int slv = 20;
  int artifact3mainstatcat = 1;
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

//ANCHOR artifact4stat
  int gstar = 5;
  int glv = 20;
  int artifact4mainstatcat = 1;
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

//ANCHOR artifact5stat
  int cstar = 5;
  int clv = 20;
  int artifact5mainstatcat = 1;
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

//ANCHOR ---homepage----
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    levelatk = cleveltoatk[level];
    weaponatk = weapontoatk[weaponlv];
    weaponatkpercent = weapontoatkpercent[weaponlv];
    basicatk = levelatk + weaponatk;
    weaponatkpercentstat = basicatk * weaponatkpercent / 100;
    bonusatk = weaponatkpercentstat;
    allatk = basicatk + bonusatk;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ResponsiveGridRow(children: [
            //ANCHOR characterPage
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
            //ANCHOR weapon&artifactPage
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
                                      SelectableText(
                                        'Flower: HP',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
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
                                        width: 300,
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
                                      SelectableText(
                                        'Plume: ATK',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
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
                                        width: 300,
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
                                          DropdownButton(
                                              value: artifact3mainstatcat,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "HP%",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  value: 1,
                                                ),
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "ATK%",
                                                    style:
                                                        TextStyle(fontSize: 15),
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
                                                  artifact3mainstatcat = value;
                                                });
                                              }),
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
                                        width: 300,
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
                                          DropdownButton(
                                              value: artifact4mainstatcat,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "HP%",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  value: 1,
                                                ),
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "ATK%",
                                                    style:
                                                        TextStyle(fontSize: 15),
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
                                                  artifact4mainstatcat = value;
                                                });
                                              }),
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
                                        width: 300,
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
                                            'Cirket:',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          DropdownButton(
                                              value: artifact5mainstatcat,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "HP%",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  value: 1,
                                                ),
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "ATK%",
                                                    style:
                                                        TextStyle(fontSize: 15),
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
                                                  artifact5mainstatcat = value;
                                                });
                                              }),
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
                                        width: 300,
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

            //ANCHOR statPage
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                color: Colors.yellow[50],
                child: Center(
                  //ANCHOR statATK
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SelectableText(
                        'Status:',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        'ATK:$basicatk + ' +
                            double.parse(bonusatk.toStringAsFixed(1))
                                .toString() +
                            ' = ' +
                            double.parse(allatk.toStringAsFixed(1)).toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  'level',
                                  style: TextStyle(fontSize: 10),
                                ),
                                SelectableText(
                                  '$levelatk',
                                  style: TextStyle(fontSize: 10),
                                ),
                                AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 500),
                                  width: levelatk / 7,
                                  height: 20,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  'weapon',
                                  style: TextStyle(fontSize: 10),
                                ),
                                SelectableText(
                                  '$weaponatk',
                                  style: TextStyle(fontSize: 10),
                                ),
                                AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 500),
                                  width: weaponatk / 7,
                                  height: 20,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  'weapon%($weaponatkpercent)',
                                  style: TextStyle(fontSize: 10),
                                ),
                                SelectableText(
                                  double.parse(weaponatkpercentstat
                                          .toStringAsFixed(1))
                                      .toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 500),
                                  width: weaponatk / 7,
                                  height: 20,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              xs: 12,
              md: 6,
              lg: 3,
              child: Container(
                height: 800,
                color: Colors.red[50],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SelectableText(
                        'You have liked your wife this many times:',
                      ),
                      Image(
                        image: AssetImage('Character_Ganyu_Portrait.png'),
                        height: 500,
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //ANCHOR damagePage
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
