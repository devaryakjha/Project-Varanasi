String get topSongsURL =>
    'https://www.jiosaavn.com/api.php?__call=webapi.get&token=8MT-LQlP35c_&type=playlist&p=1&n=30&includeMetaTags=0&ctx=web6dot0&api_version=4&_format=json&_marker=0';

String get songDetailURL =>
    "https://www.jiosaavn.com/api.php?app_version=5.18.3&api_version=4&readable_version=5.18.3&v=79&_format=json&__call=song.getDetails&pids=";

String lyriclURL(songId) =>
    "https://www.jiosaavn.com/api.php?__call=lyrics.getLyrics&lyrics_id=$songId&ctx=web6dot0&api_version=4&_format=json";

String alernateLyricsUrl({required String artist, required String name}) =>
    "https://musifydev.vercel.app/lyrics/" + artist + '/' + name;

String searchUrl(searchQuery) =>
    "https://www.jiosaavn.com/api.php?__call=autocomplete.get&query=$searchQuery&_format=json&_marker=0&ctx=wap6dot0t";

String playlisturl(String id) =>
    "https://www.jiosaavn.com/api.php?app_version=5.18.3&api_version=4&readable_version=5.18.3&n=30&v=79&_format=json&__call=playlist.getDetails&listid=$id";

String get trendingSearchURL =>
    'https://www.jiosaavn.com/api.php?__call=content.getTopSearches&ctx=wap6dot0&api_version=4&_format=json&_marker=0';

String albumsDetails(String token) =>
    'https://www.jiosaavn.com/api.php?__call=webapi.get&token=$token&type=album&includeMetaTags=0&ctx=wap6dot0&api_version=4&_format=json&_marker=0';

String artistDetails(String token) =>
    'https://www.jiosaavn.com/api.php?__call=webapi.get&token=$token&type=artist&p=&n_song=50&n_album=50&sub_type=&category=&sort_order=&includeMetaTags=0&ctx=wap6dot0&api_version=4&_format=json&_marker=0';

String get launchDataURL =>
    'https://www.jiosaavn.com/api.php?__call=webapi.getLaunchData&api_version=4&_format=json&_marker=0&ctx=wap6dot0';
