import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:personajes_star_war/models/paginated_result.dart';
import 'package:personajes_star_war/models/people.dart';

import '../widgets/people_data.dart';

class ProviderData extends ChangeNotifier {
  List<People> listPeople = [];
  // List<People?> reportedListPeople = [];
  List<Widget> datos = [];
  int _page = 0;
  int get page => _page;

  People? _people;
  People? get people => _people;
  Map peopleData = {};

  void setPage(int val) {
    _page = val;
    notifyListeners();
  }

  clearListPeople() {
    listPeople.clear();
    notifyListeners();
  }

  bool _eneableConection = false;
  bool get eneableConection => _eneableConection;
  People? _peopleReported;
  People? get peopleReported => _peopleReported;

  void setConection(bool val) {
    _eneableConection = val;
    notifyListeners();
  }

  void setPeopleReported(People? people) {
    _peopleReported = people;
    notifyListeners();
  }

  void setPeople(People people) {
    datos.clear();
    _people = people;
    notifyListeners();
  }

  List<String> emojis = ["📏", "💪", "🦰", "👁", "🥳", "👤", "🌍", "🚘", "🛸"];

  List<String> charcaters = [
    "birth_year",
    "eye_color",
    "gender",
    "hair_color",
    "height",
    "homeworld",
    "mass",
    "starships",
    "vehicles"
  ];

  Future<void> infiniteScroll() async {
    List<People> morePeople = await getResults();

    listPeople.addAll(morePeople);

    notifyListeners();
  }

  Future<List<People>> getResults() async {
    _page++;

    if (_page == 9) {
      listPeople.clear();
      _page = 1;
    }

    final url = Uri.parse("https://swapi.dev/api/people/?page=$page");
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      // print(resp.body);
      listPeople.addAll(PaginatedResult.fromJson(json.decode(utf8.decode(resp.bodyBytes))).results);

      return PaginatedResult.fromJson(jsonDecode(utf8.decode(resp.bodyBytes))).results;
    }

    final List<People> peopleEmpty = [];
    return peopleEmpty;
  }

  Future<bool> sendResult() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final int userId = Random().nextInt(50);

    Map<String, dynamic> body = {
      "userId": "$userId",
      "dateTime": peopleReported?.created.toString(),
      "character_name": peopleReported?.name
    };

    final resp = await http.post(url, body: body);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      print("Enviado");

      return true;
    } else {
      print("No funciono");
      return false;
    }
  }

  getInfo(People people) {
    people.toJson().forEach((key, value) {
      if (charcaters.contains(key)) {
        if (value.isEmpty) {
          value = "Not found information";
        }

        Map tempMap = {key: value};
        peopleData.addAll(tempMap);
      }
    });
    dev.log(peopleData.toString());

    int emojiIndex = 0;
    peopleData.forEach((key, value) {
      datos.add(PeopleData(
        keey: key,
        value: value,
        emoji: emojis[emojiIndex],
      ));
      emojiIndex++;
    });
  }
}
