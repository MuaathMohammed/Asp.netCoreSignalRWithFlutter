import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
abstract class HttpService{
Future<dynamic> getMethod( url) ;

}
class HttpServiceImp implements HttpService{
  var client = http.Client();

  @override
  Future<dynamic> getMethod(url) async{
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    // TODO: implement getRequest
    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
    return response;
  }

}