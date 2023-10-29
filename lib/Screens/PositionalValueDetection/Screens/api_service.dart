import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> fetchPost(String inputWord) async {
    final response = await http.post(
      Uri.parse('http://192.168.8.168:4000/API_Word'), // replace with your API's URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'input_word': inputWord,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server returns an error, throw an exception.
      throw Exception('Failed to load data');
    }
  }
}