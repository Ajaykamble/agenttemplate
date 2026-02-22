import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/l10n/app_localizations.dart';
import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonPreviews extends StatefulWidget {
  final Component? buttonsComponent;
  final void Function(TemplateButton component)? onButtonTap;
  final void Function(Component buttonsComponent)? onAllButtonsTap;
  const ButtonPreviews({super.key, required this.buttonsComponent, this.onButtonTap, this.onAllButtonsTap});

  @override
  State<ButtonPreviews> createState() => _ButtonPreviewsState();
}

class _ButtonPreviewsState extends State<ButtonPreviews> {
  @override
  Widget build(BuildContext context) {
    List<TemplateButton> buttons = widget.buttonsComponent?.buttons ?? [];

    int totalButtons = widget.buttonsComponent?.buttons?.length ?? 0;

    if (buttons.length > 2) {
      buttons = buttons.sublist(0, 2);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              String buttonType = buttons[index].type;
              IconData icon = Icons.reply;
              switch (buttonType) {
                case "URL":
                  icon = Icons.link;
                  break;
                case "PHONE_NUMBER":
                  icon = Icons.phone;
                  break;
                case "COPY_CODE":
                  icon = Icons.copy;
                  break;
              }

              return _ButtonWidget(
                title: buttons[index].text,
                icon: icon,
                onTap: () {
                  switch (buttonType) {
                    case "MPM":
                    case "SPM":
                    case "CATALOG":
                      widget.onButtonTap?.call(buttons[index]);
                      break;
                  }
                },
              );
            },
            itemCount: buttons.length,
          ),
          if (totalButtons > 2) ...[
            const SizedBox(height: 5),
            _ButtonWidget(
              title: AppLocalizations.of(context)?.seeAllOptions ?? "See all options",
              icon: CupertinoIcons.list_bullet,
              onTap: () {
                widget.onAllButtonsTap?.call(widget.buttonsComponent!);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const _ButtonWidget({super.key, required this.title, required this.icon, this.onTap});

  final Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: buttonColor,
              size: 20,
            ),
            const SizedBox(width: 3),
            Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: buttonColor, fontWeight: FontWeight.w600)),
            //
          ],
        ),
      ),
    );
  }
}
