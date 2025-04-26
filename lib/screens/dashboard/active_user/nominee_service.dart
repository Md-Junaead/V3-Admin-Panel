// nominee_service.dart (Service)
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'nominee_model.dart';

class NomineeService {
  static const String url = 'http://75.119.134.82:6160/api/nominee/get';

  Future<List<Nominee>> fetchNominees() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Nominee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load nominees');
    }
  }
}
