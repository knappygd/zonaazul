import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Watchguys extends StatefulWidget {
  const Watchguys({Key? key}) : super(key: key);

  @override
  State<Watchguys> createState() => _WatchguysState();
}

class _WatchguysState extends State<Watchguys> {
  static TextEditingController plateController = TextEditingController();
  bool isCarParked = false;
  String userDoc = 'r';
  bool connection = false;

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      connection = connected;
    });
  }

  theVeryFunc() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('defPlate', isEqualTo: plateController.text.trim())
        .get()
        .then((value) async {
      for (var doc in value.docs) {
        setState(() {
          userDoc = doc.id;
        });
      }
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction
            .get(FirebaseFirestore.instance.collection('users').doc(userDoc));
        final parkedCar = snapshot.get("isCurrentlyParked");
        if (parkedCar == true) {
          setState(() {
            isCarParked = true;
          });
        } else {
          setState(() {
            isCarParked = false;
          });
        }
      });
      //getParkedCar();
    });
    setState(() {});
  }

  @override
  void initState() {
    hasConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xff161b33),
          elevation: 0,
          title: Text(
            'Buscar un vehículo',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xffbcd1ef).withAlpha(100),
            ),
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
              const SizedBox(height: 50),
              SizedBox(
                width: 330,
                child: TextFormField(
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return 'Te faltan caracteres';
                    } else if (value != null && value.length > 7) {
                      return 'Tenés alguna letra o número extra';
                    } else if (value != null &&
                        value.length == 6 &&
                        !value.startsWith('H')) {
                      return 'Te faltan caracteres';
                    } else {
                      return null;
                    }
                  },
                  controller: plateController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffbcd1ef),
                  ),
                  autofocus: false,
                  cursorHeight: 25.0,
                  cursorColor: const Color(0xffbcd1ef),
                  decoration: const InputDecoration(
                    isDense: true,
                    helperText: ' ',
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 158, 158),
                        fontWeight: FontWeight.w400),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 158, 158),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 158, 158),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color(0xffbcd1ef), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color(0xffbcd1ef), width: 2),
                    ),
                    labelText: 'Matrícula',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(100, 188, 209, 239),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  hasConnection();
                  Future.delayed(const Duration(seconds: 1), () {
                    if (connection == false) {
                      print('yes con :)');
                    } else if (connection == true) {
                      theVeryFunc();
                      print('no con :(');
                    }
                  });
                },
                child: const Text(
                  "BUSCAR",
                  style: TextStyle(
                      color: Color(0xff161b33),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DM Sans'),
                  textAlign: TextAlign.center,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xffbcd1ef),
                  fixedSize: const Size(330, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Stack(
                children: [
                  Visibility(
                    visible: !connection,
                    child: Column(
                      children: const [
                        Text(
                          'No hay conexión',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffbcd1ef),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Icon(
                          Icons.wifi_off_rounded,
                          color: Color(0xffbcd1ef),
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isCarParked && connection,
                    child: Column(
                      children: const [
                        Text(
                          'El vehículo está dentro del\ntiempo permitido',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffbcd1ef),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Icon(
                          Icons.done_outline_rounded,
                          color: Color(0xffbcd1ef),
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isCarParked && connection,
                    child: Column(
                      children: const [
                        Text(
                          'No hay vehículos estacionados\ncon esta matrícula',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffbcd1ef),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Icon(
                          Icons.dangerous,
                          color: Color(0xffbcd1ef),
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Column(
                      children: const [
                        Text(
                          'Ingresa una matrícula\nen el buscador de arriba',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffbcd1ef),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
