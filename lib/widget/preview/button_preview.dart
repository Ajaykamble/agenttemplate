import 'package:agenttemplate/agenttemplate.dart';
import 'package:flutter/material.dart';

class ButtonPreviews extends StatefulWidget {
  final Component? buttonsComponent;
  const ButtonPreviews({super.key, required this.buttonsComponent});

  @override
  State<ButtonPreviews> createState() => _ButtonPreviewsState();
}

class _ButtonPreviewsState extends State<ButtonPreviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
