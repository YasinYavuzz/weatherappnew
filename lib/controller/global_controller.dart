import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/api/fetch_weather.dart';
import 'package:weatherapp_starter_project/model/weather_data.dart';

class GlobalController extends GetxController {
  // get controller

  // create variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble checkLattitude() => _latitude;
  RxDouble checkLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  // its mean initstate
  @override
  void onInit() {
    if (_isLoading.isTrue) getLocation();
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnable;
    LocationPermission locationPermission;
    isServiceEnable = await Geolocator.isLocationServiceEnabled();
    // return is service is not enabled
    if (!isServiceEnable) return Future.error("Location not enabled");
    // status permisson request
    locationPermission = await Geolocator.checkPermission();

    // check permission
    if (locationPermission == LocationPermission.deniedForever)
      return Future.error("Location permission denied");
    else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied)
        return Future.error("Location permission denied");
    }

    // getting current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // update latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
      

      // calling weather api
      return FetchWeatherAPI().processData(value.latitude, value.longitude).then((value) => {
        weatherData.value = value,
        _isLoading.value = false
      });

    });
  }
}
