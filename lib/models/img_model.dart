class ImgModel {
  int id;
  String cityName;
  dynamic isImgFromDevice;
  String imgPath;

  ImgModel(this.id, this.cityName, this.imgPath, this.isImgFromDevice);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // "id": id,
      "cityName": cityName,
      "imgPath": imgPath,
      "isImgFromDevice": isImgFromDevice
    };
    return map;
  }

  ImgModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cityName = map['cityName'];
    imgPath = map['imgPath'];
    isImgFromDevice = map['isImgFromDevice'];
  }
}
