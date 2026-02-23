import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/l10n/app_localizations.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:agenttemplate/utils/app_enums.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:agenttemplate/widget/forms/body_form.dart';
import 'package:agenttemplate/widget/forms/buttons_form.dart';
import 'package:agenttemplate/widget/forms/carousel_form.dart';
import 'package:agenttemplate/widget/forms/catalog_form.dart';
import 'package:agenttemplate/widget/forms/flow_form.dart';
import 'package:agenttemplate/widget/forms/footer_form.dart';
import 'package:agenttemplate/widget/forms/header_form.dart';
import 'package:agenttemplate/widget/forms/limited_time_offer_form.dart';
import 'package:agenttemplate/widget/forms/mpm_form.dart';
import 'package:collection/collection.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'widget/template_checkbox.dart';

class AgentTemplateForm extends StatefulWidget {
  final TemplateObj templateObj;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse?> Function(XFile file)? onFileUpload;
  final Future<CatalogueResponseModel?> Function() onGetCatalogue;
  final Future<FlowRawInfoResponse?> Function(String flowId) onGetFlowRawInfo;
  final Future<DateTimeResponseModel?> Function() onGetDateTime;
  final String templateType;
  final String shortBaseUrl;
  final SendTemplateType sendTemplateType;
  const AgentTemplateForm({
    super.key,
    required this.templateObj,
    required this.backgroundColor,
    required this.predefinedAttributes,
    this.fileObject,
    this.onFileUpload,
    required this.onGetCatalogue,
    required this.onGetFlowRawInfo,
    required this.templateType,
    required this.onGetDateTime,
    required this.shortBaseUrl,
    required this.sendTemplateType,
  });

  @override
  State<AgentTemplateForm> createState() => _AgentTemplateFormState();
}

class _AgentTemplateFormState extends State<AgentTemplateForm> {
  late AgentTemplateProvider agentTemplateProvider;

