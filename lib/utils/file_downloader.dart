import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  FileDownloader._();

  static Future<String> _getSaveDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static String _fileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    String fileName =
        uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'download';
    if (fileName.contains('?')) {
      fileName = fileName.split('?').first;
    }
    if (!fileName.contains('.')) {
      fileName = '$fileName.mp4';
    }
    return fileName;
  }

  /// Downloads the file at [url] into the app's documents directory and
  /// immediately opens it with the system viewer.
  ///
  /// Works on Android, iOS, and macOS without any special permissions.
  ///
  /// Returns the saved file path on success, or `null` on failure.
  /// [onProgress] is called with (bytesReceived, totalBytes). totalBytes may
  /// be -1 if the server doesn't provide Content-Length.
  static Future<String?> downloadAndOpen({
    required String url,
    String? fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      final dir = await _getSaveDirectory();
      fileName ??= _fileNameFromUrl(url);
      final savePath = '$dir/$fileName';

      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();

      final totalBytes = response.contentLength;
      int receivedBytes = 0;

      final file = File(savePath);
      final sink = file.openWrite();

      await response.listen((chunk) {
        receivedBytes += chunk.length;
        sink.add(chunk);
        onProgress?.call(receivedBytes, totalBytes);
      }).asFuture();

      await sink.flush();
      await sink.close();
      httpClient.close();

      await OpenFilex.open(savePath);

      return savePath;
    } catch (e) {
      debugPrint('FileDownloader: download failed — $e');
      return null;
    }
  }
}
