import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;
  String emailHelperText = ' ';
  String passwordHelperText = ' ';
  final formKey = GlobalKey<FormState>();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xff161b33),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  SizedBox(
                    height: 75,
                    width: 330,
                    child: TextFormField(
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'El email no es correcto'
                              : null,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
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
                      decoration: InputDecoration(
                        helperText: emailHelperText,
                        helperStyle: const TextStyle(
                            color: Color(0xffbcd1ef),
                            fontWeight: FontWeight.w400),
                        errorStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 158, 158),
                            fontWeight: FontWeight.w400),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 158, 158),
                            width: 2,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 158, 158),
                            width: 2,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Color(0xffbcd1ef), width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Color(0xffbcd1ef), width: 2)),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(100, 188, 209, 239),
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
                    height: 75,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.length < 8) {
                          return 'La contraseña debe contener mas de 7 caracteres';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
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
                        helperText: passwordHelperText,
                        helperStyle: const TextStyle(
                            color: Color(0xffbcd1ef),
                            fontWeight: FontWeight.w400),
                        errorStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 158, 158),
                            fontWeight: FontWeight.w400),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 158, 158),
                            width: 2,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 158, 158),
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          color: const Color.fromARGB(100, 188, 209, 239),
                          padding: const EdgeInsets.only(right: 20.0),
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Color(0xffbcd1ef), width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Color(0xffbcd1ef), width: 2)),
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(100, 188, 209, 239),
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
                            onPressed: () async {
                              final String email = emailController.text.trim();
                              final String password =
                                  passwordController.text.trim();
                              final isFormValid =
                                  formKey.currentState!.validate();

                              if (isFormValid) {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  Navigator.of(context)
                                      .pushReplacementNamed('/request/request');
                                  Navigator.pop(context, '/login/login');
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    setState(() {
                                      emailHelperText =
                                          'No existe un usuario con ese email';
                                    });
                                  } else if (e.code == 'wrong-password') {
                                    setState(() {
                                      passwordHelperText =
                                          'La contraseña no es correcta';
                                    });
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
