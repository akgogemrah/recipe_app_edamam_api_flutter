class EdamamApiService {
  static const String _endpoint = 'https://api.edamam.com/search';
  String _query = '';
  String? filter;
  static const String _appId = 'd1b117f8';
  static const String _appKey = '600654bdcb971c7b88ecb87141935e32';
  String get url => '$_endpoint?q=$_query&app_id=$_appId&app_key=$_appKey';
  String get _filter => '$_endpoint?q=$_query&app_id=$_appId&app_key=$_appKey&health=$filter';
  set query(String query) {
    assert(query != null && query.isNotEmpty);
    _query = query;
  }
}
