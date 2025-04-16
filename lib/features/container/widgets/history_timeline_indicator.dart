// The vertical timeline indicator, drawing a line, a circle, and gold diamonds.
import 'package:flutter/material.dart';

class HistoryTimelineIndicator extends StatelessWidget {
  const HistoryTimelineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    const Color timelineColor = Colors.amber;
    const Color circleColor = Colors.white;

    return SizedBox(
      height: 220, // Adjust based on content height
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Vertical line (from top to bottom except where circles appear)
          Positioned.fill(
            child: Padding(
              // Leave space for the circle at top and bottom
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 19.6,
              ),
              child: Container(width: 2, color: timelineColor),
            ),
          ),

          // Top circle
          Positioned(top: 0, child: _Circle(color: circleColor)),

          // Middle decorative diamond
          Positioned(top: 68, child: _Diamond(color: timelineColor, size: 4)),

          // Another diamond (optional)
          Positioned(top: 84, child: _Diamond(color: timelineColor, size: 10)),

          // Middle decorative diamond
          Positioned(top: 106, child: _Diamond(color: timelineColor, size: 4)),
        ],
      ),
    );
  }
}

// A simple circle widget for the timeline
class _Circle extends StatelessWidget {
  final Color color;
  const _Circle({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        // border: Border.all(color: Colors.amber, width: 2),
      ),
    );
  }
}

// A small diamond shape widget
class _Diamond extends StatelessWidget {
  final Color color;
  final double size;
  const _Diamond({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * 3.14159 / 180, // rotate 45 deg to form a diamond
      child: Container(width: size, height: size, color: color),
    );
  }
}
