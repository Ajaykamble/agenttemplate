import 'package:flutter/material.dart';
import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:typeset/typeset.dart';

class BodyPreview extends StatefulWidget {
  final Component bodyComponent;
  const BodyPreview({super.key, required this.bodyComponent});

  @override
  State<BodyPreview> createState() => _BodyPreviewState();
}

class _BodyPreviewState extends State<BodyPreview> {
  late List<ValueNotifier<String?>> _notifiers;

  @override
  void initState() {
    super.initState();
    _notifiers = widget.bodyComponent.attributes.map((a) => a.selectedVariableValue).toList();
    for (final notifier in _notifiers) {
      notifier.addListener(_onChanged);
    }
  }

  @override
  void didUpdateWidget(covariant BodyPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bodyComponent != widget.bodyComponent) {
      for (final notifier in _notifiers) {
        notifier.removeListener(_onChanged);
      }
      _notifiers = widget.bodyComponent.attributes.map((a) => a.selectedVariableValue).toList();
      for (final notifier in _notifiers) {
        notifier.addListener(_onChanged);
      }
    }
  }

  @override
  void dispose() {
    for (final notifier in _notifiers) {
      notifier.removeListener(_onChanged);
    }
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  String _resolveText() {
    String text = widget.bodyComponent.text ?? "";
    for (int i = 0; i < widget.bodyComponent.attributes.length; i++) {
      final value = widget.bodyComponent.attributes[i].selectedVariableValue.value;
      if (value != null && value.isNotEmpty) {
        text = text.replaceAll('{{${i + 1}}}', value);
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return TypeSet(
      _resolveText(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }
}
