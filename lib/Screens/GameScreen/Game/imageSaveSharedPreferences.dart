import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> convertImageToBase64(File image) async {
  List<int> imageBytes = await image.readAsBytes();
  return base64Encode(imageBytes);
}

Future<void> saveImageToSharedPreferences(String base64Image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('image_base64', base64Image);
}
Future<File?> retrieveImageFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? base64Image = prefs.getString('image_base64');

  if (base64Image != null) {
    Uint8List imageBytes = base64Decode(base64Image);
    String dir = (await getTemporaryDirectory()).path;
    File file = File('$dir/tempImage.png');
    await file.writeAsBytes(imageBytes);
    return file;
  }
  return null;
}
