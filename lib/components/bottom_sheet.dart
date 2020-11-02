import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherApp/components/details_container.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/utils/animationSrc.dart';

class BottomSheetCustom extends StatelessWidget {
  final Forecastday dayStats;
  BottomSheetCustom(this.dayStats);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
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
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,

                  end: Alignment
                      .topRight, // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color(0xffc94324),
                    const Color(0xff3b5cbf),
                    const Color(0xff04014a)
                  ], // red to yellow
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dayStats.hour.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            width: 85,
                            margin: EdgeInsets.only(right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // height: 10,
                                  child: Lottie.asset(
                                      "assets/animations/${AnimationFile.returnFileUrl(condition: dayStats.hour[index].condition.text, hour: dayStats.hour[index].time.split(" ")[1]).url.toString()}.json"),
                                ),
                                Text(
                                  "${dayStats.hour[index].time.split(" ")[1]}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DetailsContainer("Iluminação da lua:",
                                          "${dayStats.astro.moonIllumination}%"),
                                      DetailsContainer("Nascer do sol:",
                                          dayStats.astro.sunrise),
                                      DetailsContainer(
                                          "Pôr do sol:", dayStats.astro.sunset),
                                      DetailsContainer("Fase lunar:",
                                          dayStats.astro.moonPhase)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 170,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DetailsContainer("Mínima:",
                                          dayStats.day.mintempC.toString()),
                                      DetailsContainer("Máxima:",
                                          dayStats.day.maxtempC.toString()),
                                      DetailsContainer("Chance de chuva:",
                                          "${dayStats.day.dailyChanceOfRain}%"),
                                      DetailsContainer("Chance de neve:",
                                          "${dayStats.day.dailyChanceOfSnow}%"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
