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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: _getMoodWidget(context),
      ),
    );
  }

  Widget _getMoodWidget(BuildContext context) {
    String dayText = "LUNES"; //Dia de la semana
    String dayNum = "10/01"; //Dia del mes
    double height = 0.6; //Alto de la tarjeta
    double width = 0.8; //Ancho de la tarjeta
    double offset = 0; //Offset para las tarjetas traseras
    double opacity = 1.0; //Opacidad de la tarjeta
    double imgSize = MediaQuery.of(context).size.width * (width / 3); //Tamaño de la imagen
    String imgSrc = 'assets/images/shit.png'; //Ruta de la imagen
    double imgOpacity = 1.0; //Opacidad de la tarjeta

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: offset),
        child: Opacity(
          opacity: opacity,
          child: Container(
            height: MediaQuery.of(context).size.height * height,
            width: MediaQuery.of(context).size.width * width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * (height / 3),
                  width: MediaQuery.of(context).size.width * width,
                  child: Opacity(
                    opacity: imgOpacity,
                    child: Center(
                      child: Image.asset(
                        imgSrc,
                        height: imgSize,
                        width: imgSize,
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (height / 3),
                  width: MediaQuery.of(context).size.width * width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dayText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 72,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        dayNum,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}