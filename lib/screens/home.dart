import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';

import 'package:personajes_star_war/utils/image_assets.dart';
import 'package:personajes_star_war/utils/style.dart';

import 'package:provider/provider.dart';

import '../provider/provider.dart';
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
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return const ListPeople();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Loading people",
                      style: AppTextStyle.title(color: Colors.black),
                    )
                  ],
                ));
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
                provider.setInitPage(false);
                provider.setIsBackFromDetail(false);
                provider.setIsBackFromReport(false);
                provider.setIsNextPage(false);

                setState(() {});
              },
              tag: "2",
              icon: Icons.arrow_back_ios,
            ),
            Fab(
              name: "Next\npage",
              onPressed: () {
                provider.setInitPage(false);

                provider.setIsBackFromDetail(false);
                provider.setIsBackFromReport(false);
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

  // Future<void> conected() async {
  //   final conected =
  //       await showDialog(context: context, builder: (context) => const NoConectionDialog());
  //   Provider.of<ProviderData>(context, listen: false).setIsConected(conected);
  //   setState(() {});
  // }
}
