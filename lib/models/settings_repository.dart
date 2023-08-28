import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  void createInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkTemp = prefs.containsKey('temperatureUnit');
    if (checkTemp == false) {
      prefs.setString('temperatureUnit', 'Celsius');
      prefs.setString('pressureUnit', 'mBar');
      prefs.setString('windSpeedUnit', 'km/h');
      return;
    }
    return;
  }

  Future<String?> getTemperatureSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('temperatureUnit');
  }

  Future<String?> getPressureSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pressureUnit');
  }

  Future<String?> getWindSpeedSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('windSpeedUnit');
  }

  void setTemperatureSettings(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('temperatureUnit', unit);
  }

  void setPressureSettings(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pressureUnit', unit);
  }

  void setWindSpeedSettings(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('windSpeedUnit', unit);
  }
}
