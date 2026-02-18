// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'dart:developer';

import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/file_object_model.dart';
import 'package:agenttemplate/models/flow_raw_info_response_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Sentinel value used in [copyWith] to distinguish between
/// "not passed" and "explicitly set to null".
const Object _undefined = _Undefined();

class _Undefined {
  const _Undefined();
}

class AdditionalInfo {
  final TextEditingController keyController;
  final TextEditingController valueController;

  AdditionalInfo({String key = "", String value = ""}) : keyController = TextEditingController(text: key), valueController = TextEditingController(text: value);

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

// ---------------------------------------------------------------------------
// LimitedTimeOffer
// ---------------------------------------------------------------------------

/// Represents a limited-time offer attached to a component.
class LimitedTimeOffer {
  final String text;
  final bool hasExpiration;

  const LimitedTimeOffer({required this.text, required this.hasExpiration});

  factory LimitedTimeOffer.fromJson(Map<String, dynamic> json) {
    return LimitedTimeOffer(text: json['text'] as String, hasExpiration: json['has_expiration'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'has_expiration': hasExpiration};
  }

  LimitedTimeOffer copyWith({String? text, bool? hasExpiration}) {
    return LimitedTimeOffer(text: text ?? this.text, hasExpiration: hasExpiration ?? this.hasExpiration);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LimitedTimeOffer && other.text == text && other.hasExpiration == hasExpiration;
  }

  @override
  int get hashCode => Object.hash(text, hasExpiration);

  @override
  String toString() => 'LimitedTimeOffer(text: $text, hasExpiration: $hasExpiration)';
}

// ---------------------------------------------------------------------------
// ComponentExample
// ---------------------------------------------------------------------------

/// Example data that can appear on BODY or HEADER components.
class ComponentExample {
  final List<List<String>>? bodyText;
  final List<String>? headerHandle;
  final List<String>? headerText;

  const ComponentExample({this.bodyText, this.headerHandle, this.headerText});

  factory ComponentExample.fromJson(Map<String, dynamic> json) {
    return ComponentExample(
      bodyText: json['body_text'] != null ? (json['body_text'] as List<dynamic>).map((e) => (e as List<dynamic>).map((s) => s as String).toList()).toList() : null,
      headerHandle: json['header_handle'] != null ? (json['header_handle'] as List<dynamic>).map((e) => e as String).toList() : null,
      headerText: json['header_text'] != null ? (json['header_text'] as List<dynamic>).map((e) => e as String).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (bodyText != null) {
      data['body_text'] = bodyText;
    }
    if (headerHandle != null) {
      data['header_handle'] = headerHandle;
    }
    if (headerText != null) {
      data['header_text'] = headerText;
    }
    return data;
  }

  ComponentExample copyWith({Object? bodyText = _undefined, Object? headerHandle = _undefined, Object? headerText = _undefined}) {
    return ComponentExample(
      bodyText: bodyText == _undefined ? this.bodyText : bodyText as List<List<String>>?,
      headerHandle: headerHandle == _undefined ? this.headerHandle : headerHandle as List<String>?,
      headerText: headerText == _undefined ? this.headerText : headerText as List<String>?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ComponentExample) return false;
    return _deepListEquals(bodyText, other.bodyText) && _listEquals(headerHandle, other.headerHandle) && _listEquals(headerText, other.headerText);
  }

  @override
  int get hashCode => Object.hash(
    bodyText != null ? Object.hashAll(bodyText!.map(Object.hashAll)) : null,
    headerHandle != null ? Object.hashAll(headerHandle!) : null,
    headerText != null ? Object.hashAll(headerText!) : null,
  );

  @override
  String toString() => 'ComponentExample(bodyText: $bodyText, headerHandle: $headerHandle, headerText: $headerText)';
}

class MPMAttributes {
  //
  TextEditingController categoryController = TextEditingController();
  ValueNotifier<List<ProductDetailsDatum>> selectedProductsNotifier = ValueNotifier<List<ProductDetailsDatum>>([]);
}
// ---------------------------------------------------------------------------
// TemplateButton
// ---------------------------------------------------------------------------

/// A button inside a BUTTONS component.
///
/// The [type] determines which optional fields are populated:
/// - `QUICK_REPLY` : [text] only
/// - `URL`         : [text], [url], optional [example]
/// - `PHONE_NUMBER`: [text], [phoneNumber]
/// - `COPY_CODE`   : [text], [example]
/// - `VOICE_CALL`  : [text], [ttlMinutes]
/// - `FLOW`        : [text], [flowId], [flowAction], [navigateScreen]
/// - `SPM`         : [text] only
/// - `CATALOG`     : [text] only
class TemplateButton {
  final String type;
  final String text;
  final String? url;
  final String? phoneNumber;
  final List<String>? example;
  final String? flowId;
  final String? flowAction;
  final String? navigateScreen;
  final String? ttlMinutes;

