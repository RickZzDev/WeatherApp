import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherApp/components/bottom_sheet.dart';
import 'package:weatherApp/models/search_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/utils/animationSrc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherApp/utils/imagesList.dart';

abstract class HomeViewModel extends State<Home> {
  SearchModelResponse searchList;
  Position latLong;
  Future<Position> position;
  List<WeatherClass> listWeathers = [];

  String weekDayName =
      DateFormat("EEEE", "pt_Br").format(DateTime.now()).toString();

  Future waitAllCities;

  Future espera;
  List<String> arrayImages = ImagesList().returnArray();

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
        return BottomSheetCustom(dayStats);
      },
    );
  }

  awaitHttpResponse() async {
    position = _getPosition();

    _getSearchEndpoint();
  }

  Future _getSingleCityWeather(SearchModelResponse a) async {
    http.Response reqLatLong;

    a.searchModel.forEach((element) async {
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
