// ignore_for_file: unnecessary_this

import 'dart:convert';

/// Sentinel value used in [copyWith] to distinguish between
/// "not passed" and "explicitly set to null".
const Object _undefined = _Undefined();

class _Undefined {
  const _Undefined();
}

// ---------------------------------------------------------------------------
// FileObject
// ---------------------------------------------------------------------------

/// Represents a file/media attachment in a template.
///
/// Contains metadata about the uploaded file including its name, paths,
/// handler token, and optional media ID.
///
/// All fields are nullable to safely handle any missing/null values
/// from the API response.
class FileObject {
  final int? docFileDataId;
  final String? fileName;
  final String? filePath;
  final String? localPath;
  final String? fileHandler;
  final String? mediaId;

  const FileObject({this.docFileDataId, this.fileName, this.filePath, this.localPath, this.fileHandler, this.mediaId});

  factory FileObject.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const FileObject();
    }
    return FileObject(
      docFileDataId: json['docFileDataId'] != null ? json['docFileDataId'] as int? : null,
      fileName: json['fileName'] as String?,
      filePath: json['filePath'] as String?,
      localPath: json['localPath'] as String?,
      fileHandler: json['fileHandler'] as String?,
      mediaId: json['mediaId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (docFileDataId != null) data['docFileDataId'] = docFileDataId;
    if (fileName != null) data['fileName'] = fileName;
    if (filePath != null) data['filePath'] = filePath;
    if (localPath != null) data['localPath'] = localPath;
    if (fileHandler != null) data['fileHandler'] = fileHandler;
    if (mediaId != null) data['mediaId'] = mediaId;
    return data;
  }

  FileObject copyWith({
    Object? docFileDataId = _undefined,
    Object? fileName = _undefined,
    Object? filePath = _undefined,
    Object? localPath = _undefined,
    Object? fileHandler = _undefined,
    Object? mediaId = _undefined,
  }) {
    return FileObject(
      docFileDataId: docFileDataId == _undefined ? this.docFileDataId : docFileDataId as int?,
      fileName: fileName == _undefined ? this.fileName : fileName as String?,
      filePath: filePath == _undefined ? this.filePath : filePath as String?,
      localPath: localPath == _undefined ? this.localPath : localPath as String?,
      fileHandler: fileHandler == _undefined ? this.fileHandler : fileHandler as String?,
      mediaId: mediaId == _undefined ? this.mediaId : mediaId as String?,
    );
  }

  /// Returns `true` if this object has no meaningful data.
  bool get isEmpty => docFileDataId == null && fileName == null && filePath == null && localPath == null && fileHandler == null && mediaId == null;

  /// Returns `true` if this object has any meaningful data.
  bool get isNotEmpty => !isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FileObject) return false;
    return other.docFileDataId == docFileDataId &&
        other.fileName == fileName &&
        other.filePath == filePath &&
        other.localPath == localPath &&
        other.fileHandler == fileHandler &&
        other.mediaId == mediaId;
  }

  @override
  int get hashCode => Object.hash(docFileDataId, fileName, filePath, localPath, fileHandler, mediaId);

  @override
  String toString() =>
      'FileObject(docFileDataId: $docFileDataId, fileName: $fileName, '
      'filePath: $filePath, localPath: $localPath, '
      'fileHandler: $fileHandler, mediaId: $mediaId)';
}

// ---------------------------------------------------------------------------
// FileObjectHelper
// ---------------------------------------------------------------------------

/// Utility class to parse the `fileObject` field from the API response.
///
/// The `fileObject` field can be one of:
/// - `null`
/// - `""` (empty string)
/// - `"{}"` (empty object string)
/// - A stringified single JSON object: `"{\"fileName\":...}"`
/// - A stringified JSON array: `"[{\"fileName\":...}, ...]"`
class FileObjectHelper {
  /// Parses the raw `fileObject` value from the API into a list of [FileObject].
  ///
  /// Returns an empty list for `null`, `""`, or `"{}"`.
  /// Returns a single-element list for a stringified JSON object.
  /// Returns a multi-element list for a stringified JSON array.
  static List<FileObject> parseFileObjects(dynamic rawValue) {
    if (rawValue == null || rawValue == '' || rawValue == '{}') {
      return [];
    }

    if (rawValue is String) {
      try {
        final dynamic decoded = jsonDecode(rawValue);
        if (decoded is Map<String, dynamic>) {
          final fileObj = FileObject.fromJson(decoded);
          return fileObj.isNotEmpty ? [fileObj] : [];
        } else if (decoded is List) {
          final List<FileObject> result = [];
          for (final dynamic item in decoded) {
            if (item is Map<String, dynamic>) {
              final fileObj = FileObject.fromJson(item);
              if (fileObj.isNotEmpty) {
                result.add(fileObj);
              }
            }
          }
          return result;
        }
      } catch (_) {
        return [];
      }
    }

    return [];
  }

  /// Converts a list of [FileObject] back to a JSON string
  /// suitable for the API `fileObject` field.
  ///
  /// Returns `""` for an empty list.
  /// Returns a stringified single object for a single-element list.
  /// Returns a stringified array for a multi-element list.
  static String toFileObjectString(List<FileObject>? fileObjects) {
    if (fileObjects == null || fileObjects.isEmpty) return '';
    if (fileObjects.length == 1) {
      return jsonEncode(fileObjects.first.toJson());
    }
    return jsonEncode(fileObjects.map((e) => e.toJson()).toList());
  }
}