  FlowRawScreen? flowRawScreenData;
  ValueNotifier<ProductDetailsDatum?> selectedProduct = ValueNotifier<ProductDetailsDatum?>(null);

  TextEditingController buttonTextController = TextEditingController();

  List<MPMAttributes> mpmAttributes = [MPMAttributes()];
  ValueNotifier<int> mpmAttributesNotifier = ValueNotifier<int>(1);

  void addMPMAttributes() {
    mpmAttributes.add(MPMAttributes());
    log("mpmAttributes: ${mpmAttributes.length}");
    mpmAttributesNotifier.value = mpmAttributes.length;
  }

  void removeMPMAttributes(int index) {
    if (mpmAttributes.length > 1) {
      mpmAttributes.removeAt(index);
      mpmAttributesNotifier.value = mpmAttributes.length;
    }
  }

  TemplateButton({required this.type, required this.text, this.url, this.phoneNumber, this.example, this.flowId, this.flowAction, this.navigateScreen, this.ttlMinutes});
  factory TemplateButton.fromJson(Map<String, dynamic> json) {
    return TemplateButton(
      type: json['type'] as String,
      text: json['text'] as String,
      url: json['url'] as String?,
      phoneNumber: json['phone_number'] as String?,
      example: json['example'] != null ? (json['example'] as List<dynamic>).map((e) => e as String).toList() : null,
      flowId: json['flow_id'] as String?,
      flowAction: json['flow_action'] as String?,
      navigateScreen: json['navigate_screen'] as String?,
      ttlMinutes: json['ttl_minutes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'type': type, 'text': text};
    if (url != null) data['url'] = url;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (example != null) data['example'] = example;
    if (flowId != null) data['flow_id'] = flowId;
    if (flowAction != null) data['flow_action'] = flowAction;
    if (navigateScreen != null) data['navigate_screen'] = navigateScreen;
    if (ttlMinutes != null) data['ttl_minutes'] = ttlMinutes;
    return data;
  }

  TemplateButton copyWith({
    String? type,
    String? text,
    Object? url = _undefined,
    Object? phoneNumber = _undefined,
    Object? example = _undefined,
    Object? flowId = _undefined,
    Object? flowAction = _undefined,
    Object? navigateScreen = _undefined,
    Object? ttlMinutes = _undefined,
  }) {
    return TemplateButton(
      type: type ?? this.type,
      text: text ?? this.text,
      url: url == _undefined ? this.url : url as String?,
      phoneNumber: phoneNumber == _undefined ? this.phoneNumber : phoneNumber as String?,
      example: example == _undefined ? this.example : example as List<String>?,
      flowId: flowId == _undefined ? this.flowId : flowId as String?,
      flowAction: flowAction == _undefined ? this.flowAction : flowAction as String?,
      navigateScreen: navigateScreen == _undefined ? this.navigateScreen : navigateScreen as String?,
      ttlMinutes: ttlMinutes == _undefined ? this.ttlMinutes : ttlMinutes as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TemplateButton) return false;
    return other.type == type &&
        other.text == text &&
        other.url == url &&
        other.phoneNumber == phoneNumber &&
        _listEquals(example, other.example) &&
        other.flowId == flowId &&
        other.flowAction == flowAction &&
        other.navigateScreen == navigateScreen &&
        other.ttlMinutes == ttlMinutes;
  }

  @override
  int get hashCode => Object.hash(type, text, url, phoneNumber, example != null ? Object.hashAll(example!) : null, flowId, flowAction, navigateScreen, ttlMinutes);

  @override
  String toString() =>
      'TemplateButton(type: $type, text: $text, url: $url, phoneNumber: $phoneNumber, '
      'example: $example, flowId: $flowId, flowAction: $flowAction, '
      'navigateScreen: $navigateScreen, ttlMinutes: $ttlMinutes)';
}

// ---------------------------------------------------------------------------
// CarouselCard
// ---------------------------------------------------------------------------

/// A single card inside a CAROUSEL component.
class CarouselCard {
  final bool isAddedExternally;
  final List<Component> components;

  const CarouselCard({required this.components, this.isAddedExternally = false});

  factory CarouselCard.fromJson(Map<String, dynamic> json, {bool isAddedExternally = false}) {
    return CarouselCard(components: (json['components'] as List<dynamic>).map((e) => Component.fromJson(e as Map<String, dynamic>)).toList(), isAddedExternally: isAddedExternally);
  }

  Map<String, dynamic> toJson() {
    return {'components': components.map((e) => e.toJson()).toList()};
  }

  CarouselCard copyWith({List<Component>? components}) {
    return CarouselCard(components: components ?? this.components);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CarouselCard) return false;
    return _listEquals(components, other.components);
  }

  @override
  int get hashCode => Object.hashAll(components);

  @override
  String toString() => 'CarouselCard(components: $components)';
}

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

/// A single component inside a template.
///
/// The [type] determines which optional fields are populated:
/// - `BODY`               : [text], optional [example], optional [addSecurityRecommendation]
/// - `HEADER`             : optional [text], [format], optional [example]
/// - `FOOTER`             : [text], optional [codeExpirationMinutes]
/// - `BUTTONS`            : [buttons]
/// - `CAROUSEL`           : [cards]
/// - `limited_time_offer` : [limitedTimeOffer]
///
class AttributeClass {
  String placeholder;
  String title;
  AttributeClass({required this.title, required this.placeholder}) {
    selectedVariableValue = ValueNotifier<String?>(placeholder);
  }
  TextEditingController textController = TextEditingController();
  ValueNotifier<String?> selectedVariable = ValueNotifier<String?>(null);
  ValueNotifier<String?> selectedVariableValue = ValueNotifier<String?>(null);
  ValueNotifier<bool> isSmartUrlEnabled = ValueNotifier<bool>(false);
}

class Component {
  final String type;
  final String? text;
  final String? format;
  final ComponentExample? example;
  final bool? addSecurityRecommendation;
  final List<TemplateButton>? buttons;
  final List<CarouselCard>? cards;
  final LimitedTimeOffer? limitedTimeOffer;
  final int? codeExpirationMinutes;

