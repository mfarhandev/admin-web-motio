
import 'dart:html';
import 'dart:typed_data';

Future<File> convertBytesToFile(Uint8List bytes, String fileName) async {
  final blob = Blob([bytes]);
  final blobUrl = Url.createObjectUrlFromBlob(blob);
  final file = File([blob], fileName);

  // Clean up the blobUrl to release resources
  Url.revokeObjectUrl(blobUrl);

  return file;
}