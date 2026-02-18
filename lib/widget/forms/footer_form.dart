import 'package:agenttemplate/agenttemplate.dart';
import 'package:flutter/material.dart';

class FooterForm extends StatefulWidget {
  final Component footerComponent;
  final Color backgroundColor;
  const FooterForm({super.key, required this.footerComponent, required this.backgroundColor});

  @override
  State<FooterForm> createState() => _FooterFormState();
}

class _FooterFormState extends State<FooterForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
