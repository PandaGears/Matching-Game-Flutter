import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation(
      {super.key,
      required this.card,
      required this.animate,
      required this.returnAnimate,
      required this.animationComplete,
      required this.delay});

  final Widget card;
  final bool animate;
  final bool returnAnimate;
  final Function(bool) animationComplete;
  final int delay;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2600), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.animationComplete.call(true);
        }
        if (status == AnimationStatus.dismissed) {
          widget.animationComplete.call(false);
        }
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void didUpdateWidget(covariant FlipAnimation oldWidget) {
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        if (widget.animate) {
          if (widget.returnAnimate) {
            _controller.reverse();
          } else {
            _controller.reset();
            _controller.forward();
          }
        }
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateY(_animation.value * pi)
              ..setEntry(3, 2, 0.005),
            child: _controller.value >= 0.50
                ? widget.card
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://res.cloudinary.com/dzzk7cezp/image/upload/v1683639838/CardGame/cover_iskzvc.png"))),
                    child: const Icon(
                      Icons.question_mark,
                      size: 50,
                      color: Colors.white,
                    ),
                  )));
  }
}
