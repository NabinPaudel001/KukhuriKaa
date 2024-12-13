import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

class CircularProgress extends StatelessWidget {
  final String title;
  final double progress;
  final Color foregroundColor;
  final Color backgroundColor;
  final String unit;
  CircularProgress({
    super.key,
    required this.title,
    required this.progress,
    required this.foregroundColor,
    this.backgroundColor = const Color.fromARGB(255, 238, 231, 231),
    required this.unit,
  });

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar(
      width: 175,
      height: 200,
      // width ÷ height
      valueNotifier: _valueNotifier,
      progress: progress,
      startAngle: 225,
      sweepAngle: 270,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      foregroundStrokeWidth: 20,
      backgroundStrokeWidth: 20,
      animation: true,
      seekSize: 10,
      seekColor: const Color(0xffeeeeee),
      child: Center(
        child: ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (_, double value, __) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${value.toInt()}${unit}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 36),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ],
                )),
      ),
    );
  }
}
