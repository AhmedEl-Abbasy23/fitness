import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitness/models/exercise_hub_model.dart';
import 'package:fitness/modules/exercise_start_screen/exercise_start_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  ExerciseHub? exerciseHub;

  @override
  void initState() {
    getExercises();
    super.initState();
  }

  void getExercises() async {
    final response = await http.get(Uri.parse(apiURL));
    var body = response.body;
    var decodedJson = jsonDecode(body);
    exerciseHub = ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: const [
            Icon(Icons.fitness_center),
            SizedBox(width: 5.0),
            Text('Fitness'),
          ],
        ),
        titleTextStyle: const TextStyle(fontSize: 23.0),
      ),
      body: Container(
        child: exerciseHub != null
            ? ListView(
                children: exerciseHub!.exercises.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseStartScreen(
                                    exercises: e,
                                  )));
                    },
                    child: Hero(
                      tag: e.id,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: e.thumbnail,
                                placeholder: (context, url) => Image(
                                  image: const AssetImage(
                                      "assets/placeholder.jpg"),
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                              ),
                              /*FadeInImage(
                                image: NetworkImage(e.thumbnail),
                                placeholder:
                                    const AssetImage("assets/placeholder.jpg"),
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),*/
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF000000),
                                    Color(0x00000000),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                )),
                              ),
                            ),
                            Container(
                              height: 250,
                              padding: const EdgeInsets.only(
                                left: 10,
                                bottom: 10,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            : const Center(
                child: CircularProgressIndicator(
                color: Color(0xFF192A56),
              )),
      ),
    );
  }
}
