import 'package:flutter/material.dart';

class TemplateCheckbox extends StatefulWidget {
  final String text;
  final bool defaultValue;
  final ValueChanged<bool>? onChanged;

  const TemplateCheckbox({super.key, required this.text, this.defaultValue = false, this.onChanged});

  @override
  State<TemplateCheckbox> createState() => _TemplateCheckboxState();
}

class _TemplateCheckboxState extends State<TemplateCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
            widget.onChanged?.call(_isChecked);
          },
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
              widget.onChanged?.call(_isChecked);
            },
            child: Text(widget.text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
