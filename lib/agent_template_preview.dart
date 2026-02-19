import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:flutter/material.dart';

class AgentTemplatePreview extends StatefulWidget {
  final TemplateObj templateObj;
  const AgentTemplatePreview({super.key, required this.templateObj});

  @override
  State<AgentTemplatePreview> createState() => _AgentTemplatePreviewState();
}

class _AgentTemplatePreviewState extends State<AgentTemplatePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(height: 70, color: Colors.green),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(child: Column()),
                  Container(color: Colors.green.shade100, height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
