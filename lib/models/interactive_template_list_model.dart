// To parse this JSON data, do
//
//     final interactiveTemplateListModel = interactiveTemplateListModelFromJson(jsonString);

import 'dart:convert';

import 'package:agenttemplate/models/flow_raw_info_response_model.dart';
import 'package:agenttemplate/models/template_obj_model.dart';

List<InteractiveTemplateListModel> interactiveTemplateListModelFromJson(String str) => List<InteractiveTemplateListModel>.from(json.decode(str).map((x) => InteractiveTemplateListModel.fromJson(x)));

String interactiveTemplateListModelToJson(List<InteractiveTemplateListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InteractiveTemplateListModel {
  int? customerInteractiveTemplateId;
  String? templateName;
  String? language;
  int? waAccountId;
  int? customerId;
  InteractiveParaseTemplate? template;
  int? status;
  String? templateRefId;
  String? fileObject;
  String? templateType;
  int? createdBy;
  int? updatedBy;
  DateTime? createdOn;
  DateTime? updatedOn;
  TemplateObj? templateObj;
  FlowRawInfoResponse? flowRawInfoResponse;

  TemplateObj toTemplateObj() {
    //
    TemplateObj obj = TemplateObj();
    //
    obj.name = templateName;
    obj.language = language;
    obj.id = customerInteractiveTemplateId?.toString();
    obj.status = (status ?? 0) == 1 ? "APPROVED" : "REJECTED";
    obj.parameterFormat = "POSITIONAL";
    List<Component> components = [];

    if (template?.headerObj != null) {
      Component headerComponent = Component(type: "HEADER", text: template?.headerObj?.text ?? "", format: template?.headerObj?.type ?? "");
      components.add(headerComponent);
    }

    if (template?.body != null) {
      Component bodyComponent = Component(type: "BODY", text: template?.body?.text ?? "");
      components.add(bodyComponent);
    }
    if (template?.button != null) {
      Component bodyComponent = Component(
        type: "BUTTON",
        buttons: template?.button
                ?.map(
                  (e) => TemplateButton(
                    type: e.type ?? "",
                    text: e.text ?? "",
                    url: e.url,
                    flowId: e.flowId,
                    navigateScreen: e.navigateScreen,
                    flowAction: e.flowAction,
                    ttlMinutes: "",
                    phoneNumber: "",
                    example: [],
                  ),
                )
                .toList() ??
            [],
      );
      components.add(bodyComponent);
    }

    if (template?.listObj != null) {
      Component listComponent = Component(type: "LIST", listObj: template?.listObj);
      components.add(listComponent);
    }
    if (template?.footerText != null) {
      Component footerComponent = Component(type: "FOOTER", text: template?.footerText ?? "");
      components.add(footerComponent);
    }

    obj.components = components;
    return obj;
  }

  InteractiveTemplateListModel({
    this.customerInteractiveTemplateId,
    this.templateName,
    this.language,
    this.waAccountId,
    this.customerId,
    this.template,
    this.status,
    this.templateRefId,
    this.fileObject,
    this.templateType,
    this.createdBy,
    this.updatedBy,
    this.createdOn,
    this.updatedOn,
  });

  factory InteractiveTemplateListModel.fromJson(Map<String, dynamic> json) {
    var obj = InteractiveTemplateListModel(
      customerInteractiveTemplateId: json["customerInteractiveTemplateId"],
      templateName: json["templateName"],
      language: json["language"],
      waAccountId: json["waAccountId"],
      customerId: json["customerId"],
      template: json["template"] != null ? interactiveParaseTemplateFromJson(json["template"]) : null,
      status: json["status"],
      templateRefId: json["templateRefId"],
      fileObject: json["fileObject"],
      templateType: json["templateType"],
      createdBy: json["createdBy"],
      updatedBy: json["updatedBy"],
      createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
      updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    );

    obj.templateObj = obj.toTemplateObj();

    Map<String, dynamic>? extraJson = obj.template?.extras;
    if (extraJson != null) {
      List<dynamic>? flowRawInfo = extraJson['flowRawInfo'];
      if (flowRawInfo != null) {
        //
        Map<String, dynamic> json = {
          "status": true,
          "rawInfo": jsonEncode({
            "version": "1.0.0",
            "screens": flowRawInfo,
          })
        };
        obj.flowRawInfoResponse = FlowRawInfoResponse.fromJson(json);
      }
    }

    return obj;
  }

  Map<String, dynamic> toJson() => {
        "customerInteractiveTemplateId": customerInteractiveTemplateId,
        "templateName": templateName,
        "language": language,
        "waAccountId": waAccountId,
        "customerId": customerId,
        "template": template?.toJson(),
        "status": status,
        "templateRefId": templateRefId,
        "fileObject": fileObject,
        "templateType": templateType,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdOn": createdOn?.toIso8601String(),
        "updatedOn": updatedOn?.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final interactiveParaseTemplate = interactiveParaseTemplateFromJson(jsonString);

InteractiveParaseTemplate interactiveParaseTemplateFromJson(String str) => InteractiveParaseTemplate.fromJson(json.decode(str));

String interactiveParaseTemplateToJson(InteractiveParaseTemplate data) => json.encode(data.toJson());

class InteractiveParaseTemplate {
  HeaderObj? headerObj;
  Body? body;
  List<Button>? button;
  ListObj? listObj;
  String? footerText;
  Map<String, dynamic>? extras;

  InteractiveParaseTemplate({
    this.headerObj,
    this.body,
    this.button,
    this.listObj,
    this.footerText,
    this.extras,
  });

  factory InteractiveParaseTemplate.fromJson(Map<String, dynamic> json) => InteractiveParaseTemplate(
        headerObj: json["headerObj"] == null ? null : HeaderObj.fromJson(json["headerObj"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        button: json["button"] == null ? [] : List<Button>.from(json["button"]!.map((x) => Button.fromJson(x))),
        listObj: json["listObj"] == null ? null : ListObj.fromJson(json["listObj"]),
        footerText: json["footerText"],
        extras: json["extras"],
      );

  Map<String, dynamic> toJson() => {
        "headerObj": headerObj?.toJson(),
        "body": body?.toJson(),
        "button": button == null ? [] : List<dynamic>.from(button!.map((x) => x.toJson())),
        "listObj": listObj?.toJson(),
        "footerText": footerText,
        "extras": extras,
      };
}

class Button {
  String? type;
  String? text;
  String? flowId;
  String? navigateScreen;
  String? flowAction;
  String? url;

  Button({
    this.type,
    this.text,
    this.flowId,
    this.navigateScreen,
    this.flowAction,
    this.url,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        type: json["type"],
        text: json["text"],
        flowId: json["flow_id"],
        navigateScreen: json["navigate_screen"],
        flowAction: json["flow_action"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "flow_id": flowId,
        "navigate_screen": navigateScreen,
        "flow_action": flowAction,
      };
}

class Body {
  String? type;
  String? text;

  Body({
    this.type,
    this.text,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        type: json["type"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
      };
}

class HeaderObj {
  String? type;
  String? text;
  String? link;
  String? mediaId;
  String? fileName;

  HeaderObj({
    this.type,
    this.text,
    this.link,
    this.mediaId,
    this.fileName,
  });

  factory HeaderObj.fromJson(Map<String, dynamic> json) => HeaderObj(
        type: json["type"],
        text: json["text"],
        link: json["link"],
        mediaId: json["media_id"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "link": link,
        "media_id": mediaId,
        "fileName": fileName,
      };
}
