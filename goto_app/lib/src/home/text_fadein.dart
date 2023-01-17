import 'package:flutter/material.dart';

class TextFadeIn extends StatefulWidget {
  final String text;
  final TextStyle? style;
  const TextFadeIn(this.text, {super.key, this.style});

  @override
  State<TextFadeIn> createState() => _TextFadeInState();
}

class _TextFadeInState extends State<TextFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _aniCtrl;
  late final Animation<double> _animation;
  @override
  void initState() {
    _aniCtrl = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_aniCtrl);

    super.initState();
  }

  @override
  void dispose() {
    _aniCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _aniCtrl.forward();
    return FadeTransition(
        opacity: _animation, child: Text(widget.text, style: widget.style));
  }
}
