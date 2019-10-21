import 'dart:math';

import 'package:flutter/material.dart';

class Bubble {
  Offset speed;
  Offset location;
  double radius;
  double life;
  Color color;
  double opacity;

  double remainingLife;

  Bubble() {
    Random rd = Random();

    this.speed = Offset(-0.5 + rd.nextDouble(), -0.5 + rd.nextDouble());
    this.location = Offset(32.0, 32.0);
    this.radius = 8.0 + rd.nextDouble() * 16;
    this.life = rd.nextDouble() * 20;
    this.remainingLife = this.life;

    this.color = const Color(0xFF6fa1ea);
  }

  move() {
    this.remainingLife -= 0.1;
    this.location = this.location + this.speed;
  }

  display(Canvas canvas) {
    this.opacity = (this.remainingLife / this.life * 100).round() / 100;
    var gradient = RadialGradient(
      colors: [
        Color.fromRGBO(
            this.color.red, this.color.green, this.color.blue, this.opacity),
        Color.fromRGBO(
            this.color.red, this.color.green, this.color.blue, this.opacity),
        Color.fromRGBO(this.color.red, this.color.green, this.color.blue, 0.0)
      ],
      stops: [0.0, 0.5, 1.0],
    );

    Paint painter = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
          Rect.fromCircle(center: this.location, radius: this.radius));

    canvas.drawCircle(this.location, this.radius, painter);
  }
}

class CircleMenuToggleButton extends StatefulWidget {
  final bool expanded;
  CircleMenuToggleButton({this.expanded = false});

  @override
  State<StatefulWidget> createState() {
    return _CircleMenuToggleButtonState();
  }
}

class _CircleMenuToggleButtonState extends State<CircleMenuToggleButton>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final bubbles = <Bubble>[];

  @override
  void initState() {
    super.initState();

    List.generate(5, (i) {
      bubbles.add(Bubble());
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            for (int i = 0; i < bubbles.length; i++) {
              bubbles[i].move();

              if (bubbles[i].remainingLife < 0 || bubbles[i].radius < 0) {
                bubbles[i] = Bubble();
              }
            }
          })
          ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => CustomPaint(
                  size: Size(64.0, 64.0),
                  painter: _BubblePainter(bubbles),
                ),
          ),
          Image.asset(
            widget.expanded
                ? 'assets/buttons/close_menu.png'
                : 'assets/buttons/add_drink.png',
            width: 64.0,
            height: 64.0,
          ),
        ],
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  _BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      bubble.display(canvas);
    }
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => true;
}
