import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ModalChooseImage extends StatefulWidget {
  final Function _chooseImage;
  final String _cityName;
  final List<String> _arrayImages;

  ModalChooseImage(this._chooseImage, this._cityName, this._arrayImages);

  @override
  _ModalChooseImageState createState() => _ModalChooseImageState();
}

class _ModalChooseImageState extends State<ModalChooseImage> {
  int _selectedImg;
  bool _sending = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        var _myListImages = Container(
          key: ValueKey<int>(0),
          height: MediaQuery.of(context).size.height * 0.55,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            children: List.generate(widget._arrayImages.length, (index) {
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
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/${widget._arrayImages[index]}"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: _selectedImg == index ? 3 : 0,
                          color: Colors.green),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage("assets/${widget._arrayImages[index]}"),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                ),
              );
            }),
          ),
        );
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget._cityName,
                      style: TextStyle(fontFamily: "Lobster", fontSize: 18),
                    ),
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        child: _sending
                            ? Container(
                                key: ValueKey<int>(1),
                                // width: 100,
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                // color: Colors.blue,
                                child: Center(
                                  child: Lottie.asset(
                                      "assets/animations/sucess_anim.json"),
                                ),
                              )
                            : _myListImages)
                    // AnimatedSwitcher(
                    //   duration: Duration(milliseconds: 1000),
                    //   child: _myListImages,
                    // ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              color: Colors.purple,
              textColor: Colors.white,
              onPressed: !_sending
                  ? () => {
                        setState(() {
                          _sending = !_sending;
                        }),
                        widget._chooseImage(
                            widget._arrayImages[_selectedImg.toInt()],
                            widget._cityName)
                      }
                  : () => Navigator.pop(context),
              child: Text(_sending ? "Voltar" : "Salvar wallpaper"),
            )
          ],
        );
      },
    );
  }
}
