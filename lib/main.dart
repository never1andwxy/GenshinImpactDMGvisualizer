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
  int _counter = 0;
  int level = 80;
  int cons = 0;
  int natklv = 8;
  int eskilllv = 8;
  int eburstlv = 8;
  int weaponlv = 80;
  int weaponref = 1;
  int fstar = 5;
  int flv = 20;
  String fsub1n = 'HP%';

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

//artifact1stat
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

//artifact2stat
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

//artifact3stat
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

  //artifact4stat
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

//artifact5stat
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

  String _label = '';
  int checkstat1 = 0;

  void _setLabel(String s) {
    if (s == null) {
      return;
    }
    setState(() => _label = s);
  }

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ResponsiveGridRow(children: [
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

                              //artifact1
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
//artifact2
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
//artifact3
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
//artifact4
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
                                                    value: 5),
                                                DropdownMenuItem(
                                                    child: Text(
                                                      "Hydro Damage%",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    value: 5),
                                                DropdownMenuItem(
                                                    child: Text(
                                                      "Cryo Damage%",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    value: 5),
                                                DropdownMenuItem(
                                                    child: Text(
                                                      "Electro Damage%",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    value: 5),
                                                DropdownMenuItem(
                                                    child: Text(
                                                      "Anemo Damage%",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    value: 5),
                                                DropdownMenuItem(
                                                    child: Text(
                                                      "Geo Damage%",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    value: 5),
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
//artifact5
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
                            ],
                          ),
                        )
                      ],
                    ),
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
                color: Colors.yellow[50],
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
