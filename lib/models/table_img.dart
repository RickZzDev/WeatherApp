class ImgModel {
  int id;
  String cityId;
  String imgPath;

  ImgModel(this.id, this.cityId, this.imgPath);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"id": id, "cityId": cityId, "imgPath": imgPath};
    return map;
  }

  ImgModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cityId = map['cityId'];
    imgPath = map['imgPath'];
  }
}
