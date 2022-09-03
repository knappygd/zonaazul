import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zonaazul/screens/history/hive/data.dart';
import 'package:zonaazul/screens/history/hive/savedata.dart';
import 'package:zonaazul/screens/settings/usersettings.dart';

class Var {
  static bool areHistoryElementsVisible = true;
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Data> data = [];
  SaveData saveData = const SaveData();
  bool r = false;
  //static bool areHistoryElementsVisible = true;
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  Future<void> getData() async {
    data = await saveData.parkingData;
    setState(() {});
  }

  getValues() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final history = snapshot.get("hasHistoryEnabled");
      setState(() {
        Var.areHistoryElementsVisible = history;
      });
    });
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff161b33),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Historial",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xffbcd1ef).withAlpha(150),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRouteToSettings());
                  },
                  child: const Icon(
                    Icons.settings,
                    color: Color(0xffbcd1ef),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Color(0xffbcd1ef),
                  ),
                ),
              ],
            ),
            // Visibility(
            //   visible: Var.areHistoryElementsVisible,
            //   child: IconButton(
            //     onPressed: () async {
            //       await Hive.box('Parking Data').clear();
            //     },
            //     icon: const Icon(
            //       Icons.delete_forever_rounded,
            //       color: Color(0xffbcd1ef),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff161b33),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Visibility(
                    visible: !Var.areHistoryElementsVisible,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 200),
                              const Text(
                                'El historial está desactivado',
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffbcd1ef),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Podés ir a ',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffbcd1ef)
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(_createRouteToSettings());
                                    },
                                    child: Text(
                                      'ajustes',
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xffbcd1ef)
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' para cambiar esto',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffbcd1ef)
                                          .withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: Var.areHistoryElementsVisible,
                    child: FutureBuilder<List<Data>>(
                        future: saveData.parkingData,
                        builder: (context, snapshot) {
                          // ignore: prefer_is_empty
                          if (snapshot.data?.length == 0) {
                            return RefreshIndicator(
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 16, 30),
                              color: const Color(0xffbcd1ef),
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  //setState(() {});
                                });
                              },
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 200),
                                        const Text(
                                          'Aún no hay nada registrado',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xffbcd1ef),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Cada vez que estaciones, se creará\nuna tarjeta indicando los datos',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xffbcd1ef)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return RawScrollbar(
                              thumbColor: const Color(0xffbcd1ef).withAlpha(70),
                              radius: const Radius.circular(2),
                              thickness: 2,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        width: 350,
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 15, 18, 35),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: const Color(0xffbcd1ef)
                                                  .withOpacity(0.3),
                                              width: 2,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    snapshot.data![index].date,
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Estacionamiento por ' +
                                                        snapshot.data![index]
                                                            .lapse +
                                                        ',',
                                                    style: const TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xffbcd1ef),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'a las ' +
                                                        snapshot
                                                            .data![index].time,
                                                    style: const TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xffbcd1ef),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  );
                                }),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRouteToSettings() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const UserSettings(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
