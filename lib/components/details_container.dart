import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  final String title;
  final String status;

  DetailsContainer(this.title, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(status)
        ],
      ),
    );
  }
}
