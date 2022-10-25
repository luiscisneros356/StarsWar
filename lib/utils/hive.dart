import 'package:hive/hive.dart';
import 'package:personajes_star_war/models/people.dart';

class Boxes {
  static Box<People> listReportedPeople() => Hive.box("people");

  static Future<void> addPeople(People? p) async {
    final box = listReportedPeople();
    // p?.edited = DateTime.now();
    print("date time ${p?.edited}");
    box.add(p!);
    print("datetime");
    print(box.values.toList().last.edited);
    print(box.values.toList().last.name);
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
}
