import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/widget/forms/form_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Body Attributes ",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextSpan(
                text: "*",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: FormStyles.primaryBackgroundColor, borderRadius: BorderRadius.circular(10)),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${attribute.title}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text("${attribute.placeholder}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 65,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: attribute.isSmartUrlEnabled,
                                    builder: (context, _, child) {
                                      return TextFormField(
                                        controller: attribute.textController,
                                        decoration: FormStyles.buildInputDecoration(context, hintText: "Enter Text"),
                                        validator: (value) {
                                          if (attribute.selectedVariable.value == null) {
                                            if (attribute.isSmartUrlEnabled.value) {
                                              const urlPattern = r'^(https?:\/\/)([\w\-]+\.)+[a-zA-Z]{2,}(\/\S*)?$';
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
                                        },
                                      );
                                    },
                                  ),
                                ),
                                if (isSmartUrl) ...[
                                  const SizedBox(width: 8),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: attribute.isSmartUrlEnabled,
                                    builder: (context, isChecked, child) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Checkbox(
                                              value: isChecked,
                                              onChanged: (value) {
                                                attribute.isSmartUrlEnabled.value = value ?? false;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text("Smart URL", style: Theme.of(context).textTheme.bodySmall),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (widget.predefinedAttributes.isNotEmpty && widget.templateType != "AUTHENTICATION") ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(flex: 35, child: SizedBox.shrink()),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 65,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text("OR", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildDropdown(attribute),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
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
        return DropdownButtonFormField2<String>(
          items: widget.predefinedAttributes.keys.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            attribute.textController.text = "";
            attribute.selectedVariable.value = value;
            attribute.selectedVariableValue.value = widget.predefinedAttributes[value];
          },
          value: attribute.selectedVariable.value,
          decoration: FormStyles.buildInputDecoration(context, hintText: "Select Variable"),
          dropdownStyleData: FormStyles.buildDropdownStyleData(context),
          menuItemStyleData: FormStyles.buildMenuItemStyleData(context),
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
