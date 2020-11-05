import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherApp/components/modals/bottom_sheet.dart';
import 'package:weatherApp/database/databaseHelper.dart';
import 'package:weatherApp/models/img_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/utils/animationSrc.dart';
import 'package:weatherApp/utils/imagesList.dart';

abstract class HomeViewModel extends State<Home> {
  String weekDayName =
      DateFormat("EEEE", "pt_Br").format(DateTime.now()).toString();

  List<String> arrayImages = ImagesList().returnArray();
  DataBaseHelper db = DataBaseHelper();

  List<ImgModel> contatos = List<ImgModel>();

  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  String localFilePath;

  @override
  void initState() {
    super.initState();
    initPlayer();
    arrayImages.shuffle();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    // advancedPlayer.durationHandler = (d) => setState(() {
    //       _duration = d;
    //     });

    // advancedPlayer.positionHandler = (p) => setState(() {
    //       _position = p;
    //     });

    audioCache.play("audios/sunny.mp3");
  }

  void configurandoModalBottomSheet(context, Forecastday dayStats) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return BottomSheetCustom(dayStats);
      },
    );
  }

  String getUrlAnimation(Condition condition, String hour) {
    AnimationFile url =
        AnimationFile.returnFileUrl(condition: condition.text, hour: hour);
    // String newUrl = url.url;
    return url.url;
  }
}
