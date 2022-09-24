// https://dev.to/0xba1/using-regular-expressionsregexp-in-dartflutter-3p1j

class ProcessURL {
  static String? convertToUseableURL(String? youTubeUrl) {
    try {
      if (youTubeUrl == null) {
        return null;
      }

      if (youTubeUrl.substring(0, 17) == 'https://youtu.be/') {
        return _convertYoutubeAbbreviatedUrlToVideoUrl(youTubeUrl);
      } else if (youTubeUrl.substring(0, 31) ==
          'https://www.youtube.com/shorts/') {
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
    // i.e. convert the string https://www.youtube.com/shorts/jC0J4mG_Rxs to https://www.youtube.com/watch?v=jC0J4mG_Rxs
    if (youtubeUrl == null) {
      return null;
    }
    final regExp = RegExp(r'^.*(youtube.com\/|shorts\/)([^#\&\?]*).*');
    final match = regExp.firstMatch(youtubeUrl);
    return match != null ? 'https://www.youtube.com/watch?v=${match[2]}' : null;
  }

  static String? _convertYoutubeAbbreviatedUrlToVideoUrl(String youtubeUrl) {
    final regExp = RegExp(r'^.*(youtube\/|watch\?v=|\&v=)([^#\&\?]*).*');
    final match = regExp.firstMatch(youtubeUrl);
    return match != null ? 'https://www.youtube.com/watch?v=${match[2]}' : null;
  }
}
