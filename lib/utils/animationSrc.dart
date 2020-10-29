class AnimationFile {
  String condition;
  String url;
  AnimationFile.returnFileUrl(this.condition) {
    switch (condition) {
      case "Parcialmente nublado":
        this.url = "partly-cloudy";
        break;
      case "Sol":
        this.url = "sunny";
        break;
      case "Possibilidade de chuva irregular":
        this.url = "partly-shower";
        break;
      case "Chuva forte":
        this.url = "weather-thunder";
        break;
      case "Chuva moderada ou forte com trovoada":
        this.url = "weather-thunder";
        break;
      case "Encoberto":
        this.url = "weather-cloudynight";
        break;
      case "Chuva moderada":
        this.url = "weather-windy";
        break;
    }
  }
}
