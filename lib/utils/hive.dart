import 'package:hive/hive.dart';
import 'package:personajes_star_war/models/people.dart';

class Boxes {
  static Box<People> listReportedPeople() => Hive.box("people");
  static Box<int> currentPage() => Hive.box("page");
  static Box<int> isConnected() => Hive.box("connected");

  static void putPage(int page) async {
    final box = currentPage();

    await box.put("page", page);
  }

  static int getPage() {
    final box = currentPage();
    return box.get("page") ?? 0;
  }

  static void putConnection(int value) async {
    final box = isConnected();
    await box.put("connected", value);
  }

  static int getConnection() {
    final box = isConnected();
    return box.get("connected") ?? 0;
  }

  static bool hasConnection() {
    return Boxes.getConnection() == 1 ? true : false;
  }

  static Future<void> addPeople(People? p) async {
    final box = listReportedPeople();
    await box.add(p!);
  }

  static deletePeople(int index) async {
    final box = listReportedPeople();
    await box.deleteAt(index);
  }

  static deleteAllPeople() async {
    final box = listReportedPeople();
    await box.deleteAll(listReportedPeople().keys.toList());
    await box.clear();
  }

  static Future initData() async {
    Hive.registerAdapter(PeopleAdapter());
    await Hive.openBox<People>("people");
    await Hive.openBox<int>("page");
    await Hive.openBox<int>("connected");
  }
}
