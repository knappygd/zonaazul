import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zonaazul/screens/request/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Vars {
  static bool isShowNotificationsInfoSwitched = true;
  static bool isEnableHistorySwitched = true;
  static bool is24FormatSwitched = true;
}

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  static bool isShowNotificationsInfoVisible = false;
  static bool isEnableHistoryVisible = false;
  static bool is24FormatVisible = false;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  bool connection = true;
  Color atc = const Color(0xffbcd1ef).withOpacity(0.5);
  Color ac = const Color(0xffbcd1ef);
  Color itc = Colors.black;
  Color ithc = const Color.fromARGB(255, 97, 107, 123);

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      connection = connected;
    });
    if (connected == true) {
      getValues();
    }
  }

  getValues() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final showNotis = snapshot.get("hasNotificationsEnabled");
      final history = snapshot.get("hasHistoryEnabled");
      final format = snapshot.get("uses24HourFormat");
      setState(() {
        Vars.isShowNotificationsInfoSwitched = showNotis;
        Vars.isEnableHistorySwitched = history;
        Vars.is24FormatSwitched = format;
      });
    });
  }

  changeFormat() async {
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

  @override
  void initState() {
    hasConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Ajustes",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xffbcd1ef).withAlpha(150),
              ),
            ),
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
            const SizedBox(height: 140),
            GestureDetector(
              onTap: () {
                setState(() {
                  isShowNotificationsInfoVisible =
                      !isShowNotificationsInfoVisible;
                  isEnableHistoryVisible = false;
                });
              },
              child: Container(
                color: const Color.fromARGB(255, 15, 19, 35),
                height: 60,
                width: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowNotificationsInfoVisible =
                              !isShowNotificationsInfoVisible;
                          isEnableHistoryVisible = false;
                          is24FormatVisible = false;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Stack(
                            children: [
                              Visibility(
                                visible: isShowNotificationsInfoVisible,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: const Color(0xffbcd1ef)
                                        .withOpacity(0.6),
                                    size: 15,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !isShowNotificationsInfoVisible,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.6),
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Mostrar notificaciones',
                            style: TextStyle(
                              color: Color(0xffbcd1ef),
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Switch.adaptive(
                          value: Vars.isShowNotificationsInfoSwitched,
                          onChanged: (value) async {
                            hasConnection();
                            if (connection == true) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                'hasNotificationsEnabled':
                                    !Vars.isShowNotificationsInfoSwitched
                              });
                              setState(() {
                                Vars.isShowNotificationsInfoSwitched = value;
                              });
                            } else {
                              print('nope');
                            }
                          },
                          activeTrackColor: atc,
                          activeColor: ac,
                          inactiveTrackColor: itc,
                          inactiveThumbColor: ithc,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isShowNotificationsInfoVisible,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Habilitado por defecto',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.3),
                          fontSize: 13,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'DM Sans',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Cada vez que se genera un estacionamiento,\nla app va a mostrar una notificación\nindicando el tiempo restante, y luego\notra notificación indicando que\nel tiempo se terminó.',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isEnableHistoryVisible = !isEnableHistoryVisible;
                  isShowNotificationsInfoVisible = false;
                  is24FormatVisible = false;
                });
              },
              child: Container(
                color: const Color.fromARGB(255, 15, 19, 35).withOpacity(0.5),
                height: 60,
                width: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Stack(
                          children: [
                            Visibility(
                              visible: isEnableHistoryVisible,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.6),
                                  size: 15,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !isEnableHistoryVisible,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: const Color(0xffbcd1ef).withOpacity(0.6),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Historial',
                          style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Switch.adaptive(
                          value: Vars.isEnableHistorySwitched,
                          onChanged: (value) async {
                            hasConnection();
                            if (connection == true) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                'hasHistoryEnabled':
                                    !Vars.isEnableHistorySwitched
                              });
                              setState(() {
                                Vars.isEnableHistorySwitched = value;
                                //Var.areHistoryElementsVisible = value;
                              });
                            } else {
                              print('nope');
                            }
                          },
                          activeTrackColor:
                              const Color(0xffbcd1ef).withOpacity(0.5),
                          activeColor: const Color(0xffbcd1ef),
                          inactiveTrackColor: Colors.black,
                          inactiveThumbColor:
                              const Color.fromARGB(255, 97, 107, 123),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isEnableHistoryVisible,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Habilitado por defecto',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.3),
                          fontSize: 13,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'DM Sans',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'El historial registra todas las veces que\nestacionaste, incluyendo hora,\nfecha y tiempo.\nDeshabilitar esta opción pausa el historial y\nhace que no sea visible.',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  is24FormatVisible = !is24FormatVisible;
                  isShowNotificationsInfoVisible = false;
                  isEnableHistoryVisible = false;
                });
              },
              child: Container(
                color: const Color.fromARGB(255, 15, 19, 35),
                height: 60,
                width: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Stack(
                          children: [
                            Visibility(
                              visible: is24FormatVisible,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.6),
                                  size: 15,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !is24FormatVisible,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: const Color(0xffbcd1ef).withOpacity(0.6),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Formato 24 horas',
                          style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Switch.adaptive(
                          value: Vars.is24FormatSwitched,
                          onChanged: (value) async {
                            hasConnection();
                            if (connection == true) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                'uses24HourFormat': !Vars.is24FormatSwitched
                              });
                              changeFormat();
                              setState(() {
                                Vars.is24FormatSwitched = value;
                              });
                            } else {
                              print('nope');
                            }
                          },
                          activeTrackColor:
                              const Color(0xffbcd1ef).withOpacity(0.5),
                          activeColor: const Color(0xffbcd1ef),
                          inactiveTrackColor: Colors.black,
                          inactiveThumbColor:
                              const Color.fromARGB(255, 97, 107, 123),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: is24FormatVisible,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Habilitado por defecto',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.3),
                          fontSize: 13,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'DM Sans',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Alterna entre formato de 12 o 24 horas.\nAl estar activado, la hora que se muestra\nen los botones para estacionar va a ser en\nformato de 24 horas, o de 12 si la opción\nestá desactivada.',
                        style: TextStyle(
                          color: const Color(0xffbcd1ef).withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Visibility(
              visible: !connection,
              child: Text(
                'Los ajustes no se registran sin una\nconexión activa a internet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      const Color.fromARGB(255, 255, 158, 158).withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
