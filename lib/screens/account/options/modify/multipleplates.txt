import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../whatsthis/whatsthis.dart';

class MultiplePlates extends StatefulWidget {
  const MultiplePlates({Key? key}) : super(key: key);

  @override
  State<MultiplePlates> createState() => _MultiplePlatesState();
}

class _MultiplePlatesState extends State<MultiplePlates> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  TextEditingController fiveController = TextEditingController();

  bool one = true;
  bool two = true;
  bool three = false;
  bool four = true;
  bool five = true;

  bool onex = true;
  bool twox = true;
  bool threex = true;
  bool fourx = true;
  bool fivex = true;

  bool onebtn = true;
  bool twobtn = true;
  bool threebtn = true;
  bool fourbtn = true;
  bool fivebtn = true;

  bool oneinfo = true;
  bool twoinfo = true;
  bool threeinfo = true;
  bool fourinfo = true;
  bool fiveinfo = true;

  String numone = '1';
  String numtwo = '2';
  String numthree = '3';
  String numfour = '4';
  String numfive = '5';
  String def = 'D';

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  bool connection = false;

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    if (connected == true) {
      getPlateValues();
      setDefault();
      setState(() {
        connection = connected;
      });
    }
  }

  void setDefault() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final onePlateValue = snapshot.get("plate");
      final twoPlateValue = snapshot.get("plate02");
      final threePlateValue = snapshot.get("plate03");
      final fourPlateValue = snapshot.get("plate04");
      final fivePlateValue = snapshot.get("plate05");
      final defPlateValue = snapshot.get("defPlate");

      if (onePlateValue == defPlateValue) {
        setState(() {
          numone = 'D';
          numtwo = '2';
          numthree = '3';
          numfour = '4';
          numfive = '5';

          oneinfo = true;
          twoinfo = false;
          threeinfo = false;
          fourinfo = false;
          fiveinfo = false;
        });
      }

      if (twoPlateValue == defPlateValue) {
        setState(() {
          numone = '1';
          numtwo = 'D';
          numthree = '3';
          numfour = '4';
          numfive = '5';

          oneinfo = false;
          twoinfo = true;
          threeinfo = false;
          fourinfo = false;
          fiveinfo = false;
        });
      }

      if (threePlateValue == defPlateValue) {
        setState(() {
          numone = '1';
          numtwo = '2';
          numthree = 'D';
          numfour = '4';
          numfive = '5';

          oneinfo = false;
          twoinfo = false;
          threeinfo = true;
          fourinfo = false;
          fiveinfo = false;
        });
      }

      if (fourPlateValue == defPlateValue) {
        setState(() {
          numone = '1';
          numtwo = '2';
          numthree = '3';
          numfour = 'D';
          numfive = '5';

          oneinfo = false;
          twoinfo = false;
          threeinfo = false;
          fourinfo = true;
          fiveinfo = false;
        });
      }

      if (fivePlateValue == defPlateValue) {
        setState(() {
          numone = '1';
          numtwo = '2';
          numthree = '3';
          numfour = '4';
          numfive = 'D';

          oneinfo = false;
          twoinfo = false;
          threeinfo = false;
          fourinfo = false;
          fiveinfo = true;
        });
      }
    });
  }

  void getPlateValues() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final onePlateValue = snapshot.get("plate");
      final twoPlateValue = snapshot.get("plate02");
      final threePlateValue = snapshot.get("plate03");
      final fourPlateValue = snapshot.get("plate04");
      final fivePlateValue = snapshot.get("plate05");

      if (onePlateValue == 'None') {
        setState(() {
          one = true;
        });
      } else {
        setState(() {
          one = false;
        });
      }

      if (twoPlateValue == 'None') {
        setState(() {
          two = true;
        });
      } else {
        setState(() {
          two = false;
        });
      }

      if (threePlateValue == 'None') {
        setState(() {
          three = true;
        });
      } else {
        setState(() {
          three = false;
        });
      }

      if (fourPlateValue == 'None') {
        setState(() {
          four = true;
        });
      } else {
        setState(() {
          four = false;
        });
      }

      if (fivePlateValue == 'None') {
        setState(() {
          five = true;
        });
      } else {
        setState(() {
          five = false;
        });
      }
    });
  }

  void addPlates() async {
    final String onePlate = oneController.text.trim();
    final String twoPlate = twoController.text.trim();
    final String threePlate = threeController.text.trim();
    final String fourPlate = fourController.text.trim();
    final String fivePlate = fiveController.text.trim();

    if (onePlate.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'plate': onePlate});
    }

    if (twoPlate.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'plate02': twoPlate});
    }

    if (threePlate.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'plate03': threePlate});
    }

    if (fourPlate.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'plate04': fourPlate});
    }

    if (fivePlate.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'plate05': fivePlate});
    }
  }

  @override
  void initState() {
    hasConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xff161b33),
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Cuenta > ",
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffbcd1ef).withAlpha(100)),
            ),
            Text(
              "Modificar datos > ",
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffbcd1ef).withAlpha(100)),
            ),
            Text(
              "Otros vehículos",
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 13,
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
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // One
                  SizedBox(
                    height: 75,
                    child: Stack(
                      children: [
                        // Plate (one)
                        Visibility(
                          visible: !one,
                          child: SizedBox(
                            width: 330,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 30,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        numone,
                                        style: const TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'DM Sans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 216,
                                  child: GestureDetector(
                                    onTap: () async {
                                      var connected =
                                          await InternetConnectionChecker()
                                              .hasConnection;

                                      if (connected == true) {
                                        await FirebaseFirestore.instance
                                            .runTransaction(
                                                (transaction) async {
                                          final snapshot =
                                              await transaction.get(docRef);
                                          final onePlateValue =
                                              snapshot.get("plate");
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .update(
                                                  {'defPlate': onePlateValue});
                                        });
                                        setDefault();
                                      }
                                    },
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 16, 19, 37),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 10),
                                          FutureBuilder(
                                              future: users.doc(uid).get(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color:
                                                        const Color(0xffbcd1ef)
                                                            .withAlpha(100),
                                                  );
                                                }

                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  Map<String, dynamic> data =
                                                      snapshot.data!.data()
                                                          as Map<String,
                                                              dynamic>;
                                                  return Text(
                                                    data['plate'],
                                                    style: const TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      color: Color(0xffbcd1ef),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  );
                                                }
                                                return Text(
                                                  'Matrícula',
                                                  style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    color:
                                                        const Color(0xffbcd1ef)
                                                            .withAlpha(20),
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Stack(
                                  children: [
                                    Visibility(
                                      visible: !oneinfo,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          var connected =
                                              await InternetConnectionChecker()
                                                  .hasConnection;

                                          if (connected == true) {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .update({'plate': 'None'});
                                            setState(() {
                                              one = true;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Color(0xffbcd1ef),
                                          size: 30,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 16, 19, 37),
                                          fixedSize: const Size(55, 55),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: oneinfo,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(_createRouteToWhatsThis());
                                        },
                                        child: const Icon(
                                          Icons.info_outlined,
                                          color: Color(0xffbcd1ef),
                                          size: 30,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 16, 19, 37),
                                          fixedSize: const Size(55, 55),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // TextField (one)
                        Visibility(
                          visible: one,
                          child: SizedBox(
                            width: 330,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 30,
                                  child: Text(
                                    numone,
                                    style: const TextStyle(
                                      color: Color(0xffbcd1ef),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ),
                                //const SizedBox(width: 20),
                                SizedBox(
                                  width: 291,
                                  height: 75,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isNotEmpty &&
                                          value.length < 6) {
                                        return 'Te faltan caracteres';
                                      } else if (value.length > 7) {
                                        return 'Tenés alguna letra o número extra';
                                      } else if (value.length == 6 &&
                                          !value.startsWith('H')) {
                                        return 'Te faltan caracteres';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: oneController,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffbcd1ef)),
                                    cursorHeight: 25.0,
                                    cursorColor: const Color(0xffbcd1ef),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      helperText: ' ',
                                      errorStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          fontWeight: FontWeight.w400),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          width: 2,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef), width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef), width: 2),
                                      ),
                                      labelText: 'Matrícula',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              100, 188, 209, 239),
                                          fontWeight: FontWeight.w500),
                                      floatingLabelStyle: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Two
                  SizedBox(
                    height: 75,
                    child: Stack(
                      children: [
                        // Plate (two)
                        Visibility(
                          visible: !two,
                          child: SizedBox(
                            width: 330,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 30,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        numtwo,
                                        style: const TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'DM Sans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 216,
                                  child: GestureDetector(
                                    onTap: () async {
                                      var connected =
                                          await InternetConnectionChecker()
                                              .hasConnection;

                                      if (connected == true) {
                                        await FirebaseFirestore.instance
                                            .runTransaction(
                                                (transaction) async {
                                          final snapshot =
                                              await transaction.get(docRef);
                                          final twoPlateValue =
                                              snapshot.get("plate02");
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .update(
                                                  {'defPlate': twoPlateValue});
                                        });
                                        setDefault();
                                      }
                                    },
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 16, 19, 37),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 10),
                                          FutureBuilder(
                                              future: users.doc(uid).get(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color:
                                                        const Color(0xffbcd1ef)
                                                            .withAlpha(100),
                                                  );
                                                }

                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  Map<String, dynamic> data =
                                                      snapshot.data!.data()
                                                          as Map<String,
                                                              dynamic>;
                                                  return Text(
                                                    data['plate02'],
                                                    style: const TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      color: Color(0xffbcd1ef),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  );
                                                }
                                                return Text(
                                                  'Matrícula',
                                                  style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    color:
                                                        const Color(0xffbcd1ef)
                                                            .withAlpha(20),
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Stack(
                                  children: [
                                    Visibility(
                                      visible: twoinfo,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(_createRouteToWhatsThis());
                                        },
                                        child: const Icon(
                                          Icons.info_outlined,
                                          color: Color(0xffbcd1ef),
                                          size: 30,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 16, 19, 37),
                                          fixedSize: const Size(55, 55),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !twoinfo,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          var connected =
                                              await InternetConnectionChecker()
                                                  .hasConnection;

                                          if (connected == true) {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .update({'plate02': 'None'});
                                            setState(() {
                                              two = true;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Color(0xffbcd1ef),
                                          size: 30,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 16, 19, 37),
                                          fixedSize: const Size(55, 55),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // TextField (two)
                        Visibility(
                          visible: two,
                          child: SizedBox(
                            width: 330,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 30,
                                  child: Text(
                                    numtwo,
                                    style: const TextStyle(
                                      color: Color(0xffbcd1ef),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ),
                                //const SizedBox(width: 20),
                                SizedBox(
                                  width: 300,
                                  height: 75,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isNotEmpty &&
                                          value.length < 6) {
                                        return 'Te faltan caracteres';
                                      } else if (value.length > 7) {
                                        return 'Tenés alguna letra o número extra';
                                      } else if (value.length == 6 &&
                                          !value.startsWith('H')) {
                                        return 'Te faltan caracteres';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: twoController,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffbcd1ef)),
                                    cursorHeight: 25.0,
                                    cursorColor: const Color(0xffbcd1ef),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      helperText: ' ',
                                      errorStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          fontWeight: FontWeight.w400),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          width: 2,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 158, 158),
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef), width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef), width: 2),
                                      ),
                                      labelText: 'Matrícula',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              100, 188, 209, 239),
                                          fontWeight: FontWeight.w500),
                                      floatingLabelStyle: TextStyle(
                                          color: Color(0xffbcd1ef),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Three
                  Visibility(
                    visible: threex,
                    child: SizedBox(
                      height: 75,
                      child: Stack(
                        children: [
                          // Plate (three)
                          Visibility(
                            visible: !three,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          numthree,
                                          style: const TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 216,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var connected =
                                            await InternetConnectionChecker()
                                                .hasConnection;

                                        if (connected == true) {
                                          await FirebaseFirestore.instance
                                              .runTransaction(
                                                  (transaction) async {
                                            final snapshot =
                                                await transaction.get(docRef);
                                            final threePlateValue =
                                                snapshot.get("plate03");
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .update({
                                              'defPlate': threePlateValue
                                            });
                                          });
                                          setDefault();
                                        }
                                      },
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 16, 19, 37),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10),
                                            FutureBuilder(
                                                future: users.doc(uid).get(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(100),
                                                    );
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    Map<String, dynamic> data =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;
                                                    return Text(
                                                      data['plate03'],
                                                      style: const TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        color:
                                                            Color(0xffbcd1ef),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    'Matrícula',
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(20),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Stack(
                                    children: [
                                      Visibility(
                                        visible: threeinfo,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                _createRouteToWhatsThis());
                                          },
                                          child: const Icon(
                                            Icons.info_outlined,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !threeinfo,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            var connected =
                                                await InternetConnectionChecker()
                                                    .hasConnection;

                                            if (connected == true) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .update({'plate03': 'None'});
                                              setState(() {
                                                three = true;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // TextField (three)
                          Visibility(
                            visible: three,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Text(
                                      numthree,
                                      style: const TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  //const SizedBox(width: 20),
                                  SizedBox(
                                    width: 300,
                                    height: 75,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            value.length < 6) {
                                          return 'Te faltan caracteres';
                                        } else if (value.length > 7) {
                                          return 'Tenés alguna letra o número extra';
                                        } else if (value.length == 6 &&
                                            !value.startsWith('H')) {
                                          return 'Te faltan caracteres';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: threeController,
                                      textInputAction: TextInputAction.done,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffbcd1ef)),
                                      cursorHeight: 25.0,
                                      cursorColor: const Color(0xffbcd1ef),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        helperText: ' ',
                                        errorStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            fontWeight: FontWeight.w400),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        labelText: 'Matrícula',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                100, 188, 209, 239),
                                            fontWeight: FontWeight.w500),
                                        floatingLabelStyle: TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Four
                  Visibility(
                    visible: fourx,
                    child: SizedBox(
                      height: 75,
                      child: Stack(
                        children: [
                          // Plate (four)
                          Visibility(
                            visible: !four,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          numfour,
                                          style: const TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 216,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var connected =
                                            await InternetConnectionChecker()
                                                .hasConnection;

                                        if (connected == true) {
                                          await FirebaseFirestore.instance
                                              .runTransaction(
                                                  (transaction) async {
                                            final snapshot =
                                                await transaction.get(docRef);
                                            final fourPlateValue =
                                                snapshot.get("plate04");
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .update({
                                              'defPlate': fourPlateValue
                                            });
                                          });
                                          setDefault();
                                        }
                                      },
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 16, 19, 37),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10),
                                            FutureBuilder(
                                                future: users.doc(uid).get(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(100),
                                                    );
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    Map<String, dynamic> data =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;
                                                    return Text(
                                                      data['plate04'],
                                                      style: const TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        color:
                                                            Color(0xffbcd1ef),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    'Matrícula',
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(20),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Stack(
                                    children: [
                                      Visibility(
                                        visible: fourinfo,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                _createRouteToWhatsThis());
                                          },
                                          child: const Icon(
                                            Icons.info_outlined,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !fourinfo,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            var connected =
                                                await InternetConnectionChecker()
                                                    .hasConnection;

                                            if (connected == true) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .update({'plate04': 'None'});
                                              setState(() {
                                                four = true;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // TextField (four)
                          Visibility(
                            visible: four,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Text(
                                      numfour,
                                      style: const TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  //const SizedBox(width: 20),
                                  SizedBox(
                                    width: 300,
                                    height: 75,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            value.length < 6) {
                                          return 'Te faltan caracteres';
                                        } else if (value.length > 7) {
                                          return 'Tenés alguna letra o número extra';
                                        } else if (value.length == 6 &&
                                            !value.startsWith('H')) {
                                          return 'Te faltan caracteres';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: fourController,
                                      textInputAction: TextInputAction.done,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffbcd1ef)),
                                      cursorHeight: 25.0,
                                      cursorColor: const Color(0xffbcd1ef),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        helperText: ' ',
                                        errorStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            fontWeight: FontWeight.w400),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        labelText: 'Matrícula',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                100, 188, 209, 239),
                                            fontWeight: FontWeight.w500),
                                        floatingLabelStyle: TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Five
                  Visibility(
                    visible: fivex,
                    child: SizedBox(
                      height: 75,
                      child: Stack(
                        children: [
                          // Plate (four)
                          Visibility(
                            visible: !five,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          numfive,
                                          style: const TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 216,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var connected =
                                            await InternetConnectionChecker()
                                                .hasConnection;

                                        if (connected == true) {
                                          await FirebaseFirestore.instance
                                              .runTransaction(
                                                  (transaction) async {
                                            final snapshot =
                                                await transaction.get(docRef);
                                            final fivePlateValue =
                                                snapshot.get("plate05");
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(uid)
                                                .update({
                                              'defPlate': fivePlateValue
                                            });
                                          });
                                          setDefault();
                                        }
                                      },
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 16, 19, 37),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10),
                                            FutureBuilder(
                                                future: users.doc(uid).get(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(100),
                                                    );
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    Map<String, dynamic> data =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;
                                                    return Text(
                                                      data['plate05'],
                                                      style: const TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        color:
                                                            Color(0xffbcd1ef),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    'Matrícula',
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      color: const Color(
                                                              0xffbcd1ef)
                                                          .withAlpha(20),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Stack(
                                    children: [
                                      Visibility(
                                        visible: fiveinfo,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                _createRouteToWhatsThis());
                                          },
                                          child: const Icon(
                                            Icons.info_outlined,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !fiveinfo,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            var connected =
                                                await InternetConnectionChecker()
                                                    .hasConnection;

                                            if (connected == true) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .update({'plate05': 'None'});
                                              setState(() {
                                                five = true;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Color(0xffbcd1ef),
                                            size: 30,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 16, 19, 37),
                                            fixedSize: const Size(55, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // TextField (five)
                          Visibility(
                            visible: five,
                            child: SizedBox(
                              width: 330,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 30,
                                    child: Text(
                                      numfive,
                                      style: const TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  //const SizedBox(width: 20),
                                  SizedBox(
                                    width: 300,
                                    height: 75,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            value.length < 6) {
                                          return 'Te faltan caracteres';
                                        } else if (value.length > 7) {
                                          return 'Tenés alguna letra o número extra';
                                        } else if (value.length == 6 &&
                                            !value.startsWith('H')) {
                                          return 'Te faltan caracteres';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: fiveController,
                                      textInputAction: TextInputAction.done,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xffbcd1ef)),
                                      cursorHeight: 25.0,
                                      cursorColor: const Color(0xffbcd1ef),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        helperText: ' ',
                                        errorStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            fontWeight: FontWeight.w400),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xffbcd1ef),
                                              width: 2),
                                        ),
                                        labelText: 'Matrícula',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                100, 188, 209, 239),
                                            fontWeight: FontWeight.w500),
                                        floatingLabelStyle: TextStyle(
                                            color: Color(0xffbcd1ef),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () async {
                      var connected =
                          await InternetConnectionChecker().hasConnection;

                      if (connected == true) {
                        final isFormValid = formKey.currentState!.validate();
                        if (isFormValid) {
                          addPlates();
                        }
                        Navigator.pop(context, '/');
                      }
                    },
                    child: const Text(
                      "Agregar vehículos",
                      style: TextStyle(
                          color: Color(0xff161b33),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DM Sans'),
                      textAlign: TextAlign.center,
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xffbcd1ef),
                      fixedSize: const Size(330, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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
