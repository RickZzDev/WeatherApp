import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherApp/models/search_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/utils/animationSrc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class HomeViewModel extends State<Home> {
  WeatherClass climaTempo;
  SearchModelResponse searchList;
  Future response;
  Position latLong;
  Future searchEndpoint;
  Future futureListWeather;
  Future<Position> position;
  List<WeatherClass> listWeathers = [];
  AnimationFile urlAnimation;
  var newFormat = DateFormat("EEEE", "pt_Br");
  String weekDayName = "";
  double latitude = 0;
  double longitude = 0;
  http.Response teste;
  http.Response teste2;
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

  void configurandoModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
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
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("Sexta-Feira"),
                      Container(
                        color: Colors.black,
                        height: 85,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("ASD");
                          },
                        ),
                      )
                    ],
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

    response = _getWeather();

    espera = Future.wait([response]);

    _getSearchEndpoint();
  }

  Future _getSingleCityWeather(SearchModelResponse a) async {
    http.Response reqLatLong;

    a.searchModel.reversed.forEach((element) async {
      reqLatLong = await http.get(
          "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&days=5&lang=pt&q=${element.lat},${element.lon}");

      var decodedJson = convert.jsonDecode(reqLatLong.body);
      setState(() {
        listWeathers.add(WeatherClass.fromJson(decodedJson));
      });

      // return listWeathers;
    });
  }

  Future _getSearchEndpoint() async {
    http.Response reqLatLong;
    var latElong = await position;
    var url =
        "http://api.weatherapi.com/v1/search.json?key=69768138ce1c4d0184702438202310&q=${latElong.latitude},${latElong.longitude}";

    teste2 = await http.get(url);

    var decodedJson = convert.jsonDecode(teste2.body);
    searchList = SearchModelResponse.fromJson(decodedJson);
    _getSingleCityWeather(searchList);
  }

  String getUrlAnimation(Condition condition) {
    AnimationFile url = AnimationFile.returnFileUrl(condition.text);
    // String newUrl = url.url;
    return url.url;
  }

  Future<Position> _getPosition() async {
    latLong = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return latLong;
  }

  Future _getWeather() async {
    var latElong = await position;
    var url =
        // "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&lang=pt&hour=12&q=Jandira";
        // "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&lang=pt&hour=12&days=5&q=Jandira";
        "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&lang=pt&days=5&hour=12&q=${latElong.latitude},${latElong.longitude}";

    teste = await http.get(url);

    var decodedJson = convert.jsonDecode(teste.body);
    climaTempo = WeatherClass.fromJson(decodedJson);
    urlAnimation =
        AnimationFile.returnFileUrl(climaTempo.current.condition.text);
    weekDayName = newFormat.format(DateTime.now());
  }
}
