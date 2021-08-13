import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fitness/models/exercise_hub_model.dart';
import 'package:fitness/modules/exercise_screen/exercise_screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExerciseStartScreen extends StatefulWidget {
  final Exercises exercises;

  const ExerciseStartScreen({required this.exercises});

  @override
  _ExerciseStartScreenState createState() => _ExerciseStartScreenState();
}

class _ExerciseStartScreenState extends State<ExerciseStartScreen> {
  int seconds = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Hero(
          tag: widget.exercises.id,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.exercises.thumbnail,
                placeholder: (context, url) => Image(
                  image: const AssetImage("assets/placeholder.jpg"),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF000000),
                      Color(0x00000000),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: SleekCircularSlider(
                    appearance: const CircularSliderAppearance(),
                    onChange: (double value) {
                      seconds = value.toInt();
                    },
                    initialValue: 30.0,
                    min: 5.0,
                    max: 60.0,
                    innerWidget: (val) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${val.toInt()} s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseScreen(
                          exercises: widget.exercises,
                          seconds: seconds,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Start Exercise',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFE83350),
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
