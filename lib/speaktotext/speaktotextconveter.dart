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

  bool startRecording = false;
  bool isAvailable = false;

  String text = "Press mic button to start recording";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      isAvailable = await speech.initialize(
        onStatus: (status) {
          // optional debugging
        },
        onError: (error) {
          setState(() {
            text = "Error: ${error.errorMsg}";
          });
        },
      );
      setState(() {});
    } catch (e) {
      setState(() {
        text = "Speech init failed";
      });
    }
  }

  void _startListening() {
    if (!isAvailable) return;
    speech.listen(
      listenMode: ListenMode.dictation,
      onResult: (result) {
        setState(() {
          text = result.recognizedWords;
          print(text);
        });
        if (widget.onResult != null) {
          widget.onResult!(text);
        }
      },
    );
  }
  void _stopListening() {
    speech.stop();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            animate: widget.animate && startRecording,
            glowColor: widget.animateColor,
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  startRecording = true;
                });
                _startListening();
              },
              onTapUp: (_) {
                setState(() {
                  startRecording = false;
                });
                _stopListening();
              },
              child: Icon(widget.icon, size: 40),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}