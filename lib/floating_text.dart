import 'package:flutter/material.dart';

class FloatingText extends StatefulWidget {
  final String text;
  final Offset position;

  const FloatingText({
    super.key,
    required this.text,
    required this.position,
  });

  @override
  State<FloatingText> createState() => _FloatingTextState();
}

class _FloatingTextState extends State<FloatingText>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0, end: -80).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: widget.position.dx - 20,
          top: widget.position.dy + animation.value - 100,
          child: Opacity(
            opacity: 1 - controller.value,
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
