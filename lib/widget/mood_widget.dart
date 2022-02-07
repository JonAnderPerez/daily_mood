import 'dart:math';

import 'package:DailyMood/controller/swipe_controller.dart';
import 'package:flutter/material.dart';

class MoodWidget extends StatefulWidget {

  String dayText; //Dia de la semana
  String dayNum; //Dia del mes
  int numCard; //Valor para modificar las card

  MoodWidget({ 
    Key? key,
    this.dayText = "DIA",
    this.dayNum = "00/00",
    this.numCard = 0,
  }) : super(key: key);

  @override
  _MoodWidgetState createState() => _MoodWidgetState();
}

class _MoodWidgetState extends State<MoodWidget> with SingleTickerProviderStateMixin {

  double height = 0.6; //Alto de la tarjeta
  double width = 0.8; //Ancho de la tarjeta
  double offset = 0; //Offset para las tarjetas traseras
  double opacity = 1.0; //Opacidad de la tarjeta
  bool swipe = true; //False: Tarjetas de detras, True: Tarjeta principal
  double titleSize = 72; //Tamaño de la letra del dia de la semana
  double daySize = 36; //Tamaño del dia del mes

  String imgSrc = 'assets/images/shit.png'; //Ruta de la imagen
  double imgOpacity = 0; //Opacidad de la tarjeta

  Alignment alignment = const Alignment(0.0, 0.0); //Posicion de la card
  double rotation = 0.0; //Rotacion de la card

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _calcularValores(context); //Calcular los valores para cada card
    return GestureDetector(
      onPanUpdate: swipe ? _onPanUpdate : null,
      onPanEnd: swipe ? _onPanEnd : null,
      child: Align(
        alignment: alignment,
        child: Transform.rotate( //Rotacion de la card cuando se desplaza
          angle: (pi / 180.0) * rotation,
          child: Padding( //Padding superior para las card traseras
            padding: EdgeInsets.only(top: offset),
            child: Opacity( //Opacidad para las tarjetas traseras
              opacity: opacity,
              child: Container( //Contenedor principal
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
                            height: MediaQuery.of(context).size.width * (width / 3),
                            width: MediaQuery.of(context).size.width * (width / 3),
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
                            widget.dayText,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: titleSize,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Text(
                            widget.dayNum,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: daySize,
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
        ),
      ),
    );
  }

  void _calcularValores(BuildContext context) {
    switch (widget.numCard) {
      case 1:
        height = 0.5;
        width = 0.7;
        offset = MediaQuery.of(context).size.height * 0.15;
        opacity = 0.75;
        swipe = false;
        titleSize = 36;
        daySize = 24;
        break;
      case 2:
        height = 0.4;
        width = 0.6;
        offset = MediaQuery.of(context).size.height * 0.3;
        opacity = 0.75;
        swipe = false;
        titleSize = 24;
        daySize = 16;
        break;
      default:
        break;
    }
    setState(() {});
  }


  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      alignment = Alignment( //Posicion
        alignment.x + 15 * details.delta.dx / MediaQuery.of(context).size.width, 
        0.0
        );
      rotation = alignment.x * 4; //Rotacion

      if(alignment.x > 0.1) {
        showImage(Direction.right, alignment.x / 5);
      } else if(alignment.x < -0.1) {
        showImage(Direction.left, alignment.x / 5);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if(alignment.x > 3.0) {

    } else if(alignment.x < -3.0) {

    } else {
      setState(() {
        alignment = Alignment(0.0, 0.0);
        rotation = 0.0;
        showImage(Direction.down, 0.0); //Quitamos la imagen si esta en el centro
      });
    }
  }

  void showImage(Direction direccion, double opacity) {
    if(opacity < 0.0) opacity *= -1; //Convertimos el valor en positivo 
    if(opacity >= 1.0) opacity = 1.0; //Evitamos que el valor sea mayor que 1

    if(direccion == Direction.right) {
      imgSrc = 'assets/images/heart.png';
      imgOpacity = opacity;
    } else if(direccion == Direction.left) {
      imgSrc = 'assets/images/shit.png';
      imgOpacity = opacity;
    } else {
      imgOpacity = 0.0;
    }
  }
}

class CardsAnimation {
  /*static Animation<Alignment> backCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[0], end: cardsAlign[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Size?> backCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[2], end: cardsSize[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Alignment> middleCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[1], end: cardsAlign[2]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.5, curve: Curves.easeIn)));
  }

  static Animation<Size?> middleCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[1], end: cardsSize[0]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.5, curve: Curves.easeIn)));
  }*/

  static Animation<Alignment> frontCardDisappearAlignmentAnim(AnimationController parent, Alignment beginAlign) {
    return AlignmentTween(
              begin: beginAlign,
              end: Alignment(
                  beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0,
                  0.0) // Has swiped to the left or right?
              )
          .animate(CurvedAnimation(
              parent: parent, curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
  }
}