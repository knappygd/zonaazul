// import 'package:flutter/material.dart';
// import 'package:zonaazul/screens/bluecard/cardinfo.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CardSetup extends StatelessWidget {
//   const CardSetup({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: const Color(0xff6984a3),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SvgPicture.asset('assets/images/zonaazullogo.svg',
//                   width: 150, height: 75),
//               Column(
//                 children: [
//                   Container(
//                     height: 150,
//                     width: 330,
//                     decoration: BoxDecoration(
//                         color: const Color(0xff4b6285),
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         const Text(
//                           '¿Configurar Tarjeta Azul ahora?',
//                           style: TextStyle(
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               color: Color(0xffbcd1ef)),
//                         ),
//                         const SizedBox(height: 30),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context, '/');
//                               },
//                               child: Container(
//                                 width: 115,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: const Color(0xff2c3f66),
//                                     width: 3,
//                                   ),
//                                   color: const Color(0xff4b6285),
//                                 ),
//                                 child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: const [
//                                       SizedBox(
//                                         width: 90,
//                                         child: Text(
//                                           "MAS TARDE",
//                                           style: TextStyle(
//                                               color: Color(0xffbcd1ef),
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w700,
//                                               fontFamily: 'DM Sans'),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     ]),
//                               ),
//                             ),
//                             const SizedBox(width: 15),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context)
//                                     .push(_createRouteToCardInfo());
//                               },
//                               child: Container(
//                                 width: 170,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: const Color(0xff00091f),
//                                     width: 3,
//                                   ),
//                                   color: const Color(0xff001138),
//                                 ),
//                                 child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: const [
//                                       SizedBox(
//                                         width: 130,
//                                         child: Text(
//                                           "CONFIGURAR",
//                                           style: TextStyle(
//                                               color: Color(0xffbcd1ef),
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w700,
//                                               fontFamily: 'DM Sans'),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     ]),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   GestureDetector(
//                     onTap: () {
//                       // ...
//                     },
//                     child: Container(
//                       width: 330,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: const Color(0xff001138),
//                           width: 3,
//                         ),
//                         color: const Color(0xff2c3f66),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           SizedBox(
//                             width: 300,
//                             height: 60,
//                             child: Center(
//                               child: Text(
//                                 "¿Qué es la Tarjeta Azul?",
//                                 style: TextStyle(
//                                     color: Color(0xffbcd1ef),
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     fontFamily: 'DM Sans'),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Route _createRouteToCardInfo() {
//   return PageRouteBuilder(
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, animation, secondaryAnimation) => const CardInfo(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
