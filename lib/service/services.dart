import 'dart:convert';
import 'dart:math';

import '../models/paginated_result.dart';
import '../models/people.dart';
import 'package:http/http.dart' as http;

class ConectionsService {
  static Future<List<People>> getResults(int page) async {
    try {
      final url2 = Uri.https("swapi.dev", "/api/people/", {"page": "$page"});

      final resp = await http.get(url2);

      if (resp.statusCode == 200) {
        return PaginatedResult.fromJson(jsonDecode(utf8.decode(resp.bodyBytes))).results;
      }

      final List<People> peopleEmpty = [];
      return peopleEmpty;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> sendResult(People people) async {
    try {
      final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      final int userId = Random().nextInt(50);

      Map<String, dynamic> body = {
        "userId": "$userId",
        "dateTime": people.created.toString(),
        "character_name": people.name
      };

      final resp = await http.post(url, body: body);

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
