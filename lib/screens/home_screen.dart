import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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
  bool _contaVisible = false;
  bool _totalVisible = false;
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00.0000';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

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
      _total = firstNumber + secondNumber;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soroban Training'),
        backgroundColor: Colors.blue,
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
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Slider(
                value: _currentSliderValue.toDouble(),
                min: 1,
                max: 10,
                divisions: 100,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    String _numeroMax = '';
                    for (int i = 0; i < _currentSliderValue; i++) {
                      _numeroMax = _numeroMax + '9';
                    }
                    _digitos = int.parse(_numeroMax);
                    _currentSliderValue = value.round();
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
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
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '$secondNumber',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
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
                      color: Colors.blue,
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
          ],
        ),
      ),
    );
  }
}
