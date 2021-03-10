import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sorobantraining/model/stopwatch.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int firstNumber = 1;
  // int secondNumber = 1;

  // void randomNumber() {
  //   setState(() {
  //     firstNumber = Random().nextInt(100) + 1;
  //   });
  // }

  main() {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      print(rng.nextInt(100));
    }
  }

  double _currentSliderValue = 100;
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => main(),
                  child: Text(
                    '10',
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
                  '10',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            stopwatch(),
          ],
        ),
      ),
    );
  }
}
