import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<String> convertXFileToBase64Image(XFile xFile) async {
  Uint8List imageBytes = await xFile.readAsBytes();

  return base64Encode(imageBytes);
}