  ValueNotifier<FileObject?> selectedFileObject = ValueNotifier<FileObject?>(null);

  List<AttributeClass> attributes = [];

  // Location header controllers
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();

  ValueNotifier<ProductDetailsDatum?> selectedProduct = ValueNotifier<ProductDetailsDatum?>(null);

  TextEditingController headerFileNameController = TextEditingController();
  TextEditingController headerFileUrlController = TextEditingController();

  // Limited time offer expiry
  TextEditingController offerExpiryDateController = TextEditingController();
  ValueNotifier<DateTime?> selectedOfferExpiryDateTime = ValueNotifier<DateTime?>(null);

  void setFileObject(FileObject? object) {
    selectedFileObject.value = null;
    selectedFileObject.value = object?.copyWith();

    headerFileNameController.text = object?.fileName ?? '';
    headerFileUrlController.text = object?.filePath ?? '';
  }

  void onManualSetFileUrl(String url) {
    headerFileNameController.text = "";
    selectedFileObject.value = null;
    selectedFileObject.value = FileObject(filePath: url, fileName: "");
  }

  Component({required this.type, this.text, this.format, this.example, this.addSecurityRecommendation, this.buttons, this.cards, this.limitedTimeOffer, this.codeExpirationMinutes});

  factory Component.fromJson(Map<String, dynamic> json) {
    //
    Component component = Component(
      type: json['type'] as String,
      text: json['text'] as String?,
      format: json['format'] as String?,
      example: json['example'] != null ? ComponentExample.fromJson(json['example'] as Map<String, dynamic>) : null,
      addSecurityRecommendation: json['add_security_recommendation'] as bool?,
      buttons: json['buttons'] != null ? (json['buttons'] as List<dynamic>).map((e) => TemplateButton.fromJson(e as Map<String, dynamic>)).toList() : null,
      cards: json['cards'] != null ? (json['cards'] as List<dynamic>).map((e) => CarouselCard.fromJson(e as Map<String, dynamic>)).toList() : null,
      limitedTimeOffer: json['limited_time_offer'] != null ? LimitedTimeOffer.fromJson(json['limited_time_offer'] as Map<String, dynamic>) : null,
      codeExpirationMinutes: json['code_expiration_minutes'] as int?,
    );
    RegExp positionalParamRegExp = RegExp(r'\{\{\s*(\d+)\s*\}\}');

    if (component.type == 'HEADER' && component.format == "TEXT") {
      //
      String text = component.text ?? '';
      // To extract all positional params in the text
      final matches = positionalParamRegExp.allMatches(text).toList();
      for (int i = 0; i < matches.length; i++) {
        //
        Match match = matches[i];
        String paramNumber = match.group(1)!;
        //
        String title = '';
        if (component.example?.headerText != null && component.example!.headerText!.length > i) {
          title = component.example!.headerText![i];
        }
        component.attributes.add(AttributeClass(title: '{{$paramNumber}}', placeholder: title));
      }
    }
    if (component.type == 'BODY') {
      //
      String text = component.text ?? '';
      final matches = positionalParamRegExp.allMatches(text).toList();
      for (int i = 0; i < matches.length; i++) {
        //
        Match match = matches[i];
        String paramNumber = match.group(1)!;
        //
        String title = '';
        if (component.example?.bodyText != null && component.example!.bodyText!.isNotEmpty && component.example!.bodyText![0].length > i) {
          title = component.example!.bodyText![0][i];
        }
        component.attributes.add(AttributeClass(title: '{{$paramNumber}}', placeholder: title));
      }
    }

    if (component.type == 'BUTTONS') {
      int index = 1;
      for (TemplateButton button in component.buttons ?? []) {
        if (button.type == "QUICK_REPLY") {
          button.buttonTextController = TextEditingController(text: "$index");
          index++;
        }
      }
    }

    return component;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'type': type};
    if (text != null) data['text'] = text;
    if (format != null) data['format'] = format;
    if (example != null) data['example'] = example!.toJson();
    if (addSecurityRecommendation != null) {
      data['add_security_recommendation'] = addSecurityRecommendation;
    }
    if (buttons != null) {
      data['buttons'] = buttons!.map((e) => e.toJson()).toList();
    }
    if (cards != null) {
      data['cards'] = cards!.map((e) => e.toJson()).toList();
    }
    if (limitedTimeOffer != null) {
      data['limited_time_offer'] = limitedTimeOffer!.toJson();
    }
    if (codeExpirationMinutes != null) {
      data['code_expiration_minutes'] = codeExpirationMinutes;
    }
    return data;
  }

