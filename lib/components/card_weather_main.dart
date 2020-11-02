import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/utils/animationSrc.dart';

class CardMainWeather extends StatelessWidget {
  final String weekDayName =
      DateFormat("EEEE", "pt_Br").format(DateTime.now()).toString();
  final WeatherClass watherStatus;
  CardMainWeather(this.watherStatus);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            child: Lottie.asset(
                "assets/animations/${AnimationFile.returnFileUrl(condition: watherStatus.current.condition.text, hour: watherStatus.current.lastUpdated.split(" ")[1]).url.toString()}.json"),
          ),
          Text(
            "${watherStatus.current.feelslikeC.round()}ºC",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "$weekDayName",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            "${DateFormat("d", "pt_Br").format(DateTime.now())}/${DateFormat("MM").format(DateTime.now())}/${DateFormat("y").format(DateTime.now())}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
