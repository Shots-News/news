import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  print(url);
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the url.';
    }
  } catch (e) {
    print(e);
  }
}
