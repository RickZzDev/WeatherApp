import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherApp/components/shimmer_screen.dart';
import 'package:weatherApp/pages/home/home_view_model.dart';
import 'package:weatherApp/utils/animationSrc.dart';

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
                        FutureBuilder(
                          future: espera,
                          // AsyncSnapshot<List<dynamic>>
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.done
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                              child: Lottie.asset(
                                                  "assets/animations/${AnimationFile.returnFileUrl(listWeathers[index].current.condition.text).url.toString()}.json"),
                                            ),
                                            Text(
                                              "${listWeathers[index].current.feelslikeC.round()}ºC",
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
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          },
                        ),
                        FutureBuilder(
                          future: espera,
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.done
                                ? Container(
                                    height: 150,
                                    // color: Colors.red,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: climaTempo
                                          .forecast.forecastday.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.white.withOpacity(0.2),
                                              ),
                                          width: 105,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${DateFormat("EEEE", "pt_Br").format(DateTime.parse(listWeathers[index].forecast.forecastday[i].date))}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      configurandoModalBottomSheet(
                                                          context),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Lottie.asset(
                                                            "assets/animations/${getUrlAnimation(listWeathers[index].forecast.forecastday[i].day.condition)}.json"),
                                                        Text(
                                                          "${listWeathers[index].forecast.forecastday[i].day.maxtempC.round()}ºC",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
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
                          },
                        )
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
