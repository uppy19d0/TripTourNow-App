import 'package:dio/dio.dart';
import 'dart:io';
import '../models/http/error_http.dart';
import '../services/local_storage.dart';




class HttpApi {

  static Dio _dio = new Dio();

  static errorData(dynamic , int? code){ //<--- Se creo un modelo para facilitar el manejo de los datos
    return ErrorHttp( data: dynamic, code: code);
  }

  static void configureDio() {

    // Base del url
    _dio.options.baseUrl = 'http://triptournow.com/api/V1';


    late final token;

    if(LocalStorage.prefs.getString('token') != null && LocalStorage.prefs.getString('token')!.isNotEmpty){

      token = "Bearer "+ LocalStorage.prefs.getString('token')!;

    }else{  token = ''; }

    _dio.options.headers = {
      'Authorization': token,
      'Accept' : 'application/json'
    };

  }

  static Future httpGet( String path ) async {
    try {

      final resp = await _dio.get(path);
      return resp.data;
    }  on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      print(e);
      throw("Error en el Get");
    }
  }

  static Future httpGetFuture( String path ) async {
    try {

      final resp = await _dio.get(path);
      return resp;
    }  on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Get");
    }
  }
  //the image is a file from imagepicker
  static Future postWithImage( String path, Map<String, dynamic> data, File image ) async {

    final formData = FormData.fromMap(data);
    formData.files.add(MapEntry("image", MultipartFile.fromFileSync(image.path, filename: image.path.split("/").last)));

    try {

      final resp = await _dio.post(path, data: formData );
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }

  //the image is a file from imagepicker
  static Future postWithTwoImage( String path, Map<String, dynamic> data, File image, File image2 ) async {

    final formData = FormData.fromMap(data);
    formData.files.add(MapEntry("id_front", MultipartFile.fromFileSync(image.path, filename: image.path.split("/").last)));
    formData.files.add(MapEntry("id_back", MultipartFile.fromFileSync(image2.path, filename: image.path.split("/").last)));

    try {

      final resp = await _dio.post(path, data: formData );
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }


  static Future postWithImageSelfie( String path, Map<String, dynamic> data, File image ) async {

    final formData = FormData.fromMap(data);
    formData.files.add(MapEntry("selfie", MultipartFile.fromFileSync(image.path, filename: image.path.split("/").last)));

    try {

      final resp = await _dio.post(path, data: formData );
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }

  static Future post( String path, Map<String, dynamic> data ) async {
    final formData = FormData.fromMap(data);
    try {

      final resp = await _dio.post(path, data: formData );
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }

  static Future put( String path, Map<String, dynamic> data ) async {

    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData );
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }

  //delete
  static Future delete( String path ) async {

    try {
      final resp = await _dio.delete(path);
      return resp.data;

    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }
  static Future putJson( String path, Map<String, dynamic> data ) async {
    try {
      final resp = await _dio.put(path, data: data );
      return resp.data;
    } on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el Post");
    }
  }

  static Future postJson( String path, Map<dynamic, dynamic> data ) async {

    try {

      print(path);

      final resp = await _dio.post(path, data: data );


      return resp.data;

    }  on DioError catch (e) {
      throw(e.response?.data);
      //throw( errorData(e.response?.data, e.response?.statusCode) );
    }

    //Unhandled Exception: Instance of 'ErrorHttp'

    catch (e) {
      throw("Error en el PostJson");
    }
  }


  static Future postJsonComp( String path, Map<String, dynamic> data ) async {

    try {

      final resp = await _dio.post(path, data: data );
      return resp.data;

    }  on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el PostJson");
    }
  }

  static Future postVoid( String path) async {

    try {

      final resp = await _dio.post(path);
      return resp.data;

    }  on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el PostJson");
    }
  }

  static Future postJsonFuture( String path, Map<String, dynamic> data ) async {

    try {

      final resp = await _dio.post(path, data: data );
      return resp;

    }  on DioError catch (e) {
      throw( errorData(e.response?.data, e.response?.statusCode) );
    } catch (e) {
      throw("Error en el PostJson");
    }


  }


}