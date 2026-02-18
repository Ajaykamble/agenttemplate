import 'package:agenttemplate/agenttemplate.dart';
import 'package:flutter/material.dart';

class ButtonsForm extends StatefulWidget {
  final Component buttonsComponent;
  final Color backgroundColor;
  final String templateType;
  const ButtonsForm({super.key, required this.buttonsComponent, required this.backgroundColor, required this.templateType});

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
                return Row(
                  children: [
                    Expanded(flex: 20, child: Text(otherButtons[index].text, style: Theme.of(context).textTheme.bodyMedium)),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 80,
                      child: TextFormField(
                        controller: otherButtons[index].buttonTextController,
                        decoration: InputDecoration(
                          hintText: "Enter Text",
                          enabled: widget.templateType == "AUTHENTICATION" ? false : true,

                          //
                        ),
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                Text("QUICK REPLY BUTTONS", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                //
                ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(flex: 20, child: Text(quickReplyButtonList[index].text, style: Theme.of(context).textTheme.bodyMedium)),

                        const SizedBox(width: 10),
                        Expanded(
                          flex: 80,
                          child: TextFormField(
                            controller: quickReplyButtonList[index].buttonTextController,
                            decoration: InputDecoration(hintText: "Enter Text"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        //
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: quickReplyButtonList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
