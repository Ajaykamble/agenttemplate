import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FooterPreview extends StatelessWidget {
  final Component? footerComponent;
  const FooterPreview({super.key, this.footerComponent});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey.shade600);
    return Row(
      children: [
        Expanded(
          child: footerComponent == null
              ? SizedBox.shrink()
              : Text(
                  footerComponent!.text ?? "",
                  style: style,
                ),
        ),
        Text(
          DateFormat("HH:mm").format(DateTime.now()),
          style: style,
        ),
      ],
    );
  }
}
