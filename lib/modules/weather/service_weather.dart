part of "./weather.dart";

class weatherService {
  static Future<dynamic> getDataWeather(double lat, double long) async {
    dynamic resultData;
    try {
      var prosesApi = Api.connectionApi("get", "",
          "forecast?lat=$lat&lon=$long&appid=0d47e8c81d98a9956af30a1c3598664a");
      var getValue = await prosesApi;
      var response = jsonDecode(getValue.body);
      resultData = response;
    } catch (e) {
      UtilsAlert.showToast("Error : $e");
      resultData = null;
    }
    return resultData;
  }
}
