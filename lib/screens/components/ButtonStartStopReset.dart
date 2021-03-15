import 'package:flutter/material.dart';

class ButtonStartStopReset extends StatelessWidget {
  const ButtonStartStopReset({
    Key key,
    this.texto,
    this.onTap,
    this.color,
  }) : super(key: key);

  final String texto;
  final Function onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: GestureDetector(
        // onTap: startispressed ? startstopwatch : null,
        // onTap: startstopwatch,
        onTap: onTap,
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            // color: Colors.green,
            color: color,
          ),
          child: Center(
            child: Text(
              // 'Start',
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
