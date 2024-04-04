import 'dart:io';
import 'package:http/http.dart' as http;

class ContactService {
  final String baseUrl = 'https://paml.tatiumy.com/api/';
  final String endpoint = 'people';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addPerson(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST', 
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
      }
      else {
        request.files.add(http.MultipartFile.fromString('gambar', ''));
      }
      return await http.Response.fromStream(await request.send());
  }
}