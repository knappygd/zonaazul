import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewName extends StatefulWidget {
  const NewName({Key? key}) : super(key: key);

  @override
  _NewNameState createState() => _NewNameState();
}

class _NewNameState extends State<NewName> {
  TextEditingController newNameController = TextEditingController();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                  "Nombre",
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
          body: const ShowSnackBar()),
    );
  }
}

class ShowSnackBar extends StatefulWidget {
  const ShowSnackBar({Key? key}) : super(key: key);

  @override
  ShowSnackBarState createState() => ShowSnackBarState();
}

class ShowSnackBarState extends State<ShowSnackBar>
    with TickerProviderStateMixin {
  TextEditingController newNameController = TextEditingController();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Nombre cambiado',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Color.fromARGB(255, 158, 255, 168),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.check_circle_rounded,
          color: Color.fromARGB(255, 158, 255, 168),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 13, 16, 30),
    duration: const Duration(seconds: 1),
    elevation: 10,
  );

  AnimationController? _controller;
  Animation? _animation;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 230.0, end: 140.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff161b33),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: _animation?.value),
          Container(
            height: 40,
            width: 330,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 16, 30),
                borderRadius: BorderRadius.circular(15)),
            child: FutureBuilder(
                future: users.doc(uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator(
                      strokeWidth: 2,
                      color: const Color(0xffbcd1ef).withAlpha(100),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        const SizedBox(height: 7),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              data['name'],
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: const Color(0xffbcd1ef).withAlpha(70),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            'Nombre actual',
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: const Color(0xffbcd1ef).withAlpha(20),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 330,
            height: 55,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: TextField(
                      focusNode: _focusNode,
                      controller: newNameController,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffbcd1ef)),
                      autofocus: false,
                      cursorHeight: 25.0,
                      cursorColor: const Color(0xffbcd1ef),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Color(0xffbcd1ef), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Color(0xffbcd1ef), width: 2)),
                        labelText: 'Nuevo nombre',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(100, 188, 209, 239),
                            fontWeight: FontWeight.w500),
                        floatingLabelStyle: TextStyle(
                            color: Color(0xffbcd1ef),
                            fontWeight: FontWeight.w500),
                      ),
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
                    onPressed: () async {
                      final String newName = newNameController.text.trim();
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({'name': newName});
                      Future.delayed(const Duration(milliseconds: 200), () {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
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
    );
  }
}
