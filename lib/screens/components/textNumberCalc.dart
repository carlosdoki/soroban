import 'package:flutter/material.dart';
import 'package:sorobantraining/constants.dart';

class TextNumberCalc extends StatelessWidget {
  const TextNumberCalc({
    Key key,
    @required this.txtNumber,
  }) : super(key: key);

  final String txtNumber;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        '$txtNumber',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: kActiveCardColour,
        ),
      ),
    );
  }
}
