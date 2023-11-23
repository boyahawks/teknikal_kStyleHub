part of "./weather.dart";

class WeatherController extends GetxController {
  RxList<MainWeather> listDataWeather = <MainWeather>[].obs;
  RxList<MainWeather> listDataWeatherPerTanggal = <MainWeather>[].obs;
  RxList<DateTime> listTanggalDataCuaca = <DateTime>[].obs;
  Rx<MainWeather?> cuacaSelected = Rx<MainWeather?>(null);

  RxBool progress = false.obs;
  RxInt dtSelected = 0.obs;
  Rx<DateTime> dateSelected = DateTime.now().obs;

  Future<void> init() async {
    locationUser();
  }

  Future<void> locationUser() async {
    progress.value = true;
    progress.refresh();
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    final LocationData locationData = await location.getLocation();
    getDataCuaca(
        lat: locationData.latitude ?? 0.0, long: locationData.longitude ?? 0.0);
  }

  Future<void> getDataCuaca({required double lat, required double long}) async {
    if (lat == 0.0 || long == 0.0) {
      locationUser();
    } else {
      dynamic responseGetWeather =
          await weatherService.getDataWeather(lat, long);
      if (responseGetWeather == null) {
        UtilsAlert.showToast("Terjadi kesalahan");
        listDataWeather.value = AppData.dataWeather ?? [];
        listDataWeather.refresh();
        cuacaSelected.value = listDataWeather.first;
        cuacaSelected.refresh();
      } else {
        if (responseGetWeather["list"].isNotEmpty) {
          List<MainWeather> dataCuaca = [];
          for (var element in responseGetWeather["list"]) {
            if (listTanggalDataCuaca.isEmpty) {
              listTanggalDataCuaca.add(DateTime.parse(element["dt_txt"]));
            } else {
              DateTime? tanggalExist = listTanggalDataCuaca.firstWhereOrNull(
                  (existTanggal) =>
                      Utility.dateView(existTanggal) ==
                      Utility.dateView(DateTime.parse(element["dt_txt"])));
              if (tanggalExist == null) {
                listTanggalDataCuaca.add(DateTime.parse(element["dt_txt"]));
              }
            }
            dataCuaca.add(MainWeather.fromMap(element));
          }
          listDataWeather.value = dataCuaca;
          listDataWeather.refresh();
          List<MainWeather> filterCuacaSesuaiHari = dataCuaca
              .where((cuacaFilter) =>
                  Utility.dateUpload(cuacaFilter.dtTxt) ==
                  Utility.dateUpload(dateSelected.value))
              .toList();
          listDataWeatherPerTanggal.value = filterCuacaSesuaiHari;
          listDataWeatherPerTanggal.refresh();
          cuacaSelected.value = filterCuacaSesuaiHari.first;
          cuacaSelected.refresh();

          AppData.dataWeather = dataCuaca;
          UtilsAlert.showToast("Data Cuaca Tersimpan : ${dataCuaca.length}");
          progress.value = false;
          progress.refresh();
        }
      }
    }
  }

  Future<void> pilihFilterTanggal(DateTime tanggal) async {
    dateSelected.value = tanggal;
    dateSelected.refresh();
    listDataWeatherPerTanggal.value = listDataWeather
        .where((masterData) =>
            Utility.dateUpload(masterData.dtTxt) == Utility.dateUpload(tanggal))
        .toList();
    listDataWeatherPerTanggal.refresh();
    cuacaSelected.value = listDataWeatherPerTanggal.first;
    cuacaSelected.refresh();
  }
}
