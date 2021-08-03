import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/locator.dart';
import 'package:news/services/firebase_auth.dart';
import 'package:news/services/firebase_service.dart';
import 'package:news/views/screens/categories/categories_screen.dart';
import 'package:news/views/screens/home/news_page_view.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final _user = Provider.of<User?>(context);
    final AuthService _authService = AuthService();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'News',
            style: style.h6BText(context),
          ),
          actions: [
            IconButton(
              onPressed: () => FcNavigator().push(context, screen: MyCategoriesScreen()),
              icon: Icon(MyIcons.chat, size: 22),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: MyColors.lightBlack,
            child: Column(
              children: [
                DrawerHeader(
                  child: Container(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            _authService.signInWIthGoogle();
                            setState(() {});
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(_user == null ? 'Login' : 'Log out'),
                      ),
                    ),
                  ),
                ),
                DrawerListTile(title: 'News', iconData: MyIcons.home),
                DrawerListTile(
                  title: 'Categories',
                  iconData: MyIcons.atomic,
                  onTap: () => FcNavigator().push(context, screen: MyCategoriesScreen()),
                ),
                DrawerListTile(title: 'Bookmark', iconData: MyIcons.favorites),
                DrawerListTile(
                  title: 'Share',
                  iconData: MyIcons.share,
                  onTap: () => Share.share('check out my website https://example.com', subject: 'Look what I made!'),
                ),
                DrawerListTile(title: 'Rate App', iconData: MyIcons.medal),
                DrawerListTile(title: 'Privacy Policy', iconData: MyIcons.key),
                DrawerListTile(title: 'About Us', iconData: MyIcons.information),
              ],
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: MyNewsPageView(),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.iconData,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String title;
  final IconData? iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          iconData,
          size: 20,
        ),
        title: Text(
          title,
          style: style.subtitleBText(context),
        ),
      ),
    );
  }
}
