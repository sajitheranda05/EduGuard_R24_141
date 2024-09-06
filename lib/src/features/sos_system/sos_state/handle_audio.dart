import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _recorder =AudioRecorder();
  late String _filePath;

  Future<void> startRecording() async {

    //Permission Check
    final bool isPermissionGranted =await _recorder.hasPermission();
    if(!isPermissionGranted) {
      return;
    }

    final directory =await getApplicationDocumentsDirectory();
    //generate a unique file name using the current timestamp
    String filename ='recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    _filePath ='${directory.path}/$filename';

    //define the configuration for the recording
    const config =RecordConfig(
      encoder: AudioEncoder.wav, //Encoder
      sampleRate: 22050, //Sample Rate
      bitRate: 128000, //Bit rate
    );

    await _recorder.start(config, path: _filePath);

    // //Stop recording after 5 seconds
    // Future.delayed(Duration(seconds: 5), () async {
    //   await stopRecording();

    // });

  }

  Future<String> stopRecording() async {
    await _recorder.stop();
    //_recorder.dispose();
    return _filePath;
  }

}
