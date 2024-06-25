import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  final String title;
  const AnimationPage({super.key, required this.title});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rectPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 400).animate(_controller)
      ..addListener(() {
        setState(() {
          _rectPosition = _animation.value;
        });
      });
  }

  void _moveLeft() {
    _controller.reverse();
  }

  void _moveRight() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            painter: RectanglePainter(_rectPosition),
            child: const SizedBox(
              width: double.infinity,
              height: 200,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _moveLeft,
                child: const Text('Move Left'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _moveRight,
                child: const Text('Move Right'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  final double position;

  RectanglePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    const double rectWidth = 50;
    const double rectHeight = 50;
    final double startY = size.height / 2 - rectHeight / 2;

    final Rect rect = Rect.fromLTWH(position, startY, rectWidth, rectHeight);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
