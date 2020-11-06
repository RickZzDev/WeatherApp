class AudioFile {
  String condition;
  String url;

  AudioFile.returnFileUrl({this.condition}) {
    switch (condition) {
      case "Sol":
        this.url = "sunny";
        break;
      case "Possibilidade de trovoada":
        this.url = "heavy-rain";
        break;

      case "CÃ©u limpo":
        this.url = "sunny";
        break;
      case "Possibilidade de chuva irregular":
        this.url = "light-rain";
        break;
      case "PerÃ­odos de chuva moderada":
        this.url = "heavy-rain";
        break;
      case "Chuva forte":
        this.url = "heavy-rain";
        break;
      case "Chuva fraca":
        this.url = "light-rain";
        break;
      case "Chuva moderada ou forte com trovoada":
        this.url = "heavy-rain";
        break;
      case "Chuvisco":
        this.url = "light-rain";
        break;
      case "Chuvisco irregular":
        this.url = "light-rain";
        break;

      case "Chuva moderada":
        this.url = "light-rain";
        break;

      case "Chuva fraca irregular":
        this.url = "light-rain";
        break;
      case "Aguaceiros fracos":
        this.url = "light-rain";
        break;
      default:
        this.url = "sunny";
    }
  }
}