  Component copyWith({
    String? type,
    Object? text = _undefined,
    Object? format = _undefined,
    Object? example = _undefined,
    Object? addSecurityRecommendation = _undefined,
    Object? buttons = _undefined,
    Object? cards = _undefined,
    Object? limitedTimeOffer = _undefined,
    Object? codeExpirationMinutes = _undefined,
  }) {
    return Component(
      type: type ?? this.type,
      text: text == _undefined ? this.text : text as String?,
      format: format == _undefined ? this.format : format as String?,
      example: example == _undefined ? this.example : example as ComponentExample?,
      addSecurityRecommendation: addSecurityRecommendation == _undefined ? this.addSecurityRecommendation : addSecurityRecommendation as bool?,
      buttons: buttons == _undefined ? this.buttons : buttons as List<TemplateButton>?,
      cards: cards == _undefined ? this.cards : cards as List<CarouselCard>?,
      limitedTimeOffer: limitedTimeOffer == _undefined ? this.limitedTimeOffer : limitedTimeOffer as LimitedTimeOffer?,
      codeExpirationMinutes: codeExpirationMinutes == _undefined ? this.codeExpirationMinutes : codeExpirationMinutes as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Component) return false;
    return other.type == type &&
        other.text == text &&
        other.format == format &&
        other.example == example &&
        other.addSecurityRecommendation == addSecurityRecommendation &&
        _listEquals(buttons, other.buttons) &&
        _listEquals(cards, other.cards) &&
        other.limitedTimeOffer == limitedTimeOffer &&
        other.codeExpirationMinutes == codeExpirationMinutes;
  }

