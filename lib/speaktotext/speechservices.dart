import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool _isAvailable = false;

  Future<void> init() async {
    _isAvailable = await _speech.initialize();
  }

  void startListening(Function(String text) onResult) {
    if (!_isAvailable) return;

    _speech.listen(
      listenMode: ListenMode.dictation,
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void stopListening() {
    _speech.stop();
  }
}