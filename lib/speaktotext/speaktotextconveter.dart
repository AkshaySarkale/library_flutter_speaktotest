import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Speaktotextconveter extends StatefulWidget {
  final IconData icon;
  final bool animate;
  final Color? animateColor;

  const Speaktotextconveter({
    super.key,
    required this.icon,
    this.animate = true,
    this.animateColor,
  });

  @override
  State<Speaktotextconveter> createState() => _SpeaktotextconveterState();
}

class _SpeaktotextconveterState extends State<Speaktotextconveter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AvatarGlow(
            animate: widget.animate,
            glowColor: widget.animateColor!,
            child: IconButton(onPressed: () {}, icon: Icon(widget.icon)),
          ),
        ],
      ),
    );
  }
}
