import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';

import 'package:personajes_star_war/utils/image_assets.dart';
import 'package:personajes_star_war/utils/style.dart';

import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../widgets/list_people.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderData>(context, listen: false);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 1000)).then((value) {
            provider.clearListPeople();
            provider.infiniteScroll();
          });
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 140,
            flexibleSpace: Opacity(
              opacity: 0.5,
              child: ImageAsset(
                asset: "logo",
              ),
            ),
          ),
          body: FutureBuilder(
              future: provider.getResults(),
              builder: (context, AsyncSnapshot<List<People>> snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return ListPeople();
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 10,
                      ),
                      Text(
                        "Cargando personajes",
                        style: AppTextStyle.title(color: Colors.black),
                      )
                    ],
                  ));
                }
                return Container();
              }),
          floatingActionButton: Row(
            children: [
              FloatingActionButton(
                  heroTag: "1",
                  onPressed: () {
                    provider.clearListPeople();
                    provider.setPage(0);
                    setState(() {});
                  },
                  child: Icon(Icons.add)),
              FloatingActionButton(
                heroTag: "2",
                onPressed: () {
                  provider.infiniteScroll();
                },
                child: Icon(Icons.abc),
              ),
              FloatingActionButton(
                heroTag: "3",
                onPressed: () {},
                child: Icon(Icons.reset_tv),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
