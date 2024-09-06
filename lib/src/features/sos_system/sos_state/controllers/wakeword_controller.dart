import 'package:eduguard/src/features/sos_system/sos_state/screens/sos_state.dart';
import 'package:get/get.dart';
import 'package:picovoice_flutter/picovoice_manager.dart';
import 'package:picovoice_flutter/picovoice_error.dart';
import 'package:rhino_flutter/rhino.dart';

class CommandController extends GetxController {
  var liseningForCommand =false.obs;
  var isError =false.obs;
  var errorMessage = ''.obs;

  late PicovoiceManager _picovoiceManager;
  final String accessKey ="0YhcUOZ60wzptJQJ9p5jLo1B1I/YXtnopzpphp5zFEyu+IdHs9ZbRA==";

  void initPicovoice() async {
    const String keywordPath ="assets/picovoice/Edu-help_en_android_v3_0_0.ppn";
    const String contextPath ="assets/picovoice/Eduguard_en_android_v3_0_0.rhn";

    try{
      late RhinoInference inference;
      _picovoiceManager =await PicovoiceManager.create(
        accessKey,
        keywordPath,
        _wakeWordCallback,
        contextPath,
        _inferenceCallback,
      );

      //Start Audio processing
      _picovoiceManager.start();
    }
    on PicovoiceException catch (e) {
      print(e);
    }
  }


  void _wakeWordCallback() {
    print("wake word detected...");
    liseningForCommand.value =true;
    Get.to(() => const SOSStateScreen());
  }

  void _inferenceCallback(RhinoInference inference) {
    if (inference.isUnderstood != null) {
      Map<String, String>? slots =inference.slots;
      if(inference.intent == 'eduCall') {
        print("calling high priority contact!!!!");
      }
      else {
        _rejectCommand();
      }
    }
    liseningForCommand.value =false;
  }

  void _rejectCommand() {
    print('inference rejected');
  }


}