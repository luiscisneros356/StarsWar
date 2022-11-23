import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';
import 'package:personajes_star_war/service/services.dart';
import 'package:personajes_star_war/utils/hive.dart';

import '../widgets/people_data.dart';

class ProviderData extends ChangeNotifier {
  List<People> listPeople = [];
  List<Widget> datos = [];
  int _page = 0;
  int get page => _page;

//TODO: todos los siguientes booleanos sirven para determinar la navegacion y el estado de la app.
  bool _isInitPage = false;
  bool get isInitPage => _isInitPage;
  void setInitPage(bool v) {
    _isInitPage = v;
    notifyListeners();
  }

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

  bool _isConected = Boxes.hasConnection();
  bool get isConected => _isConected;

  void setIsConected(bool val) {
    final boolAsInt = val ? 1 : 0;
    Boxes.putConnection(boolAsInt);
    _isConected = val;
    notifyListeners();
  }

  People? _people;
  People? get people => _people;
  Map peopleData = {};

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
    if (_isInitPage) {
      //TODO: Si el usuario reincia la app, se va a llamar a la última pagina guardada
      return Boxes.getPage();
    } else {
      if (backFromDetail || backFromReport) {
        return _page;
      } else {
        return paginated();
      }
    }
  }

//TODO: Paginación y guardado de la página en Boxes
//si, se llega al limite de páginas, se vuelve a mostrar la primera,
//igualmente también se lanza la excepcion en la llamada a la API
  int paginated() {
    _page = Boxes.getPage();

    if (isNextPage) {
      if (_page >= 9 || _page <= 0) _page = 0;
      _page++;
    } else {
      _page--;
      if (_page <= 0) _page = 1;
    }
    Boxes.putPage(_page);

    return _page;
  }
//TODO: Repositories: Realizar las llamadas de API en el manejo de estados o en la
//interfaz es una implementación erronea
// ¿Cuál seria la implementacion adecuada?

  Future<List<People>> getPeople() async {
    int index = indexPage();
    return listPeople = await ConectionsService.getResults(index);
  }

  Future<bool> sendResult(People p) async {
    return await ConectionsService.sendResult(p);
  }

//TODO: esta función lo que permite es trabajar al objeto People en lo detalles, que fue seteado y seleccionado por el usuario
// pero como un Map. Queria hacer algo distinto a lo que normalmente se hace que es basicamente utilizar la instancia
//de People e ir mostrando sus atributos y haciendo las validaciones tales como si la lista esta vacia, que no se
//muestre el atributo entre otros detalles.
//Me pareció que haciendo esto podia usar funciones  de Dart en relacion a los Maps, for, forEch, addAll, algo con lo que normalmente no trabajo mucho.
// Se que no es lo óptimo ni lo  común, solo buscaba realizar algo diferente. Hasta cree un widget que reflejara los datos del Map.
// Un comentario que me hicieron es te que Detalle de personaje: No obtiene los datos como corresponde de la API. No es necesario llamar de nuevo a la API de nuevo.
//Se llama una sola vaez a la API, cuando se traer la lista de personajes de acuerdo a su página, luego se setea el personaje seleccionado en el gestor de estado,
// y apartir de eso se muestra la informacion.
//No es necesario llamar a la API cada vez que se elige un personaje, eso consumiria muchos recursos

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

    int emojiIndex = 0;
    peopleData.forEach((key, value) {
//Widget que creado para leer un Map con valores dinámicos y hace sus respectivas validaciones segun el valor que tengan-
      datos.add(PeopleData(
        keey: key,
        value: value,
        emoji: emojis[emojiIndex],
      ));
      emojiIndex++;
    });
  }
}
