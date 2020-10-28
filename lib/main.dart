import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/utils/animationSrc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: _introScreen(),
    );
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        imageBackground: AssetImage("assets/splashImage.jpg"),
        // gradientBackground: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [Color(0xffED213A), Color(0xff93291E)],
        // ),
        navigateAfterSeconds: MyHomePage(),
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
            height: 250, child: Lottie.asset("assets/animations/loading.json")),
      )
    ],
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherClass climaTempo;
  Future response;
  Position latLong;
  Future<Position> position;
  AnimationFile urlAnimation;
  var newFormat = DateFormat("EEEE", "pt_Br");
  String weekDayName = "";
  double latitude = 0;
  double longitude = 0;
  http.Response teste;
  Future espera;
  List<String> diasSemana = [
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
    "Domingo"
  ];

  @override
  void initState() {
    super.initState();
    awaitHttpResponse();
  }

  awaitHttpResponse() async {
    position = _getPosition();

    response = _getWeather();
    espera = Future.wait([response]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarOpacity: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.subject,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 32,
                bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: espera,
                  // AsyncSnapshot<List<dynamic>>
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        //  ||
                        //         snapshot.connectionState == ConnectionState.none
                        ? Container(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: Lottie.asset(
                                      "assets/animations/${urlAnimation.url}.json"),
                                ),
                                Text(
                                  "${climaTempo.current.feelslikeC.round()}ºC",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
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
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.3,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(child: CircularProgressIndicator()),
                          );
                  },
                ),
                FutureBuilder(
                    future: espera,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          //  ||
                          //         snapshot.connectionState == ConnectionState.none
                          ? Container(
                              height: 150,
                              // color: Colors.red,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    climaTempo.forecast.forecastday.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.white.withOpacity(0.2),
                                        ),
                                    width: 105,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${DateFormat("EEEE", "pt_Br").format(DateTime.parse(climaTempo.forecast.forecastday[index].date))}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Lottie.asset(
                                                    "assets/animations/${getUrlAnimation(climaTempo.forecast.forecastday[index].day.condition)}.json"),
                                                Text(
                                                  "${climaTempo.forecast.forecastday[index].day.maxtempC.round()}ºC",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : CircularProgressIndicator();
                    })
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/ny.jpg"),
              ),
            ),
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Text("B"),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
