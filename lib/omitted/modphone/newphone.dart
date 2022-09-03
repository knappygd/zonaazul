// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class NewPhone extends StatefulWidget {
//   const NewPhone({Key? key}) : super(key: key);

//   @override
//   _NewPhoneState createState() => _NewPhoneState();
// }

// class _NewPhoneState extends State<NewPhone> {
//   bool _isObscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: const Color(0xff6984a3),
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     width: 330,
//                     height: 55,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: const [
//                         Expanded(
//                             child: TextField(
//                           keyboardType: TextInputType.phone,
//                           textInputAction: TextInputAction.next,
//                           textCapitalization: TextCapitalization.words,
//                           style: TextStyle(
//                               fontFamily: 'DM Sans',
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xff4b6285)),
//                           autofocus: true,
//                           cursorHeight: 25.0,
//                           cursorColor: Color(0xff001138),
//                           decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(0, 0, 0, 0), width: 0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20)),
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(0, 0, 0, 0),
//                                     width: 0)),
//                             hintText: 'Nuevo teléfono',
//                             hintStyle: TextStyle(
//                                 color: Color(0x4c000000),
//                                 fontFamily: 'DM Sans',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700),
//                             filled: true,
//                             fillColor: Color(0xffbcd1ef),
//                           ),
//                         )),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // TextField: Password
//                   SizedBox(
//                     width: 330,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 330,
//                           height: 55,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   style: const TextStyle(
//                                     color: Color(0xff4b6285),
//                                     fontFamily: 'DM Sans',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   obscureText: _isObscure,
//                                   cursorColor: const Color(0xff001138),
//                                   cursorHeight: 25.0,
//                                   decoration: InputDecoration(
//                                     suffixIcon: IconButton(
//                                       color: const Color(0x4c000000),
//                                       padding:
//                                           const EdgeInsets.only(right: 20.0),
//                                       icon: Icon(_isObscure
//                                           ? Icons.visibility
//                                           : Icons.visibility_off),
//                                       onPressed: () {
//                                         setState(() {
//                                           _isObscure = !_isObscure;
//                                         });
//                                       },
//                                     ),
//                                     hintText: "Contraseña",
//                                     enabledBorder: const OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(20)),
//                                       borderSide: BorderSide(
//                                           color: Color.fromARGB(0, 0, 0, 0),
//                                           width: 0),
//                                     ),
//                                     focusedBorder: const OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20)),
//                                         borderSide: BorderSide(
//                                             color: Color.fromARGB(0, 0, 0, 0),
//                                             width: 0)),
//                                     hintStyle: const TextStyle(
//                                       color: Color(0x4c000000),
//                                       fontSize: 20,
//                                       fontFamily: "DM Sans",
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                     filled: true,
//                                     fillColor: const Color(0xffbcd1ef),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   SizedBox(
//                     width: 330,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context, '/');
//                           },
//                           child: Container(
//                             width: 80,
//                             height: 60,
//                             child: const SizedBox(
//                               child: Icon(
//                                 FontAwesomeIcons.arrowCircleLeft,
//                                 size: 40,
//                                 color: Color(0xff2c3f66),
//                               ),
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: const Color(0xff2c3f66),
//                                 width: 3,
//                               ),
//                               color: const Color(0xff4b6285),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 30),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context, '/');
//                           },
//                           child: Container(
//                             width: 220,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: const Color(0xff00091f),
//                                 width: 3,
//                               ),
//                               color: const Color(0xff001138),
//                             ),
//                             padding: const EdgeInsets.all(0.0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: const [
//                                 Text(
//                                   "¡LISTO!",
//                                   style: TextStyle(
//                                     color: Color(0xffbcd1ef),
//                                     fontSize: 20,
//                                     fontFamily: "DM Sans",
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
