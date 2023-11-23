import 'package:get/get.dart';
import 'package:test_kstylehub_bayuh/main.dart';
import 'package:test_kstylehub_bayuh/modules/auth/auth.dart';
import 'package:test_kstylehub_bayuh/modules/weather/weather.dart';

class Routes {
  static routeTo({required String type, dynamic data}) {
    if (type == "regis") {
      Get.to(
        AuthRegistrasi(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade,
      );
    }
    // else if (type == "read_antologi") {
    //   Get.to(
    //     ReadAntologi(
    //       controller: data[0],
    //       kategori: data[1],
    //       chapter: data[2],
    //       dataAntologi: data[3],
    //       pencarian: data[4],
    //     ),
    //     duration: const Duration(milliseconds: 300),
    //     transition: Transition.leftToRight,
    //   );
    // }
  }

  static routeOff({required String type, dynamic data}) {
    if (type == "login") {
      Get.offAll(
        AuthLogin(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "weather") {
      Get.offAll(
        const Weather(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "splash") {
      Get.offAll(
        const SplashScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    }
  }
}
