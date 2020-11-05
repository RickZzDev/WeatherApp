import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weatherApp/models/img_model.dart';
import 'package:weatherApp/models/search_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/database/databaseHelper.dart';
import 'package:weatherApp/utils/imagesList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SearchModelResponse searchList;
  Position latLong;
  Future<Position> position;
  List<WeatherClass> listWeathers = [];
  List<ImgModel> imgsDb;

  DataBaseHelper db = DataBaseHelper();

  Future _getSingleCityWeather(SearchModelResponse a) async {
    http.Response reqLatLong;

    a.searchModel.forEach((element) async {
      reqLatLong = await http.get(
          "http://api.weatherapi.com/v1/forecast.json?key=69768138ce1c4d0184702438202310&days=5&lang=pt&q=${element.lat},${element.lon}");

      var decodedJson = convert.jsonDecode(reqLatLong.body);
      WeatherClass cityToAdd = WeatherClass.fromJson(decodedJson);
      listWeathers.removeWhere(
          (element) => element.location.name == cityToAdd.location.name);

      await verifyImages(cityToAdd);
    });
  }

  Future verifyImages(WeatherClass _city) async {
    setState(() {
      imgsDb.length > 0
          ? imgsDb.forEach((img) {
              img.cityName == _city.location.name
                  ? _city.imgPath = img.imgPath
                  : null;
            })
          : null;
      listWeathers.add(_city);
    });
  }

  Future<dynamic> _getSearchEndpoint() async {
    var latElong = await position;
    var url =
        "http://api.weatherapi.com/v1/search.json?key=69768138ce1c4d0184702438202310&q=${latElong.latitude},${latElong.longitude}";

    http.Response _reponse = await http.get(url);

    var decodedJson = convert.jsonDecode(_reponse.body);
    searchList = SearchModelResponse.fromJson(decodedJson);

    await _getSingleCityWeather(searchList);
  }

  Future<Position> _getPosition() async {
    latLong = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return latLong;
  }

  awaitHttpResponse() async {
    imgsDb = await db.getAllImgsCities();
    position = _getPosition();

    _getSearchEndpoint();
  }

  @override
  void initState() {
    super.initState();
    awaitHttpResponse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _introScreen(listWeathers),
    );
  }
}

Widget _introScreen(List<WeatherClass> _list) {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 10,
        imageBackground: AssetImage("assets/cityArt8.jpeg"),
        navigateAfterSeconds: Home(
          listWeather: _list,
        ),
        loaderColor: Colors.transparent,
      ),
      Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.4),
              ),
            ),
          )
        ],
      ),
      Center(
        child: Container(
          height: 250,
          child: Lottie.asset("assets/animations/loading.json"),
        ),
      )
    ],
  );
}
