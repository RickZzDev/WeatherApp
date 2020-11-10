class AnimationFile {
  String condition;
  String url;
  String hour;
  AnimationFile.returnFileUrl({this.condition, this.hour}) {
    switch (condition) {
      case "Parcialmente nublado":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-cloudynight"
            : this.url = "partly-cloudy";
        break;
      case "Sol":
        this.url = "sunny";
        break;
      case "Possibilidade de trovoada":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "weather-thunder";
        break;

      case "CÃ©u limpo":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-night"
            : this.url = "sunny";
        break;
      case "Possibilidade de chuva irregular":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";
        break;
      case "PerÃ­odos de chuva moderada":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";
        break;
      case "Chuva forte":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "weather-thunder";
        break;
      case "Chuva fraca":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";
        break;
      case "Chuva moderada ou forte com trovoada":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-cloudynight"
            : this.url = "weather-thunder";
        break;
      case "Chuvisco":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";
        break;
      case "Chuvisco irregular":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";
        break;
      case "Aguaceiros moderados ou fortes":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "weather-windy";
        break;
      case "Neblina":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-cloudynight"
            : this.url = "partly-cloudy";
        break;
      case "Nublado":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-cloudynight"
            : this.url = "partly-cloudy";
        break;
      case "Encoberto":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-cloudynight"
            : this.url = "partly-cloudy";
        break;
      case "Chuva moderada":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "weather-windy";
        break;

      case "Chuva fraca irregular":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "weather-windy";
        break;
      case "Aguaceiros fracos":
        double hourDouble = double.parse(this.hour.split(":")[0]);
        hourDouble < 6 || hourDouble > 18
            ? this.url = "weather-rainynight"
            : this.url = "partly-shower";

        break;
    }
  }
}
