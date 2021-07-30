import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/views/screens/home/news_page_view.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  // BannerAd? bannerAd;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final adState = Provider.of<AdsState>(context);
  //   adState.initialization.then((value) {
  //     setState(() {
  //       bannerAd = BannerAd(
  //         size: AdSize.banner,
  //         adUnitId: adState.bannerAdsUnitID,
  //         listener: adState.bannerAdListener,
  //         request: AdRequest(),
  //       )..load();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: MyNewsPageView(),
        ),
      ),
    );
  }
}
