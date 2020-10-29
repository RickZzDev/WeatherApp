class SearchModelResponse {
  List<SearchModel> searchModel = [];

  SearchModelResponse({this.searchModel});
  SearchModelResponse.fromJson(List<dynamic> list) {
    list.forEach((element) {
      searchModel.add(SearchModel.fromJson(element));
    });
  }
}

class SearchModel {
  int id;

  double lat;
  double lon;

  SearchModel({
    this.id,
    this.lat,
    this.lon,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['lat'] = this.lat;
    data['lon'] = this.lon;

    return data;
  }
}
