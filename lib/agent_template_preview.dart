import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/utils/app_assets.dart';
import 'package:agenttemplate/utils/app_enums.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:agenttemplate/widget/preview/button_preview.dart';
import 'package:agenttemplate/widget/preview/card_preview.dart';
import 'package:agenttemplate/widget/preview/card_preview_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentTemplatePreview extends StatefulWidget {
  final String accountName;
  final String accountImage;
  final String accountPhone;
  final bool accountIsVerified;
  final TemplateObj templateObj;
  final void Function(TemplateButton button)? onButtonTap;
  final void Function(Component buttonsComponent)? onAllButtonsTap;
  final void Function(ListObj listObj)? onListTap;
  final VoidCallback onBackPressed;
  final SendTemplateType sendTemplateType;
  const AgentTemplatePreview({
    super.key,
    required this.templateObj,
    required this.accountName,
    required this.accountImage,
    required this.accountPhone,
    required this.accountIsVerified,
    required this.sendTemplateType,
    this.onButtonTap,
    this.onAllButtonsTap,
    this.onListTap,
    required this.onBackPressed,
  });

  @override
  State<AgentTemplatePreview> createState() => _AgentTemplatePreviewState();
}

class _AgentTemplatePreviewState extends State<AgentTemplatePreview> {
  Widget _buildAccountInfo() {
    return Container(
      height: kToolbarHeight,
      color: FormStyles.whatsappGreen,
      child: Row(
        children: [
          BackButton(
            onPressed: widget.onBackPressed,
            color: Colors.white,
            style: ButtonStyle(
              iconSize: WidgetStateProperty.all(24),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              minimumSize: WidgetStateProperty.all(const Size(40, 40)),
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            backgroundImage: widget.accountImage.isNotEmpty ? NetworkImage(widget.accountImage) : null,
            child: widget.accountImage.isEmpty ? Icon(Icons.person, color: FormStyles.whatsappGreen, size: 28) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.accountName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.accountIsVerified) ...[
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppAssets.verificationBadge,
                        package: AppAssets.packageName,
                        width: 20,
                        height: 20,
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.accountPhone,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _buildAccountInfo(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        AppAssets.backgroundImage,
                        package: AppAssets.packageName,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            //shrinkWrap: true,
                            child: CardPreview(
                              templateObj: widget.templateObj,
                              accountName: widget.accountName,
                              onButtonTap: widget.onButtonTap,
                              onAllButtonsTap: widget.onAllButtonsTap,
                              onListTap: widget.onListTap,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SvgPicture.asset(
                                AppAssets.wFooter,
                                package: AppAssets.packageName,
                                fit: BoxFit.contain,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
