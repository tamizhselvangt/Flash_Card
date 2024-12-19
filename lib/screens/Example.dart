
import 'package:flash_card/FlashCardView.dart';
import 'package:flash_card/widgets/flash_card.dart';
import 'package:flutter/material.dart';
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
      body: Column(
        children: [
    WavyCard()
        ],
      ),
    );
  }
}


class WavyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Color(0xFF9575CD), // Light purple color
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Bottom wave section (darker purple)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(double.infinity, 200),
                painter: WavePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF7E57C2) // Darker purple color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from the left bottom
    path.moveTo(0, size.height);

    // Create wave pattern
    final firstControlPoint = Offset(size.width * 0.25, size.height * 0.5);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.9);
    final secondEndPoint = Offset(size.width, size.height * 0.6);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Usage example
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: WavyCard(),
        ),
      ),
    );
  }
}