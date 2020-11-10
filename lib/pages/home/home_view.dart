import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherApp/components/cards/card_weather_main.dart';
import 'package:weatherApp/components/cards/card_weather_sub.dart';
import 'package:weatherApp/components/modals/modal_img.dart';
import 'package:weatherApp/components/shimmers/shimmer_screen.dart';
import 'package:weatherApp/models/img_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home_view_model.dart';

class HomeView extends HomeViewModel {
  List<WeatherClass> _listWeathers = [];

  HomeView(this._listWeathers);

  void sendImgToDb(String path, String cityName) async {
    Map<String, dynamic> map = {
      "cityName": cityName,
      "imgPath": path,
      "isImgFromDevice": 0
    };
    ImgModel _imgModelFromMap = ImgModel.fromMap(map);
    await db.insertImgCity(_imgModelFromMap, 0);
    setState(() {
      localListWeather[myIndexLocal].isImgFromDevice = 0;
      localListWeather[myIndexLocal].imgPath = path;
    });
  }

  void _showModal(BuildContext _context) {
    showDialog(
      context: _context,
      child: ModalChooseImage(sendImgToDb,
          _listWeathers[myIndexLocal].location.name, arrayImages, getImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = new CarouselController();
    // carouselController.
    localListWeather = _listWeathers;
    return Scaffold(
        appBar: AppBar(
          // toolbarOpacity: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              alignment: Alignment.centerRight,
              onPressed: () => setSoundPreferences(),
              icon: Icon(
                soundCache == true || soundCache == null
                    ? Icons.volume_up_rounded
                    : Icons.volume_off,
                color: Colors.white,
              ),
            ),
            IconButton(
              alignment: Alignment.centerRight,
              onPressed: () => _showModal(context),
              icon: Icon(
                Icons.build_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: localListWeather.length == 0
            ? ShimerScreen(
                imgName: arrayImages[0],
              )
            : CarouselSlider.builder(
                itemCount: localListWeather.length,
                itemBuilder: (context, int _myIndex) {
                  myIndexLocal = _myIndex;
                  return Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: 32,
                        bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Text(
                                localListWeather[_myIndex].location.name,
                                style: TextStyle(
                                    fontFamily: "Lobster",
                                    color: Colors.white,
                                    fontSize: 32),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CardMainWeather(localListWeather[_myIndex]),
                          ],
                        ),
                        CardWeatherSub(localListWeather[_myIndex],
                            configurandoModalBottomSheet, getUrlAnimation),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: localListWeather[_myIndex].imgPath != null
                            ? localListWeather[_myIndex].isImgFromDevice == 1
                                ? FileImage(
                                    File(localListWeather[_myIndex].imgPath))
                                : AssetImage(
                                    "assets/${localListWeather[_myIndex].imgPath}")
                            : AssetImage("assets/${arrayImages[_myIndex]}"),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                  );
                },
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: MediaQuery.of(context).size.height,
                    enableInfiniteScroll: false),
              )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
