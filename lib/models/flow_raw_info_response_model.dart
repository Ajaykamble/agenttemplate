// To parse this JSON data, do
//
//     final flowRawInfoResponse = flowRawInfoResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

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
    model._filterAttributesByInitValues();

    return model;
  }

  /// Scans all screens' form init-values for ${data.xxx} references,
  /// then removes attributes that are never used in any init-values
  /// (i.e. only passed through in footer payloads).
  void _filterAttributesByInitValues() {
    Set<String> referencedKeys = {};
    for (final screen in screens) {
      _collectInitValueDataKeys(screen.layout, referencedKeys);
    }
    for (final screen in screens) {
      screen.attributes = screen.attributes.where((attr) => referencedKeys.contains(attr.header)).toList();
    }
  }

  static void _collectInitValueDataKeys(Map<String, dynamic>? node, Set<String> keys) {
    if (node == null) return;
    if (node.containsKey("init-values") && node["init-values"] is Map<String, dynamic>) {
      (node["init-values"] as Map<String, dynamic>).forEach((_, value) {
        if (value is String) {
          for (final match in RegExp(r'\$\{data\.(\w+)\}').allMatches(value)) {
            keys.add(match.group(1)!);
          }
        }
      });
    }
    if (node.containsKey("children") && node["children"] is List) {
      for (final child in node["children"]) {
        if (child is Map<String, dynamic>) {
          _collectInitValueDataKeys(child, keys);
        }
      }
    }
  }

  Map<String, dynamic> toJson() => {"version": version, "screens": List<dynamic>.from(screens.map((x) => x.toJson()))};
}

class FlowRawScreen {
  String id;
  String title;
  Map<String, dynamic>? data;
  Map<String, dynamic>? layout;
  bool? terminal;

  List<FlawRawScreenAttributes> attributes = [];

  FlowRawScreen({required this.id, required this.title, this.data, this.layout, this.terminal});

  factory FlowRawScreen.fromJson(Map<String, dynamic> json) {
    List<FlawRawScreenAttributes> at = [];
    FlowRawScreen screen = FlowRawScreen(id: json["id"], title: json["title"], data: json["data"], layout: json["layout"], terminal: json["terminal"]);

    screen.data?.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        at.add(FlawRawScreenAttributes(header: key, type: value["type"]));
      }
    });

    screen.attributes = at;
    return screen;
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "data": data, "layout": layout, "terminal": terminal};
}

class FlawRawScreenAttributes {
  //
  //
  String? header;
  String? type;

  TextEditingController textController = TextEditingController();

  FlawRawScreenAttributes({this.header, this.type});
}
