import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zonaazul/screens/whatsthis/whatsthis.dart';

class SnackBarCode extends StatefulWidget {
  const SnackBarCode({Key? key}) : super(key: key);

  @override
  State<SnackBarCode> createState() => _SnackBarCodeState();
}

class _SnackBarCodeState extends State<SnackBarCode> {
  @override
  Widget build(BuildContext context) {
    return const CardInfo();
  }
}

class CardInfo extends StatefulWidget {
  const CardInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CardInfoState();
}

class CardInfoState extends State<CardInfo> {
  String qrCode = 'Unknown';
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  String redeemedBy = 'None';

  bool connection = false;

  void hasConnection() async {
    var connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      connection = connected;
    });
  }

  final snackBarRedeemed = const SnackBar(
    content: Text(
      'Esta tarjeta ya fue reclamada',
      style: TextStyle(
        fontFamily: 'DM Sans',
        color: Color.fromARGB(255, 255, 158, 158),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: Color.fromARGB(255, 13, 16, 30),
    duration: Duration(seconds: 2),
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
    duration: const Duration(seconds: 1),
    elevation: 10,
  );

  final snackBarWrong = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'El código es incorrecto',
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

  final snackBarAccepted = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '¡Nuevo saldo añadido!',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 158, 255, 168),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.check,
          color: Color.fromARGB(255, 158, 255, 168),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 2),
    elevation: 10,
  );

  @override
  void initState() {
    hasConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff161b33),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/zonaazullogo.svg',
                  width: 150, height: 75),
              const SizedBox(height: 80),
              OutlinedButton(
                  onPressed: () {
                    hasConnection();
                    if (connection == true) {
                      scanQRCode();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xffbcd1ef),
                    fixedSize: const Size(330, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.qr_code_rounded, color: Color(0xff161b33)),
                      SizedBox(width: 20),
                      Text(
                        "ESCANEAR CÓDIGO QR",
                        style: TextStyle(
                            color: Color(0xff161b33),
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(_createRouteToWhatsThis());
                },
                child: const Text(
                  "¿Qué es la Tarjeta Azul?",
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
                    side: const BorderSide(width: 3, color: Color(0xffbcd1ef))),
              ),
              const SizedBox(height: 30),
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
                                width: 3, color: Color(0xffbcd1ef))),
                      ),
                    ),
                    const SizedBox(width: 30),
                    InkWell(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, '/');
                        },
                        child: const Text(
                          "VOLVER",
                          style: TextStyle(
                              color: Color(0xff161b33),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'DM Sans'),
                          textAlign: TextAlign.center,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xffbcd1ef),
                          fixedSize: const Size(220, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '',
        'Volver',
        false,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });

      final refUsers = FirebaseFirestore.instance.collection('users').doc(uid);

      void bigChunk() async {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final snapshot = await transaction
              .get(FirebaseFirestore.instance.collection('codes').doc(qrCode));
          final redeemed = snapshot.get('redeemed');
          if (redeemed == true) {
            //Navigator.pop(context, '/');
            Future.delayed(const Duration(milliseconds: 200), () {
              ScaffoldMessenger.of(context).showSnackBar(snackBarRedeemed);
            });
            print('card has been redeemed');
          } else if (redeemed == false) {
            final refCodes =
                FirebaseFirestore.instance.collection('codes').doc(qrCode);
            var doc = await refCodes.get();
            if (doc.exists) {
              Future.delayed(const Duration(milliseconds: 200), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBarAccepted);
              });
              var amount = int.parse(qrCode.substring(qrCode.length - 3));
              refUsers.update({
                'card': qrCode,
                'cardamt': FieldValue.increment(amount),
              });
              refCodes.update({
                'redeemed': true,
                'redeemedBy': uid,
                'redeemedWhen': Timestamp.now(),
              });
            } else {
              //Navigator.pop(context, '/');
              Future.delayed(const Duration(milliseconds: 200), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBarWrong);
              });
              print('unfortunately, doc does not exist');
            }
          }
        });
      }

      if (!qrCode.contains('/')) {
        if (qrCode.length == 25) {
          print('actually 25');
          bigChunk();
        } else if (qrCode.length != 25) {
          //Navigator.pop(context, '/');
          Future.delayed(const Duration(milliseconds: 200), () {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWrong);
          });
          print('not 25 sadly');
          print(qrCode);
        }
      } else {
        Future.delayed(const Duration(milliseconds: 200), () {
          ScaffoldMessenger.of(context).showSnackBar(snackBarWrong);
        });
        print('/ spotted');
      }
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
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
