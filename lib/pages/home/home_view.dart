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
  int _selectedImg;
  int _myIndexLocal = 0;

  void sendImgToDb(String path, String cityName) async {
    Map<String, dynamic> map = {"cityName": cityName, "imgPath": path};
    ImgModel _imgModelFromMap = ImgModel.fromMap(map);
    await db.insertImgCity(_imgModelFromMap);
    setState(() {
      _listWeathers[_myIndexLocal].imgPath = path;
    });
  }

  void _showModal(BuildContext _context) {
    showDialog(
        context: _context,
        child: ModalChooseImage(sendImgToDb,
            _listWeathers[_myIndexLocal].location.name, arrayImages));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarOpacity: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
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
        body: _listWeathers.length == 0
            ? ShimerScreen(
                imgName: arrayImages[0],
              )
            : CarouselSlider.builder(
                itemCount: _listWeathers.length,
                itemBuilder: (context, int _myIndex) {
                  _myIndexLocal = _myIndex;
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
                                _listWeathers[_myIndex].location.name,
                                style: TextStyle(
                                    fontFamily: "Lobster",
                                    color: Colors.white,
                                    fontSize: 32),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CardMainWeather(_listWeathers[_myIndex]),
                          ],
                        ),
                        CardWeatherSub(_listWeathers[_myIndex],
                            configurandoModalBottomSheet, getUrlAnimation),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _listWeathers[_myIndex].imgPath != null
                            ? AssetImage(
                                "assets/${_listWeathers[_myIndex].imgPath}")
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
