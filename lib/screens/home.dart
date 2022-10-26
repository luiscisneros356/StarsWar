import 'package:flutter/material.dart';

import 'package:personajes_star_war/models/people.dart';
import 'package:personajes_star_war/utils/dialog.dart';

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
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 1000)).then((value) {
            provider.clearListPeople();
            provider.infiniteScroll();
          });
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 140,
            flexibleSpace: const Opacity(
              opacity: 0.5,
              child: ImageAsset(
                asset: "logo",
              ),
            ),
          ),
          body: FutureBuilder(
              future: provider.getResults(),
              builder: (context, AsyncSnapshot<List<People>> snapshot) {
                if (provider.isConected) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return const ListPeople();
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
                }

                return const NoConection();
              }),
          floatingActionButton: RotatedBox(
            quarterTurns: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Switch(
                        value: provider.isConected,
                        onChanged: (b) {
                          provider.setIsConected(!provider.isConected);
                          setState(() {});
                        })),
                Fab(
                    name: "My\nReports",
                    onPressed: provider.isConected
                        ? () {
                            Navigator.pushNamed(context, "/reportedList");
                          }
                        : () async {
                            conected();
                          },
                    tag: "3",
                    icon: Icons.report),
                const SizedBox(height: 44),
                Fab(
                  name: "First\npage",
                  onPressed: provider.isConected
                      ? () {
                          provider.setPage(0);
                          setState(() {});
                        }
                      : () async {
                          conected();
                        },
                  tag: "4",
                  icon: Icons.first_page,
                ),
                const SizedBox(height: 44),
                Fab(
                  name: "Load\nmore\npeople",
                  onPressed: provider.isConected
                      ? () {
                          provider.infiniteScroll();
                        }
                      : () async {
                          conected();
                        },
                  tag: "2",
                  icon: Icons.refresh,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> conected() async {
    final conected =
        await showDialog(context: context, builder: (context) => const NoConectionDialog());
    Provider.of<ProviderData>(context, listen: false).setIsConected(conected);
    setState(() {});
  }
}
