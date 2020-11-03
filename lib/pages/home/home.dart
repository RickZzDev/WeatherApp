import 'package:flutter/cupertino.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home_view.dart';

class Home extends StatefulWidget {
  List<WeatherClass> listWeather = [];
  Home({Key key, this.listWeather}) : super(key: key);

  @override
  HomeView createState() => HomeView(this.listWeather);
}
