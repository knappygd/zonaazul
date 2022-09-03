import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zonaazul/firebase/auth.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class Reg extends StatefulWidget {
  const Reg({Key? key}) : super(key: key);
  @override
  _RegState createState() => _RegState();
}

class DisableOverscrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _RegState extends State<Reg> {
  bool _isObscure = true;
  PageController pageController = PageController(initialPage: 0);
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController plateController = TextEditingController();

  void validate() {
    final String email = emailController.text.trim();
    final String password = passwordContoller.text.trim();
    final String name = nameController.text.trim();
    final String plate = plateController.text.trim();
    const String card = "Unknown";

    if (email.isEmpty) {
      print("Email is Empty");
    } else {
      if (password.isEmpty) {
        print("Password is Empty");
      } else {
        context
            .read<Auth>()
            .signUp(email, password, name, plate, card)
            .then((value) async {
          User? user = FirebaseAuth.instance.currentUser;

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .set({
            'name': name,
            'email': email,
            'plate': plate,
            'card': 'None',
            'cardamt': 0,
            'hasNotificationsEnabled': true,
            'uses24HourFormat': true,
            'hasHistoryEnabled': true,
            'isInspector': false,
            'isCurrentlyParked': false,
            'plate02': 'None',
            'plate03': 'None',
            'plate04': 'None',
            'plate05': 'None',
            'defPlate': plate,
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //final dbref = refDatabase.ref();
    return MaterialApp(
      // Disable glow overscroll
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: DisableOverscrollGlow(), child: child!);
      },
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xff161b33),
          body: Column(
            children: [
              Expanded(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      // Reg00
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          // TextField: Name
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 75,
                                width: 330,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null && value.length < 3) {
                                      return 'Ingresá tu nombre y apellido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffbcd1ef),
                                  ),
                                  autofocus: true,
                                  cursorHeight: 25.0,
                                  cursorColor: const Color(0xffbcd1ef),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    helperText: ' ',
                                    errorStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        fontWeight: FontWeight.w400),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color: Color(0xffbcd1ef),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef),
                                            width: 2)),
                                    labelText: 'Nombre y apellido',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(100, 188, 209, 239),
                                        fontWeight: FontWeight.w500),
                                    floatingLabelStyle: TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 330,
                                height: 75,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null && value.length < 8) {
                                      return 'La contraseña debe contener mas de 7 caracteres';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordContoller,
                                  obscureText: _isObscure,
                                  textInputAction: TextInputAction.done,
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffbcd1ef)),
                                  cursorHeight: 25.0,
                                  cursorColor: const Color(0xffbcd1ef),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    helperText: ' ',
                                    errorStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        fontWeight: FontWeight.w400),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      color: const Color.fromARGB(
                                          100, 188, 209, 239),
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xffbcd1ef), width: 2),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef),
                                            width: 2)),
                                    labelText: 'Contraseña',
                                    labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(100, 188, 209, 239),
                                        fontWeight: FontWeight.w500),
                                    floatingLabelStyle: const TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 330,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context, '/');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                          pageController.animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut);
                                        },
                                        child: const Text(
                                          "PASO 2",
                                          style: TextStyle(
                                              color: Color(0xff161b33),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'DM Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffbcd1ef),
                                          fixedSize: const Size(220, 60),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // Reg01
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          // TextField: Name
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 330,
                                height: 75,
                                child: TextFormField(
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'El email no es correcto'
                                      : null,
                                  controller: emailController,
                                  textInputAction: TextInputAction.done,
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffbcd1ef)),
                                  autofocus: true,
                                  cursorHeight: 25.0,
                                  cursorColor: const Color(0xffbcd1ef),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    helperText: ' ',
                                    errorStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        fontWeight: FontWeight.w400),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xffbcd1ef), width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xffbcd1ef),
                                            width: 2)),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(100, 188, 209, 239),
                                        fontWeight: FontWeight.w500),
                                    floatingLabelStyle: TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 330,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          pageController.animateToPage(0,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                          pageController.animateToPage(2,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut);
                                        },
                                        child: const Text(
                                          "PASO 3",
                                          style: TextStyle(
                                              color: Color(0xff161b33),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'DM Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffbcd1ef),
                                          fixedSize: const Size(220, 60),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // Reg03
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          // TextField: Name
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 330,
                                decoration: BoxDecoration(
                                    color:
                                        const Color(0xffbcd1ef).withAlpha(70),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "ABC1234 - AB123CD",
                                      style: TextStyle(
                                          fontFamily: 'FE-Font',
                                          color: Color(0xff161b33),
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 7)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 330,
                                height: 75,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value != null && value.length < 6) {
                                      return 'Te faltan caracteres';
                                    } else if (value != null &&
                                        value.length > 7) {
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
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffbcd1ef)),
                                  autofocus: true,
                                  cursorHeight: 25.0,
                                  cursorColor: const Color(0xffbcd1ef),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    helperText: ' ',
                                    errorStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        fontWeight: FontWeight.w400),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 158, 158),
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xffbcd1ef), width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xffbcd1ef), width: 2),
                                    ),
                                    labelText: 'Matrícula',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(100, 188, 209, 239),
                                        fontWeight: FontWeight.w500),
                                    floatingLabelStyle: TextStyle(
                                        color: Color(0xffbcd1ef),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 330,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          pageController.animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                          final isFormValid =
                                              formKey.currentState!.validate();

                                          if (isFormValid) {
                                            final String email =
                                                emailController.text.trim();
                                            final String password =
                                                passwordContoller.text.trim();
                                            final String name =
                                                nameController.text.trim();
                                            final String plate =
                                                plateController.text.trim();
                                            const String card = "Unknown";

                                            if (email.isEmpty) {
                                              print("Email is Empty");
                                            } else {
                                              if (password.isEmpty) {
                                                print("Password is Empty");
                                              } else {
                                                context
                                                    .read<Auth>()
                                                    .signUp(email, password,
                                                        name, plate, card)
                                                    .then((value) async {
                                                  User? user = FirebaseAuth
                                                      .instance.currentUser;

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(user?.uid)
                                                      .set({
                                                    'name': name,
                                                    'email': email,
                                                    'plate': plate,
                                                    'card': 'None',
                                                    'cardamt': 0,
                                                    'hasNotificationsEnabled':
                                                        true,
                                                    'uses24HourFormat': true,
                                                    'hasHistoryEnabled': true,
                                                    'isInspector': false,
                                                    'isCurrentlyParked': false,
                                                    'plate02': 'None',
                                                    'plate03': 'None',
                                                    'plate04': 'None',
                                                    'plate05': 'None',
                                                    'defPlate': plate,
                                                  });
                                                });
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/request/request');
                                                Navigator.pop(
                                                    context, '/reg/reg');
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                          "¡LISTO!",
                                          style: TextStyle(
                                              color: Color(0xff161b33),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'DM Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffbcd1ef),
                                          fixedSize: const Size(220, 60),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: const Color(0xffbcd1ef),
                    dotColor: const Color(0xffbcd1ef).withAlpha(30)),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
