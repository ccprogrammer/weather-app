import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController extends GetxController {
  var weather = WeatherModel(
    id: 0,
    description: '',
    country: '',
    name: '',
    speed: 0,
    temp: 0,
    humidity: 0,
  ).obs;
  final city = [
    'Jakarta',
    'Semarang',
    'Tangerang',
    'Aceh',
    'Malang',
    'Bekasi',
    'Padang',
  ];
  var cityValue = 'Jakarta'.obs;
  final _weatherIconList = [
    'https://assets9.lottiefiles.com/temp/lf20_XkF78Y.json', //thunderstorm
    'https://assets9.lottiefiles.com/temp/lf20_rpC1Rd.json', //rain
    'https://assets9.lottiefiles.com/temp/lf20_BSVgyt.json', //snow
    'https://assets9.lottiefiles.com/temp/lf20_HflU56.json', //many circumstance
    'https://assets9.lottiefiles.com/temp/lf20_Stdaec.json', //clear
    'https://assets9.lottiefiles.com/temp/lf20_dgjK9i.json', //Cloudy
  ];
  var weatherIcon = ''.obs;

  var isLoading = true.obs;

  @override
  onInit() {
    super.onInit();
    fetchWeather(cityValue.value);
  }

  Future fetchWeather(String city) async {
    isLoading.value = true;
    try {
      var _weatherInfo =
          await WeatherService().fetchWeather(city);
      weather.value = _weatherInfo;
      fetchWeatherIcon();
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future fetchWeatherIcon() async {
    var weatherId = await weather.value.id;
    if (weatherId < 299) {
      weatherIcon.value = _weatherIconList[0];
    } else if (weatherId < 532) {
      weatherIcon.value = _weatherIconList[1];
    } else if (weatherId < 622) {
      weatherIcon.value = _weatherIconList[2];
    } else if (weatherId < 781) {
      weatherIcon.value = _weatherIconList[3];
    } else if (weatherId == 800) {
      weatherIcon.value = _weatherIconList[4];
    }else if (weatherId > 800) {
      weatherIcon.value = _weatherIconList[5];
    }
  }
}
