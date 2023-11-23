part of "./widget.dart";

class CustomDialog {
  static showLoading(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Mohon tunggu...",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    return Navigator.pop(context);
  }

  static showAlert(String message, BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            height: message.length <= 50 ? 50.0 : 100.0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Utility.maincolor1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
