import 'dart:convert';
import 'dart:developer';
import'package:http/http.dart' as http;

class SpeechEmotionDetectionAPIService {
  final String apiUrl ="http://10.0.2.2:5000/predict"; //Emulator
  //final String apiUrl ="http://192.168.1.11:5000/predict"; //Real device

  Future<String> uploadAudio(String filepath) async {
    final request =http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('audio', filepath));

    final response =await request.send();
    // log('Response status: ${response.statusCode}');
    // log('Response headers: ${response.headers}');
    // log('Response body: ${await response.stream.bytesToString()}');

    if (response.statusCode == 200) {
      final responseData =await response.stream.toBytes();
      final responseString =String.fromCharCodes(responseData);
      final jsonReponse =jsonDecode(responseString);

      log('Predicted Emotion: ${jsonReponse['predicted_emotion']}');

      return jsonReponse['predicted_emotion'];
    }
    else{

      throw Exception('Failed to get emotion Prediction');
    }
  }
}
