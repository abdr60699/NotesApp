import 'package:flutter/material.dart';

class Reusable_Button extends StatelessWidget {
  Reusable_Button({this.buttText, this.onPress});

  final String? buttText;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xffff2147)),
        onPressed: onPress,
        child: Text(buttText.toString()),
      ),
    );
  }
}

