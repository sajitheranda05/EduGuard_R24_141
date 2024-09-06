import 'package:eduguard/src/features/sos_system/sos_state/test/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.multitrack_audio_sharp,
            size: 48,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App is recording...',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Recorded audio will be analyzed to identify distress instances.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Obx(() => Text(
                  'Predicted Emotion: ${audioController.predictedEmotion}',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                )),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              audioController.onClose(); // Ensure resources are cleaned up
              // You can also handle stopping the recording and emotion prediction here
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
