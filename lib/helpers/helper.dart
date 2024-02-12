import 'package:app3/helpers/constants.dart';
import 'package:app3/helpers/fetch.dart';

const weatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherFetch {
  Future<dynamic> getWeatherByCoord(double lat, double lon) async {
    FetchHelper fetchData = FetchHelper(
      "$weatherMapUrl?lat=$lat&lon=$lon&appid=$openWeatherMapKey&units=metric");

    return await fetchData.getData();
  }

  Future<dynamic> getWeatherByName(String cityName) async {
    FetchHelper fetchData = FetchHelper(
      "$weatherMapUrl?q=$cityName&appid=$openWeatherMapKey&units=metric");
    
    return await fetchData.getData();
  }
}