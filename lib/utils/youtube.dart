import 'package:flutter/cupertino.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeConfig {
  String getYoutubeVideoId(String url) {
    RegExp regExp = new RegExp(
      r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url)!.group(1); // <- This is the fix
    String str = match!;
    return str;
  }

  Widget youtubeVideoPlayer(String url) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: getYoutubeVideoId(url),
      params: YoutubePlayerParams(
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
        autoPlay: false,
      ),
    );
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