  @override
  int get hashCode => Object.hash(
    type,
    text,
    format,
    example,
    addSecurityRecommendation,
    buttons != null ? Object.hashAll(buttons!) : null,
    cards != null ? Object.hashAll(cards!) : null,
    limitedTimeOffer,
    codeExpirationMinutes,
  );

  @override
  String toString() =>
      'Component(type: $type, text: $text, format: $format, example: $example, '
      'addSecurityRecommendation: $addSecurityRecommendation, buttons: $buttons, '
      'cards: $cards, limitedTimeOffer: $limitedTimeOffer, '
      'codeExpirationMinutes: $codeExpirationMinutes)';
}

// ---------------------------------------------------------------------------
// TemplateObj
// ---------------------------------------------------------------------------

/// Root model representing a WhatsApp message template object.
class TemplateObj {
  final List<Component> components;
  final String name;
  final String language;
  final String id;
  final String category;
  final String status;
  final int messageSendTtlSeconds;
  final String parameterFormat;

  ValueNotifier<bool> showSmartUrlCheckBox = ValueNotifier(false);
  ValueNotifier<bool> isSmartUrlEnabled = ValueNotifier(false);
  ValueNotifier<List<AdditionalInfo>> additionalInfoList = ValueNotifier([]);

  resetSmartUrlAttributes() {
    //
    for (final component in components) {
      if (component.type == 'BODY') {
        for (final attribute in component.attributes) {
          attribute.isSmartUrlEnabled.value = false;
        }
      }
      if (component.type == 'CAROUSEL') {
        //
        for (final card in component.cards ?? []) {
          for (final bodyComponent in card.components) {
            if (bodyComponent.type == 'BODY') {
              for (final attribute in bodyComponent.attributes) {
                attribute.isSmartUrlEnabled.value = false;
              }
            }
          }
        }
      }
    }
  }

  void onBodyTextChanged() {
    //
    //
    Component? bodyComponent = components.firstWhereOrNull((element) => element.type == 'BODY');
    if (bodyComponent?.attributes.isNotEmpty ?? false) {
      //
      Component? buttonComponent = components.firstWhereOrNull((element) => element.type == 'BUTTONS');
      if (buttonComponent != null) {
        //
        TemplateButton? urlButton = buttonComponent.buttons?.firstWhereOrNull((element) => element.type == "URL");
        if (urlButton != null) {
          //
          urlButton.buttonTextController.text = bodyComponent?.attributes.firstWhere((element) => element.selectedVariableValue.value != null).selectedVariableValue.value ?? '';
        }
      }
    }
  }

  TemplateObj({
    required this.components,
    required this.name,
    required this.language,
    required this.id,
    required this.category,
    required this.status,
    required this.messageSendTtlSeconds,
    required this.parameterFormat,
  });

  String getButtonPhJson() {
    //

    List<Map<String, dynamic>> buttonJson = [];
    Component? buttonComponent = components.firstWhereOrNull((element) => element.type == 'BUTTONS');
    if (buttonComponent != null) {
      //

      final List<TemplateButton>? buttons = buttonComponent.buttons;
      if (buttons != null) {
        for (int i = 0; i < buttons.length; i++) {
          //
          TemplateButton button = buttons[i];
          switch (button.type) {
            //
            case "QUICK_REPLY":
              buttonJson.add({
                "type": "QRA",
                "index": i,
                "text": button.buttonTextController.text,
                "valueType": "static",
                "sectionObjs": [
                  {"title": "", "productRetailerIds": []},
                ],
                "thumbnailRetailerId": "",
                "flowActionData": [],
              });
              break;
            case "COPY_CODE":
              buttonJson.add({
                "type": "COPY_CODE",
                "index": 2,
                "text": button.buttonTextController.text,
                "valueType": "static",
                "sectionObjs": [
                  {"title": "", "productRetailerIds": []},
                ],
                "thumbnailRetailerId": "",
                "flowActionData": [],
              });
              break;
            case "FLOW":
              //

              List<Map<String, dynamic>> flowActionData = [];
              FlowRawScreen? flowRawScreen = button.flowRawScreenData;
              if (flowRawScreen != null) {
                for (final action in flowRawScreen.attributes) {
                  flowActionData.add({"key": action.header, "value": action.textController.text, "actionType": "static"});
                }
              }
              buttonJson.add({
                "type": "FLOW",
                "index": i,
                "text": "",
                "valueType": "static",
                "sectionObjs": [
                  {"title": "", "productRetailerIds": []},
                ],
                "thumbnailRetailerId": "",
                "flowActionData": flowActionData,
              });
              break;
          }
        }
      }
    }
    return buttonJson.isNotEmpty ? "" : jsonEncode(buttonJson);
  }

