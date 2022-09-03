import 'package:flutter/material.dart';
import 'package:zonaazul/screens/account/account.dart';
import 'package:zonaazul/screens/bluecard/cardinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zonaazul/screens/history/history.dart';
import 'package:zonaazul/screens/inspect/watchguys.dart';
import 'package:zonaazul/screens/settings/usersettings.dart';
import 'package:zonaazul/screens/whatsthis/whatsthis.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DrawerBar extends StatefulWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  DrawerBarState createState() => DrawerBarState();
}

class DrawerBarState extends State<DrawerBar> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Color tarjetaAzul = const Color(0xffbcd1ef);
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  bool inspector = false;
  var connection = InternetConnectionChecker().hasConnection;

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    if (connected == true) {
      setTarjetaAzulColor();
      checkInspectorState();
    }
  }

  void setTarjetaAzulColor() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final amount = snapshot.get("cardamt");
      if (amount >= 100) {
        setState(() {
          tarjetaAzul = const Color(0xffbcd1ef);
        });
      } else if (amount < 100 && amount > 45) {
        setState(() {
          tarjetaAzul = const Color.fromARGB(255, 255, 207, 158);
        });
      } else if (amount <= 45) {
        setState(() {
          tarjetaAzul = const Color.fromARGB(255, 255, 158, 158);
        });
      }
    });
  }

  checkInspectorState() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final inspState = snapshot.get("isInspector");
      if (inspState == true) {
        setState(() {
          inspector = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    hasConnection();
    //checkInspectorState();
    //setTarjetaAzulColor();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 29, 32, 51),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RawScrollbar(
                thumbColor: const Color(0xffbcd1ef).withAlpha(70),
                radius: const Radius.circular(2),
                thickness: 2,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            color: Colors.transparent,
                            child: const Icon(Icons.arrow_back_ios_new_rounded,
                                color: Color(0xffbcd1ef)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Visibility(
                      visible: inspector,
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                          //Navigator.pushNamed(context, '/account/account');
                          Navigator.of(context).push(_createRouteToWatchguys());
                        },
                        child: SizedBox(
                          height: 110,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.transparent,
                                height: 50,
                                width: 310,
                                child: Center(
                                  child: Row(
                                    children: const [
                                      SizedBox(width: 20),
                                      SizedBox(
                                        child: Icon(
                                          Icons.verified_rounded,
                                          color: Color.fromARGB(
                                              255, 255, 225, 115),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Inspeccionar',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 225, 115),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Text(
                                    "Verificar el estado de\nestacionamiento de los vehículos",
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: const Color.fromARGB(
                                              255, 255, 225, 115)
                                          .withAlpha(100),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        Navigator.of(context).push(_createRouteToAccount());
                      },
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 310,
                              child: Center(
                                child: Row(
                                  children: const [
                                    SizedBox(width: 20),
                                    SizedBox(
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xffbcd1ef),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Cuenta',
                                      style: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DM Sans'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  "Cambiar nombre, email\no matrícula",
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xffbcd1ef)
                                          .withAlpha(100)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        Navigator.of(context).push(_createRouteToCardInfo());
                      },
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 310,
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      child: Icon(
                                        Icons.qr_code_rounded,
                                        color: tarjetaAzul,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Tarjeta Azul',
                                      style: TextStyle(
                                        color: tarjetaAzul,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: users.doc(uid).get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: tarjetaAzul.withAlpha(100),
                                            );
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;
                                            return Text(
                                              ' - \$' +
                                                  data['cardamt'].toString(),
                                              style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontStyle: FontStyle.italic,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    tarjetaAzul.withAlpha(100),
                                              ),
                                            );
                                          }

                                          return Text(
                                            ' - \$0',
                                            style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                              color: tarjetaAzul.withAlpha(100),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  "Escanear código QR,\nver información",
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: tarjetaAzul.withAlpha(100),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        Navigator.of(context).push(_createRouteToSettings());
                      },
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 310,
                              child: Center(
                                child: Row(
                                  children: const [
                                    SizedBox(width: 20),
                                    SizedBox(
                                      child: Icon(
                                        Icons.dashboard_rounded,
                                        color: Color(0xffbcd1ef),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Ajustes',
                                      style: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DM Sans'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  "Visibilidad del historial,\nadministrar notificaciones, etc.",
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color:
                                        const Color(0xffbcd1ef).withAlpha(100),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        Navigator.of(context).push(_createRouteToHistory());
                      },
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 310,
                              child: Center(
                                child: Row(
                                  children: const [
                                    SizedBox(width: 20),
                                    SizedBox(
                                      child: Icon(
                                        Icons.history,
                                        color: Color(0xffbcd1ef),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Historial',
                                      style: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DM Sans'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  "Registro de estacionamiento\n(fecha, hora, tiempo, etc.)",
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xffbcd1ef)
                                          .withAlpha(100)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        Navigator.of(context).push(_createRouteToWhatsThis());
                      },
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 310,
                              child: Center(
                                child: Row(
                                  children: const [
                                    SizedBox(width: 20),
                                    SizedBox(
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: Color(0xffbcd1ef),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Acerca de',
                                      style: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DM Sans'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  "Información sobre la aplicación,\ntarifas, tiempo, disponibilidad, etc.",
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xffbcd1ef)
                                          .withAlpha(100)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      child: Center(
                        child: Text(
                          "Versión 0.1.0  •  Paysandú, Uruguay",
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xffbcd1ef).withAlpha(50)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRouteToAccount() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const Account(),
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

Route _createRouteToWhatsThis() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const WhatsThis(),
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

Route _createRouteToCardInfo() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const CardInfo(),
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

Route _createRouteToSettings() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const UserSettings(),
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

Route _createRouteToHistory() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const History(),
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

Route _createRouteToWatchguys() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const Watchguys(),
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
