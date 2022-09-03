import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zonaazul/screens/bluecard/cardinfo.dart';
import 'options/modify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  String name = '';
  String plate = '';
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  bool connection = false;

  void getNameAndPlate() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final nameFirestore = snapshot.get("name");
      final plateFirestore = snapshot.get("defPlate");
      setState(() {
        name = nameFirestore;
        plate = plateFirestore;
      });
    });
  }

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    if (connected == true) {
      getNameAndPlate();
      setState(() {
        connection = connected;
      });
    }
  }

  @override
  void initState() {
    hasConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "Cuenta",
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffbcd1ef).withAlpha(150)),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff161b33),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Visibility(
                            visible: !connection,
                            child: const CircularProgressIndicator(
                              color: Color(0xffbcd1ef),
                            )),
                        Visibility(
                          visible: connection,
                          child: Text(
                            name,
                            style: const TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Visibility(
                            visible: !connection,
                            child: CircularProgressIndicator(
                              color: const Color(0xffbcd1ef).withAlpha(150),
                            )),
                        Visibility(
                          visible: connection,
                          child: Text(
                            plate,
                            style: TextStyle(
                                color: const Color(0xffbcd1ef).withAlpha(150),
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'FE-Font'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 70),
              // Modify data
              InkWell(
                child: OutlinedButton(
                  onPressed: () async {
                    var connected =
                        await InternetConnectionChecker().hasConnection;
                    if (connected == true) {
                      Navigator.of(context).push(_createRouteToModify());
                    }
                  },
                  child: const Text(
                    "Modificar datos",
                    style: TextStyle(
                        color: Color(0xffbcd1ef),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DM Sans'),
                    textAlign: TextAlign.center,
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(330, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 3,
                      color: Color(0xffbcd1ef),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                child: OutlinedButton(
                  onPressed: () async {
                    var connected =
                        await InternetConnectionChecker().hasConnection;
                    if (connected == true) {
                      Navigator.of(context).push(_createRouteToCardInfo());
                    }
                  },
                  child: const Text(
                    "Tarjeta Azul",
                    style: TextStyle(
                        color: Color(0xffbcd1ef),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DM Sans'),
                    textAlign: TextAlign.center,
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(330, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 3,
                      color: Color(0xffbcd1ef),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Log out
              SizedBox(
                width: 330,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, '/');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              //FontAwesomeIcons.arrowCircleLeft,
                              Icons.arrow_back_rounded,
                              size: 40,
                              color: Color(0xffbcd1ef),
                            ),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(80, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color(0xffbcd1ef),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    InkWell(
                      child: OutlinedButton(
                        onPressed: () async {
                          var connected =
                              await InternetConnectionChecker().hasConnection;
                          if (connected == true) {
                            await FirebaseAuth.instance.signOut();
                          }
                        },
                        child: const Text(
                          "Salir de la cuenta",
                          style: TextStyle(
                              color: Color(0xffbcd1ef),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'DM Sans'),
                          textAlign: TextAlign.center,
                        ),
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(220, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color(0xffbcd1ef),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRouteToModify() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const Modify(),
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
