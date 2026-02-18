import 'package:flutter/material.dart';

/// A reusable alert dialog with a title, subtitle, and an "OK" button.
///
/// Use [showCommonAlertDialog] to display it conveniently.
class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;

  const CommonAlertDialog({super.key, required this.title, required this.subtitle, this.buttonText = 'OK'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      content: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87)),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(buttonText))],
    );
  }
}

/// Shows a [CommonAlertDialog] with the given [title], [subtitle], and
/// optional [buttonText] (defaults to "OK").
Future<void> showCommonAlertDialog(BuildContext context, {required String title, required String subtitle, String buttonText = 'OK'}) {
  return showDialog<void>(
    context: context,
    builder: (context) => CommonAlertDialog(title: title, subtitle: subtitle, buttonText: buttonText),
  );
}
