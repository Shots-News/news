import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/constant.dart';
import 'package:news/views/screens/categories/categories_screen.dart';
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
        appBar: AppBar(
          title: Text(
            'News App',
            style: style.h6BText(context),
          ),
          actions: [
            IconButton(
              onPressed: () => FcNavigator().push(context, screen: MyCategoriesScreen()),
              icon: Icon(MyIcons.vacuum, size: 22),
            ),
          ],
        ),
        drawer: Drawer(),
        body: Container(
          width: double.infinity,
          child: MyNewsPageView(),
        ),
      ),
    );
  }
}
