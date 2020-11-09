import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
  dynamic soundCache = false;
  int myIndexLocal = 0;
  File localImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    testeFire();
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
    // if (state == AppLifecycleState.resumed) {
    //   advancedPlayer
    //       .resume(); // Audio player is a custom class with resume and pause static methods
    // } else {
    //   advancedPlayer.stop();
    // }
    advancedPlayer.stop();
  }

  void testeFire() async {
    await firebase_core.Firebase.initializeApp();
    print(firebase_storage.FirebaseStorage.instance.bucket);
  }

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        localImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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

  void verifySound(dynamic actualValue) {
    // audios/sunny.mp3
    actualValue == true || actualValue == null
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
