// To parse this JSON data, do
//
//     final flowRawInfoResponse = flowRawInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:agenttemplate/utils/app_enums.dart';
import 'package:flutter/material.dart';

FlowRawInfoResponse flowRawInfoResponseFromJson(String str) => FlowRawInfoResponse.fromJson(json.decode(str));

String flowRawInfoResponseToJson(FlowRawInfoResponse data) => json.encode(data.toJson());

class FlowRawInfoResponse {
  bool? status;
  Flows? flows;
  RawInfoModel? rawInfo;

  FlowRawInfoResponse({this.status, this.flows, this.rawInfo});

  factory FlowRawInfoResponse.fromJson(Map<String, dynamic> json) => FlowRawInfoResponse(
        status: json["status"],
        flows: json["flows"] == null ? null : Flows.fromJson(json["flows"]),
        rawInfo: json["rawInfo"] == null ? null : RawInfoModel.fromJson(jsonDecode(json["rawInfo"])),
      );

  Map<String, dynamic> toJson() => {"status": status, "flows": flows?.toJson(), "rawInfo": rawInfo?.toJson()};
}

class Flows {
  List<Datum>? data;
  Paging? paging;

  Flows({this.data, this.paging});

  factory Flows.fromJson(Map<String, dynamic> json) =>
      Flows(data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))), paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]));

  Map<String, dynamic> toJson() => {"data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())), "paging": paging?.toJson()};
}

class Datum {
  String? name;
  String? assetType;
  String? downloadUrl;
  dynamic status;
  dynamic id;
  dynamic categories;
  dynamic validationErrors;

  Datum({this.name, this.assetType, this.downloadUrl, this.status, this.id, this.categories, this.validationErrors});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        assetType: json["asset_type"],
        downloadUrl: json["download_url"],
        status: json["status"],
        id: json["id"],
        categories: json["categories"],
        validationErrors: json["validation_errors"],
      );

  Map<String, dynamic> toJson() => {"name": name, "asset_type": assetType, "download_url": downloadUrl, "status": status, "id": id, "categories": categories, "validation_errors": validationErrors};
}

class Paging {
  Cursors? cursors;

  Paging({this.cursors});

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(cursors: json["cursors"] == null ? null : Cursors.fromJson(json["cursors"]));

  Map<String, dynamic> toJson() => {"cursors": cursors?.toJson()};
}

class Cursors {
  String? before;
  String? after;

  Cursors({this.before, this.after});

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(before: json["before"], after: json["after"]);

  Map<String, dynamic> toJson() => {"before": before, "after": after};
}

class RawInfoModel {
  String version;
  List<FlowRawScreen> screens;

  RawInfoModel({required this.version, required this.screens});

  factory RawInfoModel.fromJson(Map<String, dynamic> json) {
    RawInfoModel model = RawInfoModel(
      version: json["version"],
      screens: List<FlowRawScreen>.from(json["screens"].map((x) => FlowRawScreen.fromJson(x))),
    );

    return model;
  }

  Map<String, dynamic> toJson() => {"version": version, "screens": List<dynamic>.from(screens.map((x) => x.toJson()))};
}

class FlowRawScreen {
  String id;
  String title;
  Map<String, dynamic>? data;
  Map<String, dynamic>? layout;
  bool? terminal;

  FlowRawScreen({required this.id, required this.title, this.data, this.layout, this.terminal});

  List<FlawRawScreenAttributes> getFlowScreenAttributes(SendTemplateType type) {
    List<FlawRawScreenAttributes> at = [];
    List<dynamic> children = layout?["children"] ?? [];

    for (Map<String, dynamic> child in children) {
      //
      Map<String, dynamic>? initValues = child["init-values"];
      if (initValues != null) {
        //
        initValues.forEach((key, value) {
          // If the value starts with "${data.", extract the key using a RegExp.
          RegExp reg = RegExp(r'^\$\{data\.([^\}]+)\}$');
          if (value is String) {
            final match = reg.firstMatch(value);
            if (match != null) {
              String dataKey = match.group(1)!;
              // You can process or store `dataKey` as needed, e.g.:
              at.add(FlawRawScreenAttributes(header: type == SendTemplateType.normal ? dataKey : key));
            }
          }
        });
      }
    }
    return at;
  }

  factory FlowRawScreen.fromJson(Map<String, dynamic> json) {
    FlowRawScreen screen = FlowRawScreen(id: json["id"], title: json["title"], data: json["data"], layout: json["layout"], terminal: json["terminal"]);

    //screen.attributes = at;
    return screen;
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "data": data, "layout": layout, "terminal": terminal};
}

class FlawRawScreenAttributes {
  //
  //
  String? header;
  //String? type;

  TextEditingController textController = TextEditingController();

  FlawRawScreenAttributes({this.header});
}
