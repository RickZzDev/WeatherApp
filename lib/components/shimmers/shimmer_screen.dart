import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerScreen extends StatelessWidget {
  final imgName;
  ShimerScreen({this.imgName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15, left: 32, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 4),
                height: 45,
                child: Opacity(
                  opacity: 0.8,
                  child: Shimmer.fromColors(
                    child: const Text(
                      'Loading',
                      style: TextStyle(
                          fontFamily: "Lobster",
                          color: Colors.white,
                          fontSize: 32),
                    ),
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    enabled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                enabled: true,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            // color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.2),
                      ),
                  width: 105,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          width: 45,
                          height: 10,
                          color: Colors.black,
                        ),
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        enabled: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          enabled: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        // color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/$imgName"),
        ),
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}
