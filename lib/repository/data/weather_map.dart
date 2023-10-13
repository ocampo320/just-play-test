
import 'package:dartz/dartz.dart';
import 'package:just_play_test/core/failures/common_failure.dart';
import 'package:just_play_test/services/weather_map_services.dart';

class WeatherMap{
  Future<Either<CommonFailure, String>> save(String city,String date) async {
    try {
         final data  = await WeatherMapServices.getWeatherMapServices(city, date);
      return right(data);
    } catch (e) {
      return left(CommonFailure.data(message: e.toString()));
    }
  }
}