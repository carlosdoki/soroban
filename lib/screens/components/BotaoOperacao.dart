import 'package:flutter/material.dart';
import 'package:sorobantraining/constants.dart';

class BotaoOperacao extends StatelessWidget {
  const BotaoOperacao({
    Key key,
    @required this.selectedOperator,
    this.onPressed,
    this.comparedOperator,
    this.iconData,
  }) : super(key: key);

  final Operator selectedOperator;
  final Function onPressed;
  final Operator comparedOperator;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(iconData),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: selectedOperator == comparedOperator
          ? kActiveCardColour
          : kInactiveCardColour,
    );
  }
}
