import 'package:flutter/material.dart';
import 'package:zonaazul/screens/bluecard/cardinfo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoBalance extends StatelessWidget {
  const NoBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff6984a3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/zonaazullogo.svg',
                  width: 150, height: 75),
              const SizedBox(height: 40),
              // Row 1hr
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 330,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(128, 75, 98, 133),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          // Container Time
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(128, 44, 63, 102),
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
                                            color: Color.fromARGB(
                                                128, 188, 209, 239),
                                            fontFamily: 'DM Sans',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      'hora',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              128, 188, 209, 239),
                                          fontFamily: 'DM Sans',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Container Price
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(128, 44, 63, 102),
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
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  Text(
                                    '30',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ]),
                          ),

                          const SizedBox(width: 10),
                          // Container Text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 110,
                                height: 35,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Estacionamiento hasta',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              // Container TextTime
                              SizedBox(
                                width: 110,
                                height: 30,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '17:07:21',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              ),
              const SizedBox(height: 30),
              // Row 30min
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 330,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(128, 75, 98, 133),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          // Container Time
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(128, 44, 63, 102),
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
                                            color: Color.fromARGB(
                                                128, 188, 209, 239),
                                            fontFamily: 'DM Sans',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      'min',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              128, 188, 209, 239),
                                          fontFamily: 'DM Sans',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Container Price
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(128, 44, 63, 102),
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
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ]),
                          ),
                          const SizedBox(width: 10),
                          // Container Text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 110,
                                height: 35,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Estacionamiento hasta',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              // Container TextTime
                              SizedBox(
                                width: 110,
                                height: 30,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '16:37:21',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(128, 188, 209, 239),
                                        fontFamily: 'DM Sans',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              ),
              const SizedBox(height: 30),
              // Box
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 330,
                    decoration: BoxDecoration(
                        color: const Color(0xff4b6285),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Te quedaste sin saldo en tu Tarjeta Azul',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xffbcd1ef)),
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, '/');
                              },
                              child: Container(
                                width: 115,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xff2c3f66),
                                    width: 3,
                                  ),
                                  color: const Color(0xff4b6285),
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          "VOLVER",
                                          style: TextStyle(
                                              color: Color(0xffbcd1ef),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'DM Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(_createRouteToCardInfo());
                              },
                              child: Container(
                                width: 170,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xff00091f),
                                    width: 3,
                                  ),
                                  color: const Color(0xff001138),
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "RECARGAR",
                                          style: TextStyle(
                                              color: Color(0xffbcd1ef),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'DM Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        )
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
