import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // final String colors;
  final VoidCallback callbackAction;
  final String title;

  const CustomButton({Key key, this.callbackAction, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: MaterialButton(
        child: Text(title),
        onPressed: callbackAction,
        minWidth: 40,
      ),
    );
  }
}