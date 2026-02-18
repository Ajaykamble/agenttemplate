import 'dart:developer';

import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/file_upload_response.dart';
import 'package:agenttemplate/models/flow_raw_info_response_model.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:agenttemplate/widget/forms/MPM_form.dart';
import 'package:agenttemplate/widget/forms/body_form.dart';
import 'package:agenttemplate/widget/forms/buttons_form.dart';
import 'package:agenttemplate/widget/forms/carousel_form.dart';
import 'package:agenttemplate/widget/forms/catalog_form.dart';
import 'package:agenttemplate/widget/forms/flow_form.dart';
import 'package:agenttemplate/widget/forms/footer_form.dart';
import 'package:agenttemplate/widget/forms/header_form.dart';
import 'package:agenttemplate/widget/forms/limited_time_offer_form.dart';
import 'package:collection/collection.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'agenttemplate.dart';
import 'widget/template_checkbox.dart';

class AgentTemplateForm extends StatefulWidget {
  final TemplateObj templateObj;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse> Function(XFile file)? onFileUpload;
  final Future<CatalogueResponseModel> Function() onGetCatalogue;
  final Future<FlowRawInfoResponse> Function(String flowId) onGetFlowRawInfo;
  final Future<DateTimeResponseModel> Function() onGetDateTime;
  final String templateType;
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
  }

  @override
  Widget build(BuildContext context) {
    Component? HEADER_COMPONENT = widget.templateObj.components.firstWhereOrNull((element) => element.type == 'HEADER');
    Component? BODY_COMPONENT = widget.templateObj.components.firstWhereOrNull((element) => element.type == 'BODY');
    Component? FOOTER_COMPONENT = widget.templateObj.components.firstWhereOrNull((element) => element.type == 'FOOTER');
    Component? BUTTONS_COMPONENT = widget.templateObj.components.firstWhereOrNull((element) => element.type == 'BUTTONS');
    Component? CAROUSEL_COMPONENT = widget.templateObj.components.firstWhereOrNull((element) => element.type == 'CAROUSEL');
    Component? limited_time_offer = widget.templateObj.components.firstWhereOrNull((element) => element.type == "limited_time_offer");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: widget.templateObj.showSmartUrlCheckBox,
          builder: (context, value, child) {
            return value
                ? Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: widget.templateObj.isSmartUrlEnabled,
                        builder: (context, value, child) {
                          return TemplateCheckbox(
                            text: "Smart URL Converstion",
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

        if (widget.templateType == "CATALOG" && BUTTONS_COMPONENT != null) ...[
          CatalogForm(
            component: BUTTONS_COMPONENT,
            //
          ),
          const SizedBox(height: 10),
        ],

        if (widget.templateType == "FLOW" && BUTTONS_COMPONENT != null) ...[FlowForm(component: BUTTONS_COMPONENT), const SizedBox(height: 10)],

        if (widget.templateType == "MPM" && BUTTONS_COMPONENT != null) ...[
          MPMForm(buttonsComponent: BUTTONS_COMPONENT, backgroundColor: widget.backgroundColor, templateType: widget.templateType),
          const SizedBox(height: 10),
        ],

        if (HEADER_COMPONENT != null) ...[
          HeaderForm(
            headerComponent: HEADER_COMPONENT,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            fileObject: widget.fileObject,
            onFileUpload: widget.onFileUpload,
          ),
          const SizedBox(height: 10),
        ],
        if (BODY_COMPONENT != null) ...[
          BodyForm(
            bodyComponent: BODY_COMPONENT,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            isSmartUrlEnabled: widget.templateObj.isSmartUrlEnabled,
            templateType: widget.templateType,
            onTextChanged: () {
              //
              widget.templateObj.onBodyTextChanged();
            },
          ),
          const SizedBox(height: 10),
        ],
        if (FOOTER_COMPONENT != null) ...[FooterForm(footerComponent: FOOTER_COMPONENT, backgroundColor: widget.backgroundColor), const SizedBox(height: 10)],
        if (BUTTONS_COMPONENT != null) ...[ButtonsForm(buttonsComponent: BUTTONS_COMPONENT, backgroundColor: widget.backgroundColor, templateType: widget.templateType), const SizedBox(height: 10)],
        if (CAROUSEL_COMPONENT != null) ...[
          CarouselForm(
            carouselComponent: CAROUSEL_COMPONENT,
            backgroundColor: widget.backgroundColor,
            predefinedAttributes: widget.predefinedAttributes,
            fileObject: widget.fileObject,
            onFileUpload: widget.onFileUpload,
            templateType: widget.templateType,
            isSmartUrlEnabled: widget.templateObj.isSmartUrlEnabled,
          ),
          const SizedBox(height: 10),
        ],
        if (limited_time_offer != null) ...[LimitedTimeOfferForm(limitedTimeOfferComponent: limited_time_offer, backgroundColor: widget.backgroundColor), const SizedBox(height: 10)],
      ],
    );
  }
}
