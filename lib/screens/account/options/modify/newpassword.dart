import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
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
                      color: const Color(0xffbcd1ef).withAlpha(100)),
                ),
                Text(
                  "Modificar datos > ",
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffbcd1ef).withAlpha(100)),
                ),
                Text(
                  "Contraseña",
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffbcd1ef).withAlpha(150)),
                ),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xff161b33),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                SizedBox(
                  width: 330,
                  height: 55,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          obscureText: _isObscure,
                          textInputAction: TextInputAction.next,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color(0xffbcd1ef), width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color(0xffbcd1ef), width: 2)),
                            labelText: 'Nueva contraseña',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(100, 188, 209, 239),
                                fontWeight: FontWeight.w500),
                            floatingLabelStyle: const TextStyle(
                                color: Color(0xffbcd1ef),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 330,
                  height: 55,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color(0xffbcd1ef), width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color(0xffbcd1ef), width: 2)),
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
                    ],
                  ),
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
    );
  }
}
