import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherApp/components/card_weather_main.dart';
import 'package:weatherApp/components/card_weather_sub.dart';
import 'package:weatherApp/components/shimmer_screen.dart';
import 'package:weatherApp/models/img_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home_view_model.dart';

class HomeView extends HomeViewModel {
  List<WeatherClass> _listWeathers = [];
  HomeView(this._listWeathers);
  int _selectedImg;
  int _myIndexLocal = 0;

  void sendImgToDb(String path, String cityName) {
    Map<String, dynamic> map = {"cityName": cityName, "imgPath": path};
    ImgModel _imgModelFromMap = ImgModel.fromMap(map);
    db.insertImgCity(_imgModelFromMap).then((value) => print(value));
  }

  void _showModal(BuildContext _context) {
    showDialog(
      context: _context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Você esta alterando o wallpaper de:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _listWeathers[_myIndexLocal].location.name,
                        style: TextStyle(fontFamily: "Lobster", fontSize: 18),
                      ),
                      Container(
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          children: List.generate(arrayImages.length, (index) {
                            return Center(
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _selectedImg = index;
                                }),
                                onLongPress: () {
                                  return showDialog(
                                    context: context,
                                    child: Dialog(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.75,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/${arrayImages[index]}"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: _selectedImg == index ? 3 : 0,
                                        color: Colors.green),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/${arrayImages[index]}"),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 8),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: () => sendImgToDb(arrayImages[_selectedImg.toInt()],
                    _listWeathers[_selectedImg].location.name),
                child: Text("Salvar wallpaper"),
              )
            ],
          );
        },
      ),
    );
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
