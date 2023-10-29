import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

Future<String> transcribeAudio(String url) async {
  try {
    // Step 1: Download audio file from Firebase Storage
    final ref = FirebaseStorage.instance.refFromURL(url);
    final File tempFile =
        File('${(await getTemporaryDirectory()).path}/temp_audio.wav');
    await ref.writeToFile(tempFile);

    // Step 2: Create multipart request
    final uri = Uri.parse("http://10.0.2.2:5000/voiceUpload");
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('audio', tempFile.path));

    // Step 3: Send request to server
    var response = await http.Response.fromStream(await request.send());

    // Step 4: Process the result
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['Result'] ?? 'Error in transcription';
    } else {
      return 'Failed to transcribe';
    }
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}
