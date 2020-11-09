import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final Function onPressFunc;
  final String txt;
  GenericButton(this.txt, this.onPressFunc);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.purple,
      textColor: Colors.white,
      onPressed: () => onPressFunc(),
      child: Text(txt),
    );
  }
}
