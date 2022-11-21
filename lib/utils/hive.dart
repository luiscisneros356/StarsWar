import 'package:hive/hive.dart';
import 'package:personajes_star_war/models/people.dart';

class Boxes {
  static Box<People> listReportedPeople() => Hive.box("people");
  static Box<int> currentPage() => Hive.box("page");

  static putPage(int page) {
    final box = currentPage();
    box.put("page", page);
  }

  static int getPage() {
    final box = currentPage();
    return box.get("page") ?? 0;
  }

  static Future<void> addPeople(People? p) async {
    final box = listReportedPeople();
    box.add(p!);
  }

  static deletePeople(int index) async {
    final box = listReportedPeople();
    box.deleteAt(index);
  }

  static deleteAllPeople() {
    final box = listReportedPeople();
    box.deleteAll(listReportedPeople().keys.toList());
    box.clear();
  }

  static Future initData() async {
    Hive.registerAdapter(PeopleAdapter());
    await Hive.openBox<People>("people");
    await Hive.openBox<int>("page");
  }
}
