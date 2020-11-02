import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherApp/components/card_weather_main.dart';
import 'package:weatherApp/components/card_weather_sub.dart';
import 'package:weatherApp/components/shimmer_screen.dart';
import 'package:weatherApp/pages/home/home_view_model.dart';

class HomeView extends HomeViewModel {
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
        body: listWeathers.length == 0
            ? ShimerScreen(
                imgName: arrayImages[0],
              )
            : CarouselSlider.builder(
                itemCount: listWeathers.length,
                itemBuilder: (context, index) {
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
                                listWeathers[index].location.name,
                                style: TextStyle(
                                    fontFamily: "Lobster",
                                    color: Colors.white,
                                    fontSize: 32),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CardMainWeather(listWeathers[index]),
                          ],
                        ),
                        CardWeatherSub(listWeathers[index],
                            configurandoModalBottomSheet, getUrlAnimation),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/${arrayImages[index]}"),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                  );
                },
                options: CarouselOptions(
                    // aspectRatio: 1,

                    viewportFraction: 1,
                    height: MediaQuery.of(context).size.height,
                    enableInfiniteScroll: false),
              )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
