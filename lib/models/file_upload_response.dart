// To parse this JSON data, do
//
//     final fileUploadResponse = fileUploadResponseFromJson(jsonString);

import 'dart:convert';

FileUploadResponse fileUploadResponseFromJson(String str) => FileUploadResponse.fromJson(json.decode(str));

String fileUploadResponseToJson(FileUploadResponse data) => json.encode(data.toJson());

class FileUploadResponse {
  bool? status;
  int? statusCode;
  String? messages;
  dynamic intentNames;
  List<FileDatum>? fileData;

  FileUploadResponse({this.status, this.statusCode, this.messages, this.intentNames, this.fileData});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) => FileUploadResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    messages: json["messages"],
    intentNames: json["intentNames"],
    fileData: json["fileData"] == null ? [] : List<FileDatum>.from(json["fileData"]!.map((x) => FileDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "messages": messages,
    "intentNames": intentNames,
    "fileData": fileData == null ? [] : List<dynamic>.from(fileData!.map((x) => x.toJson())),
  };
}

class FileDatum {
  dynamic docFileDataId;
  String? fileName;
  String? filePath;
  String? localPath;
  dynamic fileHandler;
  dynamic mediaId;

  FileDatum({this.docFileDataId, this.fileName, this.filePath, this.localPath, this.fileHandler, this.mediaId});

  factory FileDatum.fromJson(Map<String, dynamic> json) =>
      FileDatum(docFileDataId: json["docFileDataId"], fileName: json["fileName"], filePath: json["filePath"], localPath: json["localPath"], fileHandler: json["fileHandler"], mediaId: json["mediaId"]);

  Map<String, dynamic> toJson() => {"docFileDataId": docFileDataId, "fileName": fileName, "filePath": filePath, "localPath": localPath, "fileHandler": fileHandler, "mediaId": mediaId};
}
