class ApiEndPoints {
  static const String baseURL = 'https://www.jiosaavn.com/api.php';
  static final Uri initialDataURI = Uri.parse(
    '$baseURL?__call=webapi.getLaunchData&api_version=4&_format=json&_marker=0&ctx=wap6dot0',
  );
  static Uri searchResultURI(
    String query, {
    String callType = 'autocomplete.get',
    int page = 1,
  }) =>
      Uri.parse(
        '$baseURL?__call=$callType&_format=json&_marker=0&ctx=wap6dot0t&query=$query&q=$query&p=$page&n=30',
      );
  static Uri artistURI(
    String token, {
    int page = 1,
  }) =>
      Uri.parse(
        '$baseURL?__call=webapi.get&token=$token&type=artist&n_song=50&n_album=50&_marker=0&n_playlist=50&p=$page',
      );
  static Uri playlistURI(
    String token, {
    int page = 1,
  }) =>
      Uri.parse(
        '$baseURL?__call=playlist.getDetails&_format=json&_marker=0&ctx=wap6dot0t&listid=$token',
      );
  static Uri albumURI(
    String token, {
    int page = 1,
  }) =>
      Uri.parse(
        '$baseURL?__call=webapi.get&_format=json&_marker=0&ctx=wap6dot0t&type=album&token=$token',
      );
  static Uri songDetails(String id) => Uri.parse(
        '$baseURL?__call=song.getDetails&_format=json&_marker=0&ctx=wap6dot0t&pids=$id',
      );
}
