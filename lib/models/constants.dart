import 'package:flutter/material.dart';
import 'package:weather_app/models/my_flutter_app_icons.dart';

const weatherApiKey = '2aa12ce177554ba9aa1110604231308';
IconData getIcons(int code) {
  switch (code) {
    case 1000:
      return MyFlutterApp.sunFilled;
    // case 1009:
    // case 1003:
    // case 1135:
    // case 1030:
    // case 1063:
    // case 1066:
    // case 1069:
    // case 1072:
    // case 1114:
    // case 1117:
    //   return MyFlutterApp.cloud;
    case 1087:
    case 1273:
    case 1276:
    case 1279:
    case 1282:
      return MyFlutterApp.cloudFlash;
    case 1006:
      return MyFlutterApp.cloudSun;
    case 1150:
    case 1153:
    case 1168:
    case 1171:
    case 1180:
    case 1183:
      return MyFlutterApp.drizzle;
    case 1186:
    case 1189:
    case 1192:
    case 1195:
      return MyFlutterApp.rain;
    case 1210:
    case 1225:
    case 1213:
    case 1216:
    case 1219:
    case 1222:
    case 1237:
      return MyFlutterApp.snow;
    default:
      return MyFlutterApp.cloud;
  }
}
