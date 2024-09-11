import 'dart:developer';

import 'package:get/get.dart';
import 'package:eduguard/src/features/sos_system/sos_state/handle_api.dart';
import 'package:eduguard/src/features/sos_system/sos_state/handle_audio.dart';
import 'package:eduguard/src/features/sos_system/sos_state/handle_distress_detection.dart';

class AudioController extends GetxController {
  final AudioRecorderService _audioRecorder = AudioRecorderService();
  final SpeechEmotionDetectionAPIService _emotionService = SpeechEmotionDetectionAPIService();
  EMADistressDetection _distressDetector = EMADistressDetection(0.2, 2.5);
  final RxString _predictedEmotion = 'Unknown'.obs;
  RxBool isRecording = true.obs;
  bool _isDisposed = false;

  // Example scoring systems
  final Map<String, double> _emotionScores = {
    'happy': 2.0,
    'surprise': -1.5,
    'calm': -1.0,
    'neutral': 0.0,
    'sad': 1.0,
    'disgust': 1.5,
    'angry': 2.0,
    'fear': 3.0,
  };

  String get predictedEmotion => _predictedEmotion.value;

  @override
  void onInit() {
    super.onInit();
    _startContinuousEmotionPrediction();  // Start continuous prediction
  }

  @override
  void onClose() {
    isRecording.value = false;
    _isDisposed = true;
    super.onClose();
  }

  Future<void> _predictEmotion() async {
    if (_isDisposed) return;

    try {
      await _audioRecorder.startRecording();
      await Future.delayed(Duration(seconds: 5));
      String filePath = await _audioRecorder.stopRecording();
      String predictedEmotion = await _emotionService.uploadAudio(filePath);

      // Check the predicted emotion
      print("Predicted Emotion: $predictedEmotion");

      // Get the corresponding score for the predicted emotion
      double emotionScore = _emotionScores[predictedEmotion] ?? 0.0;
      print("Emotion Score: $emotionScore");

      // Update the EMA
      double updatedEMA = _distressDetector.updateEMA(emotionScore);
      print("Updated EMA: $updatedEMA");

      if (!_isDisposed) {
        _predictedEmotion.value = predictedEmotion;
      }

      if (_distressDetector.isUserInDistress()) {
        print("User is in distress!");
        // Trigger an alert or response here
      } else {
        print("User is not in distress.");
      }
    } catch (error) {
      print("Error: $error");
      if (!_isDisposed) {
        _predictedEmotion.value = "Something went wrong...";
      }
    }
  }


  void _startContinuousEmotionPrediction() {
    Future.doWhile(() async {
      if (!isRecording.value || _isDisposed) return false;
      await _predictEmotion();
      await Future.delayed(Duration(seconds: 5)); // Wait before the next prediction
      return true; // Continue the loop
    });
  }

  Future<void> cancelRecording() async {
    // Set the flag to stop the continuous prediction
    isRecording.value = false;

    try {
      // If recording is ongoing, stop it
      if (await _audioRecorder.isRecording()) {
        await _audioRecorder.stopRecording();
        log("Recording canceled.");
      }
    } catch (error) {
      print("Error while canceling recording: $error");
    }
  }

  Future<void> restartPrediction() async {
    await cancelRecording();  // Stop any existing prediction
    _isDisposed = false;      // Reset the disposed state
    isRecording.value = true; // Set recording to true
    _startContinuousEmotionPrediction(); // Start continuous prediction again
  }

}
