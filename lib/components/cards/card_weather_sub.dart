import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherApp/models/weather_model.dart';

class CardWeatherSub extends StatelessWidget {
  final WeatherClass _weatherClass;
  final Function _showModal;
  final Function _getUrlAnimation;
  CardWeatherSub(this._weatherClass, this._showModal, this._getUrlAnimation);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _weatherClass.forecast.forecastday.length,
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.2),
                ),
            width: 105,
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text(
                  "${DateFormat("EEEE", "pt_Br").format(DateTime.parse(_weatherClass.forecast.forecastday[i].date))}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showModal(
                        context, _weatherClass.forecast.forecastday[i]),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Lottie.asset(
                              "assets/animations/${_getUrlAnimation(_weatherClass.forecast.forecastday[i].day.condition, '12:00')}.json"),
                          Text(
                            "${_weatherClass.forecast.forecastday[i].day.maxtempC.round()}ºC",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
