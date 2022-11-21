import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';
import 'package:personajes_star_war/service/services.dart';

import '../widgets/people_data.dart';

class ProviderData extends ChangeNotifier {
  List<People> listPeople = [];

  List<Widget> datos = [];
  int _page = 0;
  int get page => _page;

  bool _isNextPage = false;
  bool get isNextPage => _isNextPage;
  void setIsNextPage(bool v) {
    _isNextPage = v;

    notifyListeners();
  }

  bool _backFromDetail = false;
  bool get backFromDetail => _backFromDetail;
  void setIsBackFromDetail(bool v) {
    _backFromDetail = v;
    notifyListeners();
  }

  bool _backFromReport = false;
  bool get backFromReport => _backFromReport;
  void setIsBackFromReport(bool v) {
    _backFromReport = v;
    notifyListeners();
  }

  bool _isConected = true;
  bool get isConected => _isConected;
  void setIsConected(bool val) {
    _isConected = val;
    notifyListeners();
  }

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

  People? _peopleReported;
  People? get peopleReported => _peopleReported;

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
  int indexPage() {
    // print("backFromDetail $backFromDetail");
    // print("backFromReport $backFromReport");

    if (backFromDetail || backFromReport) {
      return _page;
    } else {
      return paginated();
    }
  }

  int paginated() {
    if (isNextPage) {
      if (_page == 9 || _page == 0) {
        _page = 0;
      }
      _page++;
    } else {
      if (_page == 0) {
        return _page = 1;
      }

      _page--;
      if (_page == 0) {
        return _page = 1;
      }
    }

    return _page;
  }

  Future<List<People>> getPeople() async {
    int index = indexPage();

    return listPeople = await ConectionsService.getResults(index);
  }

  Future<bool> sendResult(People p) async {
    return await ConectionsService.sendResult(p);
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
    //  dev.log(peopleData.toString());

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
