import 'package:flutter/material.dart';
import 'package:zonaazul/screens/account/options/modify/multipleplates.dart';
import 'package:zonaazul/screens/account/options/modify/newemail.dart';
import 'package:zonaazul/screens/account/options/modify/newplate.dart';
// Screen imports
import 'package:zonaazul/screens/account/options/modify/newname.dart';

class Modify extends StatelessWidget {
  const Modify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Cuenta > ",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xffbcd1ef).withAlpha(100),
              ),
            ),
            Text(
              "Modificar datos",
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 330,
              decoration: BoxDecoration(
                color: const Color(0xffbcd1ef),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Elegí lo que quieras cambiar',
                  style: TextStyle(
                    color: Color(0xff161b33),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DM Sans',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 330,
              child: Row(
                children: [
                  InkWell(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToNewName());
                      },
                      child: const Text(
                        "Nombre",
                        style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans'),
                        textAlign: TextAlign.center,
                      ),
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(150, 60),
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
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToNewEmail());
                      },
                      child: const Text(
                        "Email",
                        style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans'),
                        textAlign: TextAlign.center,
                      ),
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(150, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                              width: 3, color: Color(0xffbcd1ef))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 330,
              child: Row(children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(_createRouteToMultiplePlates());
                  },
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Agregar más vehículos",
                          style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]),
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
              ]),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 330,
              child: Row(
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
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToNewPlate());
                      },
                      child: const Text(
                        "Matrícula",
                        style: TextStyle(
                          color: Color(0xffbcd1ef),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DM Sans',
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRouteToNewName() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const NewName(),
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

Route _createRouteToNewPlate() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const NewPlate(),
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

Route _createRouteToNewEmail() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const NewEmail(),
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
