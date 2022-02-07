import 'package:DailyMood/controller/swipe_controller.dart';
import 'package:DailyMood/model/mood.dart';
import 'package:DailyMood/widget/mood_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Mood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DailyMood(),
    );
  }
}

class DailyMood extends StatefulWidget {
  const DailyMood({ Key? key }) : super(key: key);

  @override
  _DailyMoodState createState() => _DailyMoodState();
}

class _DailyMoodState extends State<DailyMood> {

  List<Mood> items = [
    Mood("LUNES", "10/01"),
    Mood("MARTES", "11/01"),
    Mood("MIERCOLES", "12/01"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color> [
            Color.fromARGB(255, 255, 0, 117),
            Color.fromARGB(255, 90, 0, 41)
          ],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              MoodWidget(
                dayText: "MIERCOLES",
                dayNum: "12/01",
                numCard: 2,
              ),
              MoodWidget(
                dayText: "MARTES",
                dayNum: "11/01",
                numCard: 1,
              ),
              MoodWidget(
                dayText: "LUNES",
                dayNum: "10/01",
                numCard: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}