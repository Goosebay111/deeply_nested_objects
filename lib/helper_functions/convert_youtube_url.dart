import 'dart:developer';

class ProcessURL {
  static String? convertToUseableURL(String? youTubeUrl) {
    log('youTubeUrl to be converted: $youTubeUrl');
    try {
      if (youTubeUrl == null) {
        return null;
      }

      log(youTubeUrl.substring(0, 31));
      if (youTubeUrl.substring(0, 17) == 'https://youtu.be/') {
        return _convertYoutubeAbbreviatedUrlToVideoUrl(youTubeUrl);
      } else if (youTubeUrl.substring(0, 31) == 'https://www.youtube.com/shorts/') {
        log(youTubeUrl);
        return _convertYoutubeShortsUrlToVideoUrl(youTubeUrl);
      } else if (youTubeUrl.substring(0, 32) ==
          'https://www.youtube.com/watch?v=') {
        return youTubeUrl;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String? _convertYoutubeShortsUrlToVideoUrl(String? youtubeUrl) {
    if (youtubeUrl == null) {
      return null;
    }
    final regExp = RegExp(r'^.*(youtube.com\/|shorts\/)([^#\&\?]*).*');
    final match = regExp.firstMatch(youtubeUrl);
    return match != null ? 'https://www.youtube.com/watch?v=${match[2]}' : null;
  }

  static String? _convertYoutubeAbbreviatedUrlToVideoUrl(String youtubeUrl) {
    // i.e. convert the string https://www.youtube.com/shorts/jC0J4mG_Rxs to https://www.youtube.com/watch?v=jC0J4mG_Rxs
    final regExp = RegExp(
        r'^.*(youtu.be\/|watch\?v=|\&v=)([^#\&\?]*).*');
    final match = regExp.firstMatch(youtubeUrl);
    return match != null ? 'https://www.youtube.com/watch?v=${match[2]}' : null;
  }
}
