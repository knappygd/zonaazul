import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zonaazul/screens/account/options/modify.dart';
import 'package:zonaazul/screens/settings/usersettings.dart';

class WhatsThis extends StatefulWidget {
  const WhatsThis({Key? key}) : super(key: key);

  @override
  State<WhatsThis> createState() => _WhatsThisState();
}

class _WhatsThisState extends State<WhatsThis> {
  bool one = true;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff161b33),
        elevation: 10,
        title: Row(
          children: [
            Text(
              "¿Qué es la app Zona Azul?",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xffbcd1ef).withAlpha(100),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff161b33),
        child: RawScrollbar(
          thumbColor: const Color(0xffbcd1ef).withAlpha(70),
          radius: const Radius.circular(2),
          thickness: 2,
          child: ListView(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        one = !one;
                      });
                    },
                    child: SizedBox(
                      height: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              'Zona Azul es una app creada\npara que estacionar en el centro\nde Paysandú te tome dos segundos.',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: one,
                    child: SizedBox(
                      height: 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ',En la pantalla principal\n.elegí el tiempo que quieras estacionar\nEl dinero por el tiempo que\nseleccionaste se debitará\n.de tu Tarjeta Azul',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: const Color(0xffbcd1ef).withOpacity(0.8),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        two = !two;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              '¿Qué es la Tarjeta Azul?',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: two,
                    child: SizedBox(
                      height: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Es una tarjeta que se puede comprar\ntanto en comercios de la zona\n.como a los Fiscalizadores',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: const Color(0xffbcd1ef).withOpacity(0.8),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: two,
                    child: SizedBox(
                      height: 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Es muy simple de usar; solo tenés que\nescanear el código QR de\n.la tarjeta, y listo\nEl saldo se cargó a tu cuenta\npara que puedas usarlo\n.en estacionamiento',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: const Color(0xffbcd1ef).withOpacity(0.8),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        three = !three;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              '¿Cuáles son los horarios y tarifas?',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: three,
                    child: SizedBox(
                      height: 250,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'La zona azul esta disponible\n.desde las 8:00 hasta las 18:00\nEl precio por 1 hora es de \$45\n.y de \$30 por 30 minutos\nLos sábados, domingos y feriados\n.es gratis\n\nPodés identificar donde existe zona azul\nen donde el cordón de la vereda\n.esté pintado de azul',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: const Color(0xffbcd1ef).withOpacity(0.8),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        four = !four;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              '¿Puedo cambiar los datos de mi cuenta?',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: four,
                    child: SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(_createRouteToModify());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Si, podés ir a Cuenta > Modificar datos\n.o hacer clic en esta caja de texto',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.8),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        five = !five;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              'Hasta 5 vehículos en una cuenta',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: five,
                    child: SizedBox(
                      height: 250,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(_createRouteToSettings());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ',En Modificar datos > Otros vehículos\ndentro de Cuenta, es posible vincular\n.hasta 5 matrículas a un solo usuario\n,Al tocar en una de las matrículas\nse determina que es\nla que se va a usar para\n,estacionar; en otras palabras\n.la matrícula por defecto\nSe identifica con la letra D\n.a la izquierda de la matrícula',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.8),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        six = !six;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: const [
                            SizedBox(width: 15),
                            Text(
                              '¿Qué se puede personalizar?',
                              style: TextStyle(
                                color: Color(0xffbcd1ef),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Visibility(
                    visible: six,
                    child: SizedBox(
                      height: 170,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(_createRouteToSettings());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'En Ajustes podés modificar\n,el formato de la hora (12h/24h)\nactivar o desactivar el historial y\n.activar o desactivar las notificaciones\nPodés acceder a los Ajustes\n.haciendo clic en esta caja de texto',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color:
                                      const Color(0xffbcd1ef).withOpacity(0.8),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Tocá cualquier pregunta\npara desplegar más información',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffbcd1ef).withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
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
