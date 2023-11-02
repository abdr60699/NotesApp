import 'package:flutter/material.dart';

class ReusableInput extends StatelessWidget {
  ReusableInput(
      {this.hintText,
      this.userInput,
      this.isValid,
      this.maxLength,
      this.labelText});

  final String? hintText;
  final TextEditingController? userInput;
  final String? isValid;
  final int? maxLength;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: TextField(
        maxLines: null,
        controller: userInput,
        decoration: InputDecoration(
          label: Text(
            labelText.toString(),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          errorText: isValid,
          hintText: hintText,
        ),
      ),
    );
  }
}
