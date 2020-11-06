import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherApp/components/modals/bottom_sheet.dart';
import 'package:weatherApp/database/databaseHelper.dart';
import 'package:weatherApp/models/img_model.dart';
import 'package:weatherApp/models/weather_model.dart';
import 'package:weatherApp/pages/home/home.dart';
import 'package:weatherApp/utils/animationSrc.dart';
import 'package:weatherApp/utils/audioSrc.dart';
import 'package:weatherApp/utils/imagesList.dart';

abstract class HomeViewModel extends State<Home> with WidgetsBindingObserver {
  String weekDayName =
      DateFormat("EEEE", "pt_Br").format(DateTime.now()).toString();

  List<String> arrayImages = ImagesList().returnArray();
  DataBaseHelper db = DataBaseHelper();

  List<ImgModel> contatos = List<ImgModel>();
  List<WeatherClass> teste = [];
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  String localFilePath;
  SharedPreferences _preferences;
  bool soundCache = false;
  int myIndexLocal = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    arrayImages.shuffle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      advancedPlayer
          .resume(); // Audio player is a custom class with resume and pause static methods
    } else {
      advancedPlayer.stop();
    }
  }

  Future getPreferencesInstance() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void initPlayer() async {
    advancedPlayer = new AudioPlayer();
    advancedPlayer.setVolume(0);
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    await getPreferencesInstance();
    verifySound(_preferences.getBool("soundCache"));
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

  void verifySound(bool actualValue) {
    // audios/sunny.mp3
    actualValue
        ? audioCache.play(
            "audios/${AudioFile.returnFileUrl(condition: teste[0].current.condition.text).url}.mp3")
        : advancedPlayer.stop();
    setState(() {
      soundCache = actualValue;
    });
  }

  setSoundPreferences() {
    soundCache = _preferences.getBool("soundCache") ?? true;
    _preferences.setBool("soundCache", !soundCache);
    verifySound(_preferences.getBool("soundCache"));
  }

  String getUrlAnimation(Condition condition, String hour) {
    AnimationFile url =
        AnimationFile.returnFileUrl(condition: condition.text, hour: hour);
    return url.url;
  }
}
