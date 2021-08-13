import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fitness/models/exercise_hub_model.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  const ExerciseScreen({
    required this.exercises,
    required this.seconds,
  });

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;

  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          t.cancel();
          setState(() {
            _isCompleted = true;
          });
          playAudio();
        }
        setState(() {
          _elapsedSeconds = t.tick;
        });
      },
    );
    super.initState();
  }

  playAudio() {
    // audioCache.play('cheering.wav');
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.exercises.gif,
              placeholder: (context, url) => Image(
                image: const AssetImage("assets/placeholder.jpg"),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          !_isCompleted
              ? SafeArea(
                  child: Align(
                    alignment: const Alignment(0.0, -0.97),
                    child: Text(
                      '$_elapsedSeconds/${widget.seconds} S',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFE83350),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(),
          SafeArea(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
