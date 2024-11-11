import 'dart:convert';

import '../utils/CustomException.dart';
import 'base.service.dart';


class GeneralService{
  Future<String> getTermsAndConditions() async {
    final response = await BaseService().get('terms-conditions');
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['data'] as List;
      return data.first['body'] as String;
    }else {
      throw CustomException('Ha ocurrido un error inesperado al intentar obtener los terminos y condiciones de servicios, favor revisar su conexión a internet e intentar nuevamente.');
    }
  }

  Future<String> getPrivacyPolicy() async {
    final response = await BaseService().get('privacy-policy');
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['data'] as List;
      return data.first['body'] as String;
    }else {
      throw CustomException('Ha ocurrido un error inesperado al intentar obtener las políticas de privacidad, favor revisar su conexión a internet e intentar nuevamente.');
    }
  }
}