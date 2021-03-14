import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sorobantraining/constants.dart';

enum Operator {
  plus,
  minus,
  multiply,
  divide,
}

const String testDevice = 'Mobile_id';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int firstNumber;
  int secondNumber;
  int _digitos = 9;
  int _total = 0;
  int _currentSliderValue = 1;
  String _operator = '+';
  Operator selectedOperator;
  bool _contaVisible = false;
  bool _totalVisible = false;
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00.0000';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-1468309003365349/9022459180"
            : "ca-app-pub-1468309003365349/3234343247",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
          "." +
          swatch.elapsed.inMilliseconds.toString().padLeft(3, "0");
    });
  }

  void startstopwatch() {
    resetstopwatch();
    setState(() {
      stopispressed = false;
      startispressed = false;
      _contaVisible = true;
      _totalVisible = false;
    });

    swatch.start();
    starttimer();
    randomNumber();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
      _totalVisible = true;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      startispressed = true;
      resetispressed = true;
      _contaVisible = false;
      _totalVisible = false;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00.0000";
  }

  void randomNumber() {
    setState(() {
      firstNumber = Random().nextInt(_digitos);
      secondNumber = Random().nextInt(_digitos);

      if ((secondNumber > firstNumber) &&
          (selectedOperator == Operator.minus ||
              selectedOperator == Operator.divide)) {
        int _temp = secondNumber;
        secondNumber = firstNumber;
        firstNumber = _temp;
      }

      switch (selectedOperator) {
        case Operator.plus:
          {
            _total = firstNumber + secondNumber;
            break;
          }
        case Operator.minus:
          {
            _total = firstNumber - secondNumber;
            break;
          }
        case Operator.multiply:
          {
            _total = firstNumber * secondNumber;
            break;
          }
        case Operator.divide:
          {
            _total = (firstNumber / secondNumber).round();
            break;
          }
      }
    });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(
      appId: Platform.isAndroid
          ? "ca-app-pub-1468309003365349~3961704194"
          : "ca-app-pub-1468309003365349~7313296855",
    );
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    selectedOperator = Operator.plus;
    super.initState();
    randomNumber();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soroban Training'),
        backgroundColor: kActiveCardColour,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Número de Digitos: $_currentSliderValue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kActiveCardColour,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Slider(
                value: _currentSliderValue.toDouble(),
                min: 1,
                max: 10,
                divisions: 10,
                activeColor: kActiveCardColour,
                inactiveColor: kInactiveCardColour,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    String _numeroMax = '';
                    for (int i = 0; i < value; i++) {
                      _numeroMax = _numeroMax + '9';
                    }
                    _digitos = int.parse(_numeroMax);
                    _currentSliderValue = value.round();
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RawMaterialButton(
                      elevation: 0.0,
                      child: Icon(FontAwesomeIcons.plus),
                      onPressed: (startispressed)
                          ? () {
                              setState(() {
                                selectedOperator = Operator.plus;
                                _operator = '+';
                              });
                            }
                          : null,
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: selectedOperator == Operator.plus
                          ? kActiveCardColour
                          : kInactiveCardColour,
                    ),
                    RawMaterialButton(
                      elevation: 0.0,
                      child: Icon(FontAwesomeIcons.minus),
                      onPressed: (startispressed)
                          ? () {
                              setState(() {
                                selectedOperator = Operator.minus;
                                _operator = '-';
                              });
                            }
                          : null,
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: selectedOperator == Operator.minus
                          ? kActiveCardColour
                          : kInactiveCardColour,
                    ),
                    RawMaterialButton(
                      elevation: 0.0,
                      child: Icon(FontAwesomeIcons.times),
                      onPressed: (startispressed)
                          ? () {
                              setState(() {
                                selectedOperator = Operator.multiply;
                                _operator = 'x';
                              });
                            }
                          : null,
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: selectedOperator == Operator.multiply
                          ? kActiveCardColour
                          : kInactiveCardColour,
                    ),
                    RawMaterialButton(
                      elevation: 0.0,
                      child: Icon(FontAwesomeIcons.divide),
                      onPressed: (startispressed)
                          ? () {
                              setState(() {
                                selectedOperator = Operator.divide;
                                _operator = '/';
                              });
                            }
                          : null,
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: selectedOperator == Operator.divide
                          ? kActiveCardColour
                          : kInactiveCardColour,
                    ),
                  ],
                ),
              ),
            ),
            _contaVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => randomNumber(),
                        child: Text(
                          '$firstNumber',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: kActiveCardColour,
                          ),
                        ),
                      ),
                      Text(
                        '$_operator',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: kActiveCardColour,
                        ),
                      ),
                      Text(
                        '$secondNumber',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: kActiveCardColour,
                        ),
                      ),
                    ],
                  )
                : Container(),
            _totalVisible
                ? Text(
                    ' = $_total',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: kActiveCardColour,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      stoptimetodisplay,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: kActiveCardColour,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: GestureDetector(
                            // onTap: startispressed ? startstopwatch : null,
                            onTap: startstopwatch,
                            child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  'Start',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: GestureDetector(
                            onTap: stopispressed ? null : stopstopwatch,
                            child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  'Stop',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: GestureDetector(
                            onTap: resetispressed ? null : resetstopwatch,
                            child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.cyan,
                              ),
                              child: Center(
                                child: Text(
                                  'Reset',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
