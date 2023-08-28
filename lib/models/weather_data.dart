class WeatherData {
  final String location;
  final double currentTempInC;
  final double currentTempInF;
  final String currentCondition;
  final double currentPressureInBar;
  final double currentPressureInIn;
  final double currentWindSpeedInKph;
  final double currentWindSpeedInMph;
  final int humidity;

  const WeatherData(
      {required this.location,
      required this.currentTempInC,
      required this.currentTempInF,
      required this.currentCondition,
      required this.currentPressureInBar,
      required this.currentPressureInIn,
      required this.currentWindSpeedInKph,
      required this.currentWindSpeedInMph,
      required this.humidity});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        location: json['location']['name'],
        currentTempInC: json['current']['temp_c'],
        currentTempInF: json['current']['temp_f'],
        currentCondition: json['current']['condition']['text'],
        currentPressureInBar: json['current']['pressure_mb'],
        currentPressureInIn: json['current']['pressure_in'],
        currentWindSpeedInKph: json['current']['wind_kph'],
        currentWindSpeedInMph: json['current']['wind_mph'],
        humidity: json['current']['humidity']);
  }
}
