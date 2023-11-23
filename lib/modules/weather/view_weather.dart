part of "./weather.dart";

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var controller = Get.put(WeatherController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MainScaffold(
          type: "default",
          colorBackground: Utility.baseColor2,
          returnOnWillpop: false,
          backFunction: () => ButtonSheetWidget().validasiButtomSheet(
                  "Logout",
                  const TextLabel(
                      text:
                          "Are you sure you are logging out of your account?"),
                  "Logout", () {
                AppData.uuid = "";
                AppData.email = "";
                Routes.routeOff(type: "splash");
              }),
          colorSafeArea: Utility.baseColor2,
          content: controller.progress.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ShimmerWidget.shimmerOnWeather(Get.context!))
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Utility.medium,
                      ),
                      Center(
                        child: TextLabel(
                          text: "WEATHER APP",
                          color: Utility.baseColor1,
                          size: Utility.large,
                        ),
                      ),
                      SizedBox(
                        height: Utility.medium,
                      ),
                      controller.cuacaSelected.value == null
                          ? const SizedBox()
                          : _screenCuacaSelected(),
                      SizedBox(
                        height: Utility.medium,
                      ),
                      controller.listTanggalDataCuaca.isEmpty
                          ? const SizedBox()
                          : _screenListTanggal(),
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: Utility.medium,
                            right: Utility.medium,
                            top: Utility.medium),
                        child: _screenListCuaca(),
                      ))
                    ],
                  ),
                )),
    );
  }

  Widget _screenListTanggal() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.listTanggalDataCuaca.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(Utility.small),
              child: InkWell(
                onTap: () => controller
                    .pilihFilterTanggal(controller.listTanggalDataCuaca[index]),
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          Utility.dateUpload(controller.dateSelected.value) ==
                                  Utility.dateUpload(
                                      controller.listTanggalDataCuaca[index])
                              ? Utility.borderContainer
                              : Utility.baseColor1,
                      borderRadius: Utility.borderStyle1),
                  padding: EdgeInsets.only(
                      left: Utility.medium, right: Utility.medium),
                  child: Center(
                    child: TextLabel(
                        text: Utility.dateView(
                            controller.listTanggalDataCuaca[index])),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _screenCuacaSelected() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.center,
            image: controller.cuacaSelected.value!.weather.first.main == "Rain"
                ? const AssetImage('assets/mendung.jpg')
                : const AssetImage('assets/cerah.jpg'),
            fit: BoxFit.fill),
      ),
      child: Container(
        color: const Color.fromARGB(109, 163, 163, 163),
        child: Padding(
          padding: EdgeInsets.only(top: Utility.medium, bottom: Utility.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextLabel(
                  text: Utility.dateAndTimeView(
                      controller.cuacaSelected.value!.dtTxt),
                  color: Utility.baseColor1,
                  size: Utility.large,
                ),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text:
                        "${Utility.currencyFormat(Utility.calculationCelcius(controller.cuacaSelected.value!.main.temp), 2)}°C",
                    size: Utility.extraLarge,
                    color: Utility.baseColor1,
                  ),
                  SizedBox(
                    width: Utility.medium,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      'https://openweathermap.org/img/wn/${controller.cuacaSelected.value!.weather.first.icon}@2x.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Utility.medium,
              ),
              Center(
                child: TextLabel(
                  text:
                      "${controller.cuacaSelected.value!.weather.first.main} (${controller.cuacaSelected.value!.weather.first.description})",
                  color: Utility.baseColor1,
                ),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextLabel(
                        text: "Temp (min)",
                        color: Utility.baseColor1,
                      ),
                      TextLabel(
                        text:
                            "${Utility.currencyFormat(Utility.calculationCelcius(controller.cuacaSelected.value!.main.tempMin), 2)}°C",
                        size: Utility.extraLarge,
                        color: Utility.baseColor1,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Utility.medium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextLabel(
                        text: "Temp (max)",
                        color: Utility.baseColor1,
                      ),
                      TextLabel(
                        text:
                            "${Utility.currencyFormat(Utility.calculationCelcius(controller.cuacaSelected.value!.main.tempMax), 2)}°C",
                        size: Utility.extraLarge,
                        color: Utility.baseColor1,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenListCuaca() {
    return ListView.builder(
        itemCount: controller.listDataWeatherPerTanggal.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          int dtCuaca = controller.listDataWeatherPerTanggal[index].dt;
          String iconWeather =
              controller.listDataWeatherPerTanggal[index].weather.first.icon;
          DateTime waktuCuaca =
              controller.listDataWeatherPerTanggal[index].dtTxt;
          String namaCuaca =
              controller.listDataWeatherPerTanggal[index].weather.first.main;
          double temperatur =
              controller.listDataWeatherPerTanggal[index].main.temp;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardCustom(
                colorBg: dtCuaca == controller.cuacaSelected.value?.dt
                    ? Utility.maincolor1
                    : Colors.transparent,
                colorBorder: Colors.transparent,
                radiusBorder: Utility.borderStyle1,
                onTap: () {
                  controller.cuacaSelected.value =
                      controller.listDataWeatherPerTanggal[index];
                  controller.cuacaSelected.refresh();
                },
                widgetCardCustom: ExpandedView2Row(
                    flexLeft: 30,
                    flexRight: 70,
                    widgetLeft: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://openweathermap.org/img/wn/$iconWeather@2x.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    widgetRight: Padding(
                      padding: EdgeInsets.only(top: Utility.medium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel(
                            text: Utility.dateAndTimeView(waktuCuaca),
                            color: Utility.baseColor1,
                          ),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(
                            text: namaCuaca,
                            color: Utility.baseColor1,
                          ),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(
                            text:
                                "Temp: ${Utility.currencyFormat(Utility.calculationCelcius(temperatur), 2)}°C",
                            color: Utility.baseColor1,
                          )
                        ],
                      ),
                    )),
              ),
              Divider(
                color: Utility.baseColor1,
              )
            ],
          );
        });
  }
}
