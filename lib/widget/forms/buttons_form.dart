import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/widget/forms/form_styles.dart';
import 'package:flutter/material.dart';

class ButtonsForm extends StatefulWidget {
  final Component buttonsComponent;
  final Color backgroundColor;
  final String templateType;
  final String shortBaseUrl;
  const ButtonsForm({super.key, required this.buttonsComponent, required this.backgroundColor, required this.templateType, required this.shortBaseUrl});

  @override
  State<ButtonsForm> createState() => _ButtonsFormState();
}

class _ButtonsFormState extends State<ButtonsForm> {
  @override
  Widget build(BuildContext context) {
    //

    List<TemplateButton> quickReplyButtonList = (widget.buttonsComponent.buttons ?? []).where((button) => button.type == "QUICK_REPLY").toList();

    List<TemplateButton> otherButtons = (widget.buttonsComponent.buttons ?? []).where((button) => button.type != "QUICK_REPLY" && (button.example ?? []).isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //
        if (otherButtons.isNotEmpty) ...[
          //
          Text("Call To Action Configuration", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          //
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 35,
                          child: Text(otherButtons[index].text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 65,
                          child: TextFormField(
                            controller: otherButtons[index].buttonTextController,
                            decoration: FormStyles.buildInputDecoration(context, hintText: "Enter Text"),
                            enabled: widget.templateType == "AUTHENTICATION" ? false : true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    if (otherButtons[index].type == "URL" && (otherButtons[index].url ?? "").startsWith(widget.shortBaseUrl)) ...[
                      const SizedBox(height: 8),
                      Text(
                        "Note:During template creation, the URL is configured as a ShortURL.If you want to send parameters, you can use either:The URL, or The short link generated code",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFFE91E63), fontSize: 11), // Red/Pinkish color
                      ),
                    ],
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: otherButtons.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],

        // QUICK REPLY BUTTONS
        if (quickReplyButtonList.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text("Quick to Reply Payload", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                tilePadding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 35,
                            child: Text(quickReplyButtonList[index].text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 65,
                            child: TextFormField(
                              controller: quickReplyButtonList[index].buttonTextController,
                              decoration: FormStyles.buildInputDecoration(context, hintText: "Enter Text"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: quickReplyButtonList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
