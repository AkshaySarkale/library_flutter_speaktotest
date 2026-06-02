import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speaktotextconveter extends StatefulWidget {
  final IconData icon;
  final bool animate;
  final Color animateColor;
  final Function(String text)? onResult;

  const Speaktotextconveter({
    super.key,
    required this.icon,
    this.animate = true,
    this.animateColor = Colors.red,
    this.onResult,
  });

  @override
  State<Speaktotextconveter> createState() => _SpeaktotextconveterState();
}

class _SpeaktotextconveterState extends State<Speaktotextconveter> {
  final SpeechToText speech = SpeechToText();
  bool isListening = false;
  bool isAvailable = false;
  String text = "Press mic button to start speaking";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      isAvailable = await speech.initialize();
      setState(() {});
    } catch (e) {
      text = "Speech initialization failed";
    }
  }
  void _startListening() {
    if (!isAvailable) return;
    speech.listen(
      listenMode: ListenMode.dictation,
      onResult: (result) {
        setState(() {
          text = result.recognizedWords;
        });
        widget.onResult?.call(text);
      },
    );
  }

  void _stopListening() {
    speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarGlow(
          animate: widget.animate && isListening,
          glowColor: widget.animateColor,
          child: GestureDetector(
            onTapDown: (value) {
              setState(() => isListening = true);
              _startListening();
            },
            onTapUp: (value) {
              setState(() => isListening = false);
              _stopListening();
            },
            child: Icon(widget.icon, size: 50),
          ),
        ),
        const SizedBox(height: 20),
        Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16),),
      ],
    );
  }
}