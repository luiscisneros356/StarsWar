import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';
import 'package:personajes_star_war/utils/image_assets.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/loading.dart';
import '../widgets/fab.dart';
import '../widgets/list_people.dart';
import '../widgets/no_conection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderData>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 140,
          flexibleSpace: const ImageAsset(
            asset: "logo",
          ),
        ),
        body: FutureBuilder(
            future: provider.getPeople(),
            builder: (context, AsyncSnapshot<List<People>> snapshot) {
              //TODO: En el requerimiento no se solicitó que no se obtengan datos cuando la
              //“Conexión” esta desactivada.
              // Si es verdad, eso lo agregué yo, por que me pareció que si no no habia "Conexión", no tenia que mostrase datos.
              //Demanera que dependiendo de los datos, se muestre algo o no.
              //Igualmente la “Conexión” ahora solo bloquea el botón de reporte.

              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return const ListPeople();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }

              return const NoConection();
            }),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Fab(
              name: "Back\nPage",
              onPressed: () {
                dataProv(context);
                provider.setIsNextPage(false);

                setState(() {});
              },
              tag: "2",
              icon: Icons.arrow_back_ios,
            ),
            Fab(
              name: "Next\npage",
              onPressed: () {
                dataProv(context);

                provider.setIsNextPage(true);
                setState(() {});
              },
              tag: "4",
              icon: Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}

void dataProv(BuildContext context) {
  final provider = Provider.of<ProviderData>(context, listen: false);
//TODO: esto estaablece la
  provider.setInitPage(false);
  provider.setIsBackFromDetail(false);
  provider.setIsBackFromReport(false);
}
