import 'package:flutter/material.dart';

class AdditionalDataModel {
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  Map<String, dynamic> toJson() => {
        'key': keyController.text.trim(),
        'value': valueController.text.trim(),
        'type': 'static',
      };
}