  String getLtoPhJson() {
    //
    Component? limitedTimeOffer = components.firstWhereOrNull((element) => element.type == 'limited_time_offer');

    if (limitedTimeOffer != null) {
      Map<String, dynamic> json = {'valueType': 'static', 'expirationTimeMs': limitedTimeOffer.selectedOfferExpiryDateTime.value?.millisecondsSinceEpoch ?? 0};
      return jsonEncode(json);
    }
    return "";
  }

  factory TemplateObj.fromJson(Map<String, dynamic> json) {
    TemplateObj templateObj = TemplateObj(
      components: (json['components'] as List<dynamic>).map((e) => Component.fromJson(e as Map<String, dynamic>)).toList(),
      name: json['name'] as String,
      language: json['language'] as String,
      id: json['id'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      messageSendTtlSeconds: json['message_send_ttl_seconds'] as int,
      parameterFormat: json['parameter_format'] as String,
    );

    // Check if any component is of type 'BODY' and has non-empty attributes
    for (final component in templateObj.components) {
      if (component.type == 'BODY' && component.attributes.isNotEmpty) {
        templateObj.showSmartUrlCheckBox = ValueNotifier(true);
        break;
      }
      if (component.type == 'CAROUSEL') {
        //
        if (component.cards?.isNotEmpty ?? false) {
          //
          for (CarouselCard card in component.cards ?? []) {
            if (card.components.firstWhereOrNull((element) => element.type == 'BODY')?.attributes.isNotEmpty ?? false) {
              templateObj.showSmartUrlCheckBox = ValueNotifier(true);
              break;
            }
          }
        }
      }
    }

    return templateObj;
  }

  Map<String, dynamic> toJson() {
    return {
      'components': components.map((e) => e.toJson()).toList(),
      'name': name,
      'language': language,
      'id': id,
      'category': category,
      'status': status,
      'message_send_ttl_seconds': messageSendTtlSeconds,
      'parameter_format': parameterFormat,
    };
  }

  TemplateObj copyWith({List<Component>? components, String? name, String? language, String? id, String? category, String? status, int? messageSendTtlSeconds, String? parameterFormat}) {
    return TemplateObj(
      components: components ?? this.components,
      name: name ?? this.name,
      language: language ?? this.language,
      id: id ?? this.id,
      category: category ?? this.category,
      status: status ?? this.status,
      messageSendTtlSeconds: messageSendTtlSeconds ?? this.messageSendTtlSeconds,
      parameterFormat: parameterFormat ?? this.parameterFormat,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TemplateObj) return false;
    return _listEquals(components, other.components) &&
        other.name == name &&
        other.language == language &&
        other.id == id &&
        other.category == category &&
        other.status == status &&
        other.messageSendTtlSeconds == messageSendTtlSeconds &&
        other.parameterFormat == parameterFormat;
  }

  @override
  int get hashCode => Object.hash(Object.hashAll(components), name, language, id, category, status, messageSendTtlSeconds, parameterFormat);

  @override
  String toString() =>
      'TemplateObj(name: $name, language: $language, id: $id, category: $category, '
      'status: $status, messageSendTtlSeconds: $messageSendTtlSeconds, '
      'parameterFormat: $parameterFormat, components: $components)';
}

// ---------------------------------------------------------------------------
// Equality helpers
// ---------------------------------------------------------------------------

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _deepListEquals(List<List<String>>? a, List<List<String>>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (!_listEquals(a[i], b[i])) return false;
  }
  return true;
}
