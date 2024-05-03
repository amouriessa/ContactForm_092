import 'dart:io';
import 'dart:convert';


import 'package:contact_form/models/contact.dart';
import 'package:contact_form/service/contact_service.dart';


class ContactController {
  final contactService = ContactService();

  Future<Map<String, dynamic>> addPerson(Contact person, File? file) async {
    Map<String, String> data = {
      'name': person.name,
      'email': person.email,
      'address': person.address,
      'number': person.number,
    };

    try {
      var response = await contactService.addPerson(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data Successfuly Added',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'There is an error!',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message': 
              decodedJson['message'] ?? 'An error occurred while saving data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'There is an error! $e',
      };
    }
  }
}