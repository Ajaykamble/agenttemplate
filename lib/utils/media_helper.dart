/// Common utility functions for media type constraints.
///
/// Provides file size limits, allowed extensions, and URL hints
/// based on the media type (IMAGE, VIDEO, DOCUMENT, etc.).
class MediaHelper {
  MediaHelper._();

  /// Human-readable maximum file size label for the given [mediaType].
  static String maxFileSize(String mediaType) {
    switch (mediaType) {
      case 'IMAGE':
        return '5Mb';
      case 'VIDEO':
        return '16Mb';
      case 'DOCUMENT':
        return '100Mb';
      default:
        return '16Mb';
    }
  }

  /// Maximum file size in bytes for the given [mediaType].
  static int maxFileSizeInBytes(String mediaType) {
    switch (mediaType) {
      case 'IMAGE':
        return 5 * 1024 * 1024; // 5 MB
      case 'VIDEO':
        return 16 * 1024 * 1024; // 16 MB
      case 'DOCUMENT':
        return 100 * 1024 * 1024; // 100 MB
      default:
        return 16 * 1024 * 1024; // 16 MB
    }
  }

  /// Allowed file extensions for the given [mediaType].
  static List<String> allowedExtensions(String mediaType) {
    switch (mediaType) {
      case 'IMAGE':
        return ['jpg', 'jpeg', 'png'];
      case 'VIDEO':
        return ['mp4', '3gp'];
      case 'DOCUMENT':
        return ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'];
      default:
        return [];
    }
  }

  /// Placeholder hint text for a URL input based on the given [mediaType].
  static String mediaUrlHint(String mediaType) {
    switch (mediaType) {
      case 'IMAGE':
        return 'Enter Image URL';
      case 'VIDEO':
        return 'Enter Video URL';
      case 'DOCUMENT':
        return 'Enter Document URL';
      default:
        return 'Enter URL';
    }
  }
}
