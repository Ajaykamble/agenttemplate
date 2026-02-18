import 'package:agenttemplate/agenttemplate.dart';
import 'package:flutter/material.dart';

class BodyForm extends StatefulWidget {
  final Component bodyComponent;
  final Color backgroundColor;
  final ValueNotifier<bool> isSmartUrlEnabled;
  final String templateType;
  final Map<String, dynamic> predefinedAttributes;
  final VoidCallback onTextChanged;
  const BodyForm({
    super.key,
    required this.bodyComponent,
    required this.backgroundColor,
    required this.isSmartUrlEnabled,
    required this.predefinedAttributes,
    required this.templateType,
    required this.onTextChanged,
  });

  @override
  State<BodyForm> createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  @override
  Widget build(BuildContext context) {
    if (widget.bodyComponent.attributes.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("BODY ATTRIBUTES", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: ListView.separated(
            itemBuilder: (context, index) {
              AttributeClass attribute = widget.bodyComponent.attributes[index];
              return ValueListenableBuilder<bool>(
                valueListenable: widget.isSmartUrlEnabled,
                builder: (context, isSmartUrl, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(attribute.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Expanded(flex: 40, child: Text(attribute.placeholder, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: attribute.isSmartUrlEnabled,
                              builder: (context, _, child) {
                                return TextFormField(
                                  controller: attribute.textController,
                                  decoration: InputDecoration(hintText: "Enter Text"),
                                  validator: (value) {
                                    if (attribute.selectedVariable.value == null) {
                                      if (attribute.isSmartUrlEnabled.value) {
                                        final urlPattern = r'^(https?:\/\/)([\w\-]+\.)+[a-zA-Z]{2,}(\/\S*)?$';
                                        final regExp = RegExp(urlPattern);

                                        if (value != null && value.isNotEmpty && !regExp.hasMatch(value)) {
                                          return 'Enter a valid URL (must start with http or https)';
                                        }
                                      }
                                      if (value == null || value.isEmpty) {
                                        return 'This field is required';
                                      }
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    attribute.selectedVariable.value = null;

                                    if (value.isNotEmpty) {
                                      attribute.selectedVariableValue.value = value;
                                    } else {
                                      attribute.selectedVariableValue.value = "";
                                    }
                                    widget.onTextChanged();
                                    //
                                  },
                                );
                              },
                            ),
                          ),
                          // When isSmartUrlEnabled: show checkbox next to text field
                          if (isSmartUrl) ...[
                            const SizedBox(width: 10),
                            ValueListenableBuilder<bool>(
                              valueListenable: attribute.isSmartUrlEnabled,
                              builder: (context, isChecked, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        attribute.isSmartUrlEnabled.value = value ?? false;
                                      },
                                    ),
                                    Text("Smart URL", style: Theme.of(context).textTheme.bodyMedium),
                                  ],
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                      if (widget.predefinedAttributes.isNotEmpty && widget.templateType != "AUTHENTICATION") ...[
                        const SizedBox(height: 8),
                        //
                        Center(child: Text("OR", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),

                        _buildDropdown(attribute),
                        //
                      ],
                    ],
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: widget.bodyComponent.attributes.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(AttributeClass attribute) {
    return ValueListenableBuilder<String?>(
      valueListenable: attribute.selectedVariable,
      builder: (context, _, child) {
        return DropdownButtonFormField<String>(
          items: widget.predefinedAttributes.keys.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            attribute.textController.text = "";
            attribute.selectedVariable.value = value;
            attribute.selectedVariableValue.value = widget.predefinedAttributes[value];
          },
          value: attribute.selectedVariable.value,
          decoration: InputDecoration(hintText: "Select Variable"),
          validator: (value) {
            if (attribute.selectedVariableValue.value?.isEmpty ?? true) {
              return 'This field is required';
            }
            return null;
          },
        );
      },
    );
  }
}
