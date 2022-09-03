import 'package:flutter/material.dart';
import 'package:zonaazul/screens/whatsthis/whatsthis.dart';
import 'reg/reg.dart';
import 'login/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginReg extends StatelessWidget {
  const LoginReg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff161b33),
      statusBarColor: Color(0xff161b33),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff161b33),
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/zonaazullogo.svg',
                  width: 150, height: 75),
              Column(
                children: [
                  InkWell(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToLogin());
                      },
                      child: const Text(
                        "INGRESAR",
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
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToReg());
                      },
                      child: const Text(
                        "REGISTRARSE",
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
                              width: 3, color: Color(0xffbcd1ef))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRouteToWhatsThis());
                      },
                      child: const Text(
                        "¿QUÉ ES ESTO?",
                        style: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans'),
                        textAlign: TextAlign.center,
                      ),
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                              width: 3, color: Color(0xffbcd1ef))),
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

// Navigation animation
Route _createRouteToReg() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const Reg(),
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

Route _createRouteToLogin() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const Login(),
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
