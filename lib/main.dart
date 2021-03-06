import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news/locator.dart';
import 'package:news/repository/artical_repo.dart';
import 'package:news/services/ads_state.dart';
import 'package:news/services/firebase_auth.dart';
import 'package:news/views/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:news/bloc/articals/articals_bloc.dart';
import 'package:news/repository/category_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await Firebase.initializeApp();

  final initFuture = MobileAds.instance.initialize();
  final adsState = AdsState(initFuture);
  setup();
  runApp(
    Provider.value(
      value: adsState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(initialData: null, value: AuthService().user),
        ChangeNotifierProvider<CategoryService>(create: (_) => CategoryService()),
        ChangeNotifierProvider<ArticalService>(create: (_) => ArticalService()),
        BlocProvider<ArticalsBloc>(create: (_) => ArticalsBloc(articalRepository: ArticalService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FcTheme.dark,
        home: MyHomeScreen(),
        // home: MySplashScreen(),
      ),
    );
  }
}
