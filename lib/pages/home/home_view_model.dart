import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherApp/models/search_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/utils/animationSrc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class HomeViewModel extends State<Home> {
  WeatherClass climaTempo;
  SearchModelResponse searchList;

  Position latLong;
  Future searchEndpoint;

  Future<Position> position;
  List<WeatherClass> listWeathers = [];
  AnimationFile urlAnimation;
  var newFormat = DateFormat("EEEE", "pt_Br");
  String weekDayName = "";

  Future waitAllCities;

  Future espera;
  List<String> arrayImages = [
    "gotham.jpg",
    "lossantos.jpg",
    "ny.jpg",
    "cityArt1.jpeg",
    "cityArt2.jpeg",
    "cityArt3.jpeg",
    "cityArt4.jpeg",
    "cityArt5.jpeg",
    "cityArt6.jpeg",
    "cityArt7.jpeg",
    "cityArt9.jpeg",
    "cityArt10.jpeg",
    "cityArt11.jpeg",
    "cityArt12.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    awaitHttpResponse();
    arrayImages.shuffle();
  }

  void configurandoModalBottomSheet(context, Forecastday dayStats) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        var container = Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          width: MediaQuery.of(context).size.width * 0.55,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mínima:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(dayStats.day.mintempC.toString())
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Máxima:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(dayStats.day.maxtempC.toString())
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Possibilidade de chuva:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("${dayStats.day.dailyChanceOfRain}%")
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Possibilidade de neve:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("${dayStats.day.dailyChanceOfSnow}%")
                ],
              ),
              Divider(),
            ],
          ),
        );
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,

                      end: Alignment
                          .topRight, // 10% of the width, so there are ten blinds.
                      colors: [
                        const Color(0xffc94324),
                        const Color(0xff3b5cbf),
                        const Color(0xff04014a)
                      ], // red to yellow
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        // Text(
                        //   DateFormat("EEEE", "pt_Br").format(
                        //     DateTime.parse(dayStats.date),
                        //   ),
                        //   style: TextStyle(fontSize: 24),
                        // ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dayStats.hour.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                width: 85,
                                margin: EdgeInsets.only(right: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // height: 10,
                                      child: Lottie.asset(
                                          "assets/animations/${AnimationFile.returnFileUrl(condition: dayStats.hour[index].condition.text, hour: dayStats.hour[index].time.split(" ")[1]).url.toString()}.json"),
                                    ),
                                    Text(
                                      "${dayStats.hour[index].time.split(" ")[1]}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.all(8),
                            // height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 6),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Iluminação da lua:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "${dayStats.astro.moonIllumination}%")
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Nascer do sol:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(dayStats.astro.sunrise)
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Pôr do sol:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(dayStats.astro.sunset)
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Fase lunar:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(dayStats.astro.moonPhase)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    container,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        // Divider(
                        //   endIndent: 15,
                        //   indent: 15,
                        //   thickness: 1,
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  awaitHttpResponse() async {
    position = _getPosition();

    _getSearchEndpoint();
  }

  Future _getSingleCityWeather(SearchModelResponse a) async {
    http.Response reqLatLong;

    a.searchModel.reversed.forEach((element) async {
      reqLatLong = await http.get(
          "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&days=5&lang=pt&q=${element.lat},${element.lon}");

      var decodedJson = convert.jsonDecode(reqLatLong.body);
      WeatherClass cityToAdd = WeatherClass.fromJson(decodedJson);
      listWeathers.removeWhere(
          (element) => element.location.name == cityToAdd.location.name);
      setState(() {
        listWeathers.add(cityToAdd);
      });

      // return listWeathers;
    });
  }

  Future _getSearchEndpoint() async {
    var latElong = await position;
    var url =
        "http://api.weatherapi.com/v1/search.json?key=69768138ce1c4d0184702438202310&q=${latElong.latitude},${latElong.longitude}";

    http.Response _reponse = await http.get(url);

    var decodedJson = convert.jsonDecode(_reponse.body);
    searchList = SearchModelResponse.fromJson(decodedJson);

    waitAllCities = _getSingleCityWeather(searchList);
  }

  String getUrlAnimation(Condition condition, String hour) {
    AnimationFile url =
        AnimationFile.returnFileUrl(condition: condition.text, hour: hour);
    // String newUrl = url.url;
    return url.url;
  }

  Future<Position> _getPosition() async {
    latLong = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return latLong;
  }
}
