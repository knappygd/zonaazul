import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:zonaazul/screens/account/options/modify/multipleplates.dart';
import 'package:zonaazul/screens/history/hive/data.dart';
import 'package:zonaazul/utils/drawer.dart';
import 'package:zonaazul/utils/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:zonaazul/screens/settings/usersettings.dart';
import 'package:zonaazul/screens/history/hive/savedata.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  ReqState createState() => ReqState();
}

class ReqState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const DrawerBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const ShowSnackBar(),
      ),
    );
  }
}

class Variables {
  static bool isOneHourFront24FormatVisible = true;
  static bool isOneHourFront12FormatVisible = false;

  static bool isOneHourBack24FormatVisible = true;
  static bool isOneHourBack12FormatVisible = false;

  static bool isThirtyMinsFront24FormatVisible = true;
  static bool isThirtyMinsFront12FormatVisible = false;

  static bool isThirtyMinsBack24FormatVisible = true;
  static bool isThirtyMinsBack12FormatVisible = false;
}

class ShowSnackBar extends StatefulWidget {
  const ShowSnackBar({Key? key}) : super(key: key);

  @override
  State<ShowSnackBar> createState() => _ShowSnackBarState();
}

class _ShowSnackBarState extends State<ShowSnackBar> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Color thirtyMinsColor = const Color(0xffbcd1ef);
  Color oneHourColor = const Color(0xffbcd1ef);
  bool isHourFrontVisible = true;
  bool isHourBackVisible = false;
  bool isMinFrontVisible = true;
  bool isMinBackVisible = false;
  bool oneHourBlock = false;
  bool thirtyMinsBlock = false;

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    if (connected == true) {
      getValues();
    }
  }

  getValues() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final format = snapshot.get("uses24HourFormat");
      setState(() {
        Variables.isOneHourFront24FormatVisible = format;
        Variables.isOneHourFront12FormatVisible = !format;

        Variables.isOneHourBack24FormatVisible = format;
        Variables.isOneHourBack12FormatVisible = !format;

        Variables.isThirtyMinsFront24FormatVisible = format;
        Variables.isThirtyMinsFront12FormatVisible = !format;

        Variables.isThirtyMinsBack24FormatVisible = format;
        Variables.isThirtyMinsBack12FormatVisible = !format;
      });
    });
  }

  SaveData saveData = const SaveData();

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  getTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }

  getDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void oneHour() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final amount = snapshot.get("cardamt");
      final isParked = snapshot.get("isCurrentlyParked");
      if (amount >= 45) {
        if (isParked == false) {
          transaction.update(docRef, {
            "cardamt": amount - 45,
            "isCurrentlyParked": true,
          });
          Future.delayed(const Duration(seconds: 5), () async {
            await FirebaseFirestore.instance
                .runTransaction((transaction) async {
              transaction.update(docRef, {"isCurrentlyParked": false});
            });
          });
          setState(() {
            isHourFrontVisible = !isHourFrontVisible;
            isHourBackVisible = !isHourBackVisible;
            thirtyMinsColor = const Color(0xffbcd1ef).withOpacity(0.5);
            thirtyMinsBlock = true;
          });
          if (Vars.isEnableHistorySwitched == true) {
            await saveData.saveData(
              Data(
                date: getDate(),
                lapse: '1 hora',
                time: getTime(),
              ),
            );
          }
          if (Vars.isShowNotificationsInfoSwitched == true) {
            NotificationService().showTimerNotification(
              1,
              "Estacionamiento por 1 hora",
              "Podés obtener más tiempo luego de que se acabe",
            );
            Future.delayed(const Duration(seconds: 6), () {
              createFiveMinsNotification();
              NotificationService().cancelAllNotifications();
            });
            AwesomeNotifications().cancel(2);
          }
        } else if (isParked == true) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarParked);
        }
      } else if (amount < 45) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void thirtyMins() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final amount = snapshot.get("cardamt");
      final isParked = snapshot.get("isCurrentlyParked");
      if (amount >= 30) {
        if (isParked == false) {
          transaction.update(docRef, {
            "cardamt": amount - 30,
            "isCurrentlyParked": true,
          });
          Future.delayed(const Duration(seconds: 5), () async {
            await FirebaseFirestore.instance
                .runTransaction((transaction) async {
              transaction.update(docRef, {"isCurrentlyParked": false});
            });
          });
          setState(() {
            isMinFrontVisible = !isMinFrontVisible;
            isMinBackVisible = !isMinBackVisible;
            oneHourColor = const Color(0xffbcd1ef).withOpacity(0.5);
            oneHourBlock = true;
          });
          if (Vars.isEnableHistorySwitched == true) {
            await saveData.saveData(
              Data(
                date: getDate(),
                lapse: '30 minutos',
                time: getTime(),
              ),
            );
          }
          if (Vars.isShowNotificationsInfoSwitched == true) {
            NotificationService().showTimerNotification(
              1,
              "Estacionamiento por 30 minutos",
              "Podés obtener más tiempo luego de que se acabe",
            );
            Future.delayed(const Duration(seconds: 6), () {
              createFiveMinsNotification();
              NotificationService().cancelAllNotifications();
            });
            AwesomeNotifications().cancel(2);
          }
        } else if (isParked == true) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarParked);
        }
      } else if (amount < 30) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    hasConnection();
    setState(() {});
  }

  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'No tenés saldo suficiente',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 255, 158, 158),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.warning_rounded,
          color: Color.fromARGB(255, 255, 158, 158),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 2),
    elevation: 10,
  );

  final snackBarParked = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Estacionamiento en curso',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 255, 252, 158),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.warning_rounded,
          color: Color.fromARGB(255, 255, 252, 158),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 2),
    elevation: 10,
  );

  final snackBarTime = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Gratis de 8:00 a 18:00',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 255, 252, 158),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.alarm_rounded,
          color: Color.fromARGB(255, 255, 252, 158),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 2),
    elevation: 10,
  );

  final snackBarNoConnection = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'No hay conexión',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 255, 158, 158),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.wifi_off_rounded,
          color: Color.fromARGB(255, 255, 158, 158),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 2),
    elevation: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff161b33),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          SvgPicture.asset('assets/images/zonaazullogo.svg',
              width: 150, height: 75),
          const SizedBox(height: 35),
          SizedBox(
            width: 180,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    var connected =
                        await InternetConnectionChecker().hasConnection;
                    if (connected == true) {
                      Navigator.of(context)
                          .push(_createRouteToMultiplePlates());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 16, 19, 37),
                    ),
                    child: Center(
                      child: FutureBuilder(
                          future: users.doc(uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return CircularProgressIndicator(
                                strokeWidth: 2,
                                color: const Color(0xffbcd1ef).withAlpha(100),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Text(
                                data['defPlate'],
                                style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.5),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }
                            return Text(
                              'Matrícula',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: const Color(0xffbcd1ef).withAlpha(20),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 16, 19, 37),
                    ),
                    child: Icon(
                      Icons.refresh_outlined,
                      color: const Color(0xffbcd1ef).withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 35),
          // Row 1hr
          Stack(
            children: [
              Visibility(
                visible: isHourBackVisible,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 330,
                      decoration: BoxDecoration(
                        color: const Color(0xffbcd1ef),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffbcd1ef),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 15),
                          // Container Time
                          SlideCountdownSeparated(
                            onDone: () async {
                              setState(() {
                                isHourFrontVisible = !isHourFrontVisible;
                                isHourBackVisible = !isHourBackVisible;
                                thirtyMinsColor = const Color(0xffbcd1ef);
                                thirtyMinsBlock = false;
                              });
                            },
                            separatorPadding:
                                const EdgeInsets.symmetric(horizontal: 7.3),
                            separator: '',
                            textStyle: TextStyle(
                              foreground: Paint()
                                ..color = const Color(0xffbcd1ef),
                              fontFamily: 'DM Sans',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff161b33),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 70,
                            width: 70,
                            duration: const Duration(seconds: 5),
                          ),
                          const SizedBox(width: 15),
                          // Container Text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 110,
                                height: 35,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Estacionamiento\nhasta',
                                    style: TextStyle(
                                      color: Color(0xff161b33),
                                      fontFamily: 'DM Sans',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              // Container TextTime
                              Stack(
                                children: [
                                  Visibility(
                                    visible:
                                        Variables.isOneHourBack12FormatVisible,
                                    child: SizedBox(
                                      width: 110,
                                      height: 30,
                                      child: StreamBuilder(
                                        stream: Stream.periodic(
                                          const Duration(seconds: 1),
                                        ),
                                        builder: (context, snapshot) {
                                          return Text(
                                            DateFormat('hh:mm:ss').format(
                                              DateTime.now().add(
                                                const Duration(hours: 1),
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff161b33),
                                              fontFamily: 'DM Sans',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        Variables.isOneHourBack24FormatVisible,
                                    child: SizedBox(
                                      width: 110,
                                      height: 30,
                                      child: StreamBuilder(
                                        stream: Stream.periodic(
                                          const Duration(seconds: 1),
                                        ),
                                        builder: (context, snapshot) {
                                          return Text(
                                            DateFormat('HH:mm:ss').format(
                                              DateTime.now().add(
                                                const Duration(hours: 1),
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff161b33),
                                              fontFamily: 'DM Sans',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isHourFrontVisible,
                child: OutlinedButton(
                  onPressed: () async {
                    var connected =
                        await InternetConnectionChecker().hasConnection;
                    if (DateTime.now().hour >= 8 && DateTime.now().hour < 17) {
                      if (connected == true) {
                        oneHour();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarNoConnection);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBarTime);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(330, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(width: 2, color: oneHourColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //const SizedBox(width: 15),
                      // Container Time
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: oneHourColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 31,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Color(0xff161b33),
                                      fontFamily: 'DM Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                'hora',
                                style: TextStyle(
                                    color: Color(0xff161b33),
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Container Price
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: oneHourColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '\$',
                              style: TextStyle(
                                  color: Color(0xff161b33),
                                  fontFamily: 'DM Sans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100),
                            ),
                            Text(
                              '45',
                              style: TextStyle(
                                  color: Color(0xff161b33),
                                  fontFamily: 'DM Sans',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Container Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 35,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Estacionamiento hasta',
                                maxLines: 3,
                                style: TextStyle(
                                  color: oneHourColor,
                                  fontFamily: 'DM Sans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          // Container TextTime
                          Stack(
                            children: [
                              Visibility(
                                visible:
                                    Variables.isOneHourFront12FormatVisible,
                                child: SizedBox(
                                  width: 110,
                                  height: 30,
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                      const Duration(seconds: 1),
                                    ),
                                    builder: (context, snapshot) {
                                      return Text(
                                        DateFormat('hh:mm:ss').format(
                                          DateTime.now().add(
                                            const Duration(hours: 1),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: oneHourColor,
                                          fontFamily: 'DM Sans',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    Variables.isOneHourFront24FormatVisible,
                                child: SizedBox(
                                  width: 110,
                                  height: 30,
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                      const Duration(seconds: 1),
                                    ),
                                    builder: (context, snapshot) {
                                      return Text(
                                        DateFormat('HH:mm:ss').format(
                                          DateTime.now().add(
                                            const Duration(hours: 1),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: oneHourColor,
                                          fontFamily: 'DM Sans',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: oneHourBlock,
                child: Container(
                  color: Colors.transparent,
                  height: 100,
                  width: 330,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Row 30min
          Stack(
            children: [
              Visibility(
                visible: isMinBackVisible,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 330,
                      decoration: BoxDecoration(
                        color: const Color(0xffbcd1ef),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffbcd1ef).withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 15),
                          // Container Time
                          SlideCountdownSeparated(
                            onDone: () async {
                              await FirebaseFirestore.instance.runTransaction(
                                (transaction) async {
                                  transaction.update(docRef, {
                                    "isCurrentlyParked": false,
                                  });
                                },
                              );
                              setState(() {
                                isMinFrontVisible = !isMinFrontVisible;
                                isMinBackVisible = !isMinBackVisible;
                                oneHourBlock = false;
                                oneHourColor = const Color(0xffbcd1ef);
                              });
                            },
                            separatorPadding:
                                const EdgeInsets.symmetric(horizontal: 7.3),
                            separator: '',
                            textStyle: TextStyle(
                                foreground: Paint()
                                  ..color = const Color(0xffbcd1ef),
                                fontFamily: 'DM Sans',
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                            decoration: BoxDecoration(
                              color: const Color(0xff161b33),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 70,
                            width: 70,
                            duration: const Duration(seconds: 5),
                          ),
                          const SizedBox(width: 15),
                          // Container Text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 110,
                                height: 35,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Estacionamiento hasta',
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Color(0xff161b33),
                                      fontFamily: 'DM Sans',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              // Container TextTime
                              Stack(
                                children: [
                                  Visibility(
                                    visible: Variables
                                        .isThirtyMinsBack12FormatVisible,
                                    child: SizedBox(
                                      width: 110,
                                      height: 30,
                                      child: StreamBuilder(
                                        stream: Stream.periodic(
                                          const Duration(seconds: 1),
                                        ),
                                        builder: (context, snapshot) {
                                          return Text(
                                            DateFormat('hh:mm:ss').format(
                                              DateTime.now().add(
                                                const Duration(minutes: 30),
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff161b33),
                                              fontFamily: 'DM Sans',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: Variables
                                        .isThirtyMinsBack24FormatVisible,
                                    child: SizedBox(
                                      width: 110,
                                      height: 30,
                                      child: StreamBuilder(
                                        stream: Stream.periodic(
                                          const Duration(seconds: 1),
                                        ),
                                        builder: (context, snapshot) {
                                          return Text(
                                            DateFormat('HH:mm:ss').format(
                                              DateTime.now().add(
                                                const Duration(minutes: 30),
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff161b33),
                                              fontFamily: 'DM Sans',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isMinFrontVisible,
                child: OutlinedButton(
                  onPressed: () async {
                    var connected =
                        await InternetConnectionChecker().hasConnection;
                    if (DateTime.now().hour >= 8 && DateTime.now().hour < 18) {
                      if (connected == true) {
                        thirtyMins();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarNoConnection);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBarTime);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(330, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      width: 2,
                      color: thirtyMinsColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //const SizedBox(width: 15),
                      // Container Time
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: thirtyMinsColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 31,
                                child: Text(
                                  '30',
                                  style: TextStyle(
                                      color: Color(0xff161b33),
                                      fontFamily: 'DM Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                'min',
                                style: TextStyle(
                                    color: Color(0xff161b33),
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Container Price
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: thirtyMinsColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '\$',
                              style: TextStyle(
                                  color: Color(0xff161b33),
                                  fontFamily: 'DM Sans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100),
                            ),
                            Text(
                              '30',
                              style: TextStyle(
                                  color: Color(0xff161b33),
                                  fontFamily: 'DM Sans',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Container Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 35,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Estacionamiento hasta',
                                maxLines: 3,
                                style: TextStyle(
                                    color: thirtyMinsColor,
                                    fontFamily: 'DM Sans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          // Container TextTime
                          Stack(
                            children: [
                              Visibility(
                                visible:
                                    Variables.isThirtyMinsFront12FormatVisible,
                                child: SizedBox(
                                  width: 110,
                                  height: 30,
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                      const Duration(seconds: 1),
                                    ),
                                    builder: (context, snapshot) {
                                      return Text(
                                        DateFormat('hh:mm:ss').format(
                                          DateTime.now().add(
                                            const Duration(minutes: 30),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: thirtyMinsColor,
                                          fontFamily: 'DM Sans',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    Variables.isThirtyMinsFront24FormatVisible,
                                child: SizedBox(
                                  width: 110,
                                  height: 30,
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                      const Duration(seconds: 1),
                                    ),
                                    builder: (context, snapshot) {
                                      return Text(
                                        DateFormat('HH:mm:ss').format(
                                          DateTime.now().add(
                                            const Duration(minutes: 30),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: thirtyMinsColor,
                                          fontFamily: 'DM Sans',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: thirtyMinsBlock,
                child: Container(
                  color: Colors.transparent,
                  height: 100,
                  width: 330,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Row info
          Container(
            height: 70,
            width: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xffbcd1ef),
                width: 2,
              ),
            ),
            child: Center(
              child: Row(
                children: const [
                  SizedBox(width: 15),
                  Icon(Icons.info, color: Color(0xffbcd1ef), size: 35),
                  SizedBox(width: 15),
                  Text(
                    "Podés estacionar sin costo\npor 5 minutos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffbcd1ef),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Route _createRouteToMultiplePlates() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MultiplePlates(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