  @override
  void initState() {
    super.initState();
    agentTemplateProvider = Provider.of<AgentTemplateProvider>(context, listen: false);
    agentTemplateProvider.onGetCatalogue = widget.onGetCatalogue;
    agentTemplateProvider.onGetFlowRawInfo = widget.onGetFlowRawInfo;
    agentTemplateProvider.onGetDateTime = widget.onGetDateTime;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      agentTemplateProvider.templateObj = widget.templateObj;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Component? headerComponent = widget.templateObj.components?.firstWhereOrNull((element) => element.type == 'HEADER');
    Component? bodyComponent = widget.templateObj.components?.firstWhereOrNull((element) => element.type == 'BODY');
    Component? footerComponent = widget.templateObj.components?.firstWhereOrNull((element) => element.type == 'FOOTER');
    Component? buttonsComponent = widget.templateObj.components?.firstWhereOrNull((element) => element.type == 'BUTTONS');
    Component? carouselComponent = widget.templateObj.components?.firstWhereOrNull((element) => element.type == 'CAROUSEL');
    Component? limitedTimeOffer = widget.templateObj.components?.firstWhereOrNull((element) => element.type == "limited_time_offer");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.sendTemplateType == SendTemplateType.normal)
          ValueListenableBuilder(
            valueListenable: widget.templateObj.showSmartUrlCheckBox,
            builder: (context, value, child) {
              return value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: widget.templateObj.isSmartUrlEnabled,
                          builder: (context, value, child) {
                            return TemplateCheckbox(
                              text: AppLocalizations.of(context)?.smartUrlConversion ?? "Smart URL Conversion",
                              defaultValue: value,
                              onChanged: (value) {
                                widget.templateObj.isSmartUrlEnabled.value = value;
                                widget.templateObj.resetSmartUrlAttributes();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : SizedBox.shrink();
            },
          ),

        if (widget.templateType == "CATALOG" && buttonsComponent != null) ...[
          CatalogForm(
            component: buttonsComponent,
            //
          ),
          const SizedBox(height: 10),
        ],

        if (buttonsComponent != null) ...[FlowForm(component: buttonsComponent), const SizedBox(height: 10)],

        if (widget.templateType == "MPM" && buttonsComponent != null) ...[
          MPMForm(buttonsComponent: buttonsComponent, backgroundColor: widget.backgroundColor, templateType: widget.templateType),
          const SizedBox(height: 10),
        ],

        if (headerComponent != null) ...[
          HeaderForm(
            headerComponent: headerComponent,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            fileObject: widget.fileObject,
            onFileUpload: widget.onFileUpload,
            sendTemplateType: widget.sendTemplateType,
            onProductSelected: () {
              //
              widget.templateObj.onProductSelected();
            },
          ),
          const SizedBox(height: 10),
        ],
        if (bodyComponent != null) ...[
          BodyForm(
            bodyComponent: bodyComponent,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            isSmartUrlEnabled: widget.templateObj.isSmartUrlEnabled,
            templateType: widget.templateType,
            onTextChanged: () {
              //
              widget.templateObj.onBodyTextChanged(widget.templateType);
            },
          ),
          const SizedBox(height: 10),
        ],
        if (footerComponent != null) ...[FooterForm(footerComponent: footerComponent, backgroundColor: widget.backgroundColor), const SizedBox(height: 10)],
        if (buttonsComponent != null) ...[
          ButtonsForm(buttonsComponent: buttonsComponent, backgroundColor: widget.backgroundColor, templateType: widget.templateType, shortBaseUrl: widget.shortBaseUrl),
          const SizedBox(height: 10)
        ],
        if (carouselComponent != null) ...[
          CarouselForm(
            carouselComponent: carouselComponent,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            fileObject: widget.fileObject,
            onFileUpload: widget.onFileUpload,
            templateType: widget.templateType,
            isSmartUrlEnabled: widget.templateObj.isSmartUrlEnabled,
            shortBaseUrl: widget.shortBaseUrl,
            sendTemplateType: widget.sendTemplateType,
          ),
          const SizedBox(height: 10),
        ],
        if (limitedTimeOffer != null) ...[LimitedTimeOfferForm(limitedTimeOfferComponent: limitedTimeOffer, backgroundColor: widget.backgroundColor), const SizedBox(height: 10)],
        //
        if (widget.sendTemplateType == SendTemplateType.normal) ...[
          Selector<AgentTemplateProvider, bool>(
            selector: (_, provider) => provider.retryAttemptFailed,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TemplateCheckbox(
                    text: AppLocalizations.of(context)?.retryAttemptFailedForTestTemplate ?? "Retry Attempt For Failed Template Test",
                    defaultValue: value,
                    onChanged: (value) {
                      agentTemplateProvider.retryAttemptFailed = value;
                    },
                  ),
                  if (value) ...[
                    Text(AppLocalizations.of(context)?.retryCount ?? "Retry Count", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: agentTemplateProvider.retryAttemptController,
                      decoration: FormStyles.buildInputDecoration(context, hintText: AppLocalizations.of(context)?.fieldRequired ?? "This field is required"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)?.fieldRequired ?? 'This field is required';
                        }
                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 10),
                  ],

                  //
                ],
              );
            },
            //
          ),
          _buildAdditionalInfoSection(),
        ]
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return FormField<void>(
      validator: (_) {
        for (final info in agentTemplateProvider.additionalDataList) {
          if (info.keyController.text.trim().isEmpty) {
            return ' ';
          }
        }
        return null;
      },
      builder: (FormFieldState<void> state) {
        final hasError = state.hasError;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: hasError ? Border.all(color: Theme.of(context).colorScheme.error, width: 2) : null,
              ),
              child: ExpansionTile(
                title: Text(AppLocalizations.of(context)?.additionalInformation ?? "Additional Information", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                tilePadding: EdgeInsets.zero,
                maintainState: true,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {
                          agentTemplateProvider.addAdditionalData();
                        },
                        child: Text("+ ${AppLocalizations.of(context)?.add ?? "ADD"}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Selector<AgentTemplateProvider, int>(
                    selector: (_, provider) => provider.additionalDataList.length,
                    builder: (context, _, __) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: agentTemplateProvider.additionalDataList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final info = agentTemplateProvider.additionalDataList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: info.keyController,
                                  decoration: FormStyles.buildInputDecoration(context, hintText: AppLocalizations.of(context)?.enterKey ?? "Enter Key"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)?.fieldRequired ?? 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: info.valueController,
                                  decoration: FormStyles.buildInputDecoration(context, hintText: AppLocalizations.of(context)?.enterValue ?? "Enter Value"),
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                onPressed: () {
                                  agentTemplateProvider.removeAdditionalData(index);
                                },
                                icon: const Icon(Icons.close, color: Colors.black, size: 20),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)?.fillAllFields ?? "Fill all the fields",
                  style: Theme.of(context).inputDecorationTheme.errorStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        );
      },
    );
  }
}
