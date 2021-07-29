import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsState {
  AdsState(this.initialization);

  Future<InitializationStatus> initialization;

  // Test ID
  String get bannerAdsUnitID =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';

  BannerAdListener get bannerAdListener => _bannerAdListener;

  BannerAdListener _bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad Loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad Closed: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) => print('Ad Failed to Loaded: ${ad.adUnitId} $error'),
    onAdOpened: (ad) => print('Ad open: ${ad.adUnitId}'),
  );
}
