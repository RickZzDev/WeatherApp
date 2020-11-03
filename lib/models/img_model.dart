class ImgModel {
  int id;
  String cityName;
  String imgPath;

  ImgModel(this.id, this.cityName, this.imgPath);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "cityName": cityName,
      "imgPath": imgPath
    };
    return map;
  }

  ImgModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cityName = map['cityName'];
    imgPath = map['imgPath'];
  }
}
