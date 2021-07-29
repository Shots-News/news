import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  // String googleUrl = url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open the url.';
  }
}
