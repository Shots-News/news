import 'package:get_it/get_it.dart';
import 'package:news/routes/navigation_service.dart';
import 'package:news/services/firebase_auth.dart';
import 'package:news/services/firebase_service.dart';
import 'package:news/utils/date_time_formatter.dart';
import 'package:news/utils/youtube.dart';
import 'package:news/views/widgets/widgets.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<YoutubeConfig>(() => YoutubeConfig());
  locator.registerLazySingleton<MyWidgets>(() => MyWidgets());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<MyDateTime>(() => MyDateTime());
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
}
