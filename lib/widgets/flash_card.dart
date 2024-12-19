library flash_card;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../screens/Example.dart';

/// UI flash card, commonly found in language teaching to children
class FlashCard extends StatefulWidget {
  /// constructor: Default height 200dp, width 200dp, duration  500 milliseconds
  const FlashCard(
      {required this.frontWidget,
      required this.backWidget,
      Key? key,
      this.duration = const Duration(milliseconds: 500),
      this.height = 200,
      this.width = 200,
      required this.currentIndex
      }

      )
      : super(key: key);

  /// this is the front of the card
  final Widget frontWidget;

  /// this is the back of the card
  final Widget backWidget;

  /// flip time
  final Duration duration;

  /// height of card
  final double height;

  /// width of card
  final double width;

  ///Index
  final currentIndex;

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard>
    with SingleTickerProviderStateMixin {
  /// controller flip animation
  late AnimationController _controller;

  /// animation for flip from front to back
  late Animation<double> _frontAnimation;

  ///animation for flip from back  to front
  late Animation<double> _backAnimation;

  /// state of card is front or back
  bool isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _frontAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: math.pi / 2)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    _backAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -math.pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleSide,
          child: AnimatedCard(
            animation: _frontAnimation,
            height: widget.height,
            width: widget.width,
            currentIndex: widget.currentIndex,
            child: widget.backWidget,
          ),
        ),
        GestureDetector(
          onTap: _toggleSide,
          child: AnimatedCard(
            currentIndex: widget.currentIndex,
            animation: _backAnimation,
            height: widget.height,
            width: widget.width,
            child: widget.frontWidget,
          ),
        ),

      ],
    );
  }

  /// when user onTap, It will run function
  void _toggleSide() {
    if (isFrontVisible) {
      _controller.forward();
      isFrontVisible = false;
    } else {
      _controller.reverse();
      isFrontVisible = true;
    }
  }
}


class AnimatedCard extends StatelessWidget {
  AnimatedCard(
      {required this.child,
      required this.animation,
      required this.height,
      required this.width,
      Key? key,
      required this.currentIndex
      })
      : super(key: key);

  final Widget child;
  final Animation<double> animation;
  final double height;
  final double width;
  final int currentIndex;
  final List<List<int>> colorPairs = [
    // [0xFFE3DDD7, 0xFFC3B2A3], // Light Cyan and darker Cyan
    // [0xFFCFD1D0, 0xFF414245],
    // [0xFFECD2C9,0xFF9C5251,],
    // [0xFFF4F8FA, 0xFF3E628F],

    //
    // Light Pink and darker Pink
    [0xFFE3DDD7, 0xFFC3B2A3], // Warm Stone Grey
    [0xFFE1E2E1, 0xFF414245], // Cool Charcoal
    [0xFFECD2C9, 0xFF9C5251], // Dusty Rose
    [0xFFF4F8FA, 0xFF3E628F], // Ocean Blue
    [0xFFE8E1D9, 0xFF725B39], // Rich Taupe
    [0xFFE6DFE0, 0xFF76474D], // Vintage Burgundy
    [0xFFE5EAE8, 0xFF4A665E], // Forest Sage
    [0xFFE9E2D9, 0xFF695E4A], // Warm Umber
    [0xFFE2E4E9, 0xFF4B5874], // Slate Navy
    [0xFFE8DFE3, 0xFF815B69], // Muted Mauve
    [0xFFE4E7E5, 0xFF536465], // Steel Grey
    [0xFFE9DDD3, 0xFF8B6146], // Cognac Brown
    [0xFFE5E1E6, 0xFF635B76], // Deep Lavender
    [0xFFE2E6E4, 0xFF4A6670], // Storm Blue
    [0xFFE6E1DC, 0xFF7D5F55]
  ];
  @override
  Widget build(BuildContext context) {
    final colors = colorPairs[currentIndex % colorPairs.length];
    return AnimatedBuilder(
      animation: animation,
      builder: _builder,
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          color: Color(colors[0]),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            borderOnForeground: false,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomPaint(
                    size: Size(width, height + 100),
                    painter: WavePainter(color: colors[1]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: child,
                ),
              ],
            )),
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    var transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY(animation.value);
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }
}


//Wavy Pointer for Design

class WavePainter extends CustomPainter {
  final int color;

  WavePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(color).withOpacity(0.7) // Darker purple color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from the left bottom
    path.moveTo(0, size.height * 0.99);

    // Create wave pattern
    // final firstControlPoint = Offset(size.width * 0.25, size.height * 0.55);
    // final firstEndPoint = Offset(size.width * 0.35, size.height * 1);
    // path.quadraticBezierTo(
    //   firstControlPoint.dx,
    //   firstControlPoint.dy,
    //   firstEndPoint.dx,
    //   firstEndPoint.dy,
    // );

    final secondControlPoint = Offset(size.width * 0.6, size.height );
    final secondEndPoint = Offset(size.width, size.height * 0.5);
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