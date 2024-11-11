import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;


class BaseService {
  //final String baseURL = "califrup.com";
  final String baseURL = "app.califrup.com";
  final String basePath = "/api/";
  final headers = { 'Content-Type': 'application/json' };

  Uri _getUrl(String path, [ Map<String, dynamic>? params ]){
    return Uri.https(baseURL, this.basePath + path, params);
  }

  Future<Map<String, String>> _getHeaders() async {
    //final token = await AuthService().getToken();
    final token = "";

    if(token != null && !headers.containsKey('Authorization')){
      final t = token.replaceAll("\"", "");
      headers.addAll({ 'Authorization': 'Bearer $t' });
      return headers;
    }else {
      return headers;
    }
  }

  Future<http.Response> get(String path, [Map<String, dynamic>? params]) async {
    var url = _getUrl(path, params);
    var headers = await _getHeaders();
    return http.get(url, headers: headers);
  }

  Future<http.Response> post(
    String path, 
    Map<String, dynamic> data, 
    [ Map<String, dynamic>? params ]
  ) async {
    var url = _getUrl(path, params);
    var headers = await _getHeaders();
    return http.post(url, body: jsonEncode(data), headers: headers);
  }

  Future<Map<String, dynamic>?> uploadFile(String path, File file) async {
    final url = _getUrl(path);
    final request = http.MultipartRequest('POST', url);

    // Set Headers
    final headers = await _getHeaders();
    request.headers.addAll(headers);

    // Set File
    request.files.add(http.MultipartFile(
      'image',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last
    ));

    // Making Request
    final response = await request.send();

    try {
      final data = await response.stream.bytesToString();
      final responseData = jsonDecode(data);
      file.deleteSync();
      return responseData['data'];
    }catch(e){
      return null;
    }
  }
}