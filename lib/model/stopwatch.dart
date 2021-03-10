import 'dart:async';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class stopwatch extends StatefulWidget {
  @override
  _stopwatchState createState() => _stopwatchState();
}

// ignore: camel_case_types
class _stopwatchState extends State<stopwatch> {
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

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
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      stopispressed = false;
      startispressed = false;
    });

    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      startispressed = true;
      resetispressed = true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              stoptimetodisplay,
              style: TextStyle(
                fontSize: 70,
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
                    onTap: startispressed ? startstopwatch : null,
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
    );
  }
}
