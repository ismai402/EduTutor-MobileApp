// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  final String apiUrl;

  GeminiService({
    required this.apiKey,
    this.apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent',
  });

  Future<String?> generateContent(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check candidates
        if (data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        } else {
          return "⚠️ No text returned. Full response: ${response.body}";
        }
      } else {
        print('❌ Gemini API error: ${response.body}');
        return "❌ Error: ${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      print('❌ Exception: $e');
      return "❌ Exception: $e";
    }
  }
}
