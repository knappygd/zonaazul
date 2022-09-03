// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class AnotherPlate extends StatefulWidget {
//   const AnotherPlate({Key? key}) : super(key: key);

//   @override
//   _AnotherPlateState createState() => _AnotherPlateState();
// }

// class DisableOverscrollGlow extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//       BuildContext context, Widget child, ScrollableDetails details) {
//     return child;
//   }
// }

// class _AnotherPlateState extends State<AnotherPlate> {
//   PageController pageController = PageController(initialPage: 0);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Disable glow overscroll
//       builder: (context, child) {
//         return ScrollConfiguration(
//             behavior: DisableOverscrollGlow(), child: child!);
//       },
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           backgroundColor: const Color(0xff6984a3),
//           body: Column(
//             children: [
//               Expanded(
//                 child: PageView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   controller: pageController,
//                   children: [
//                     // About
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 100,
//                           width: 330,
//                           decoration: BoxDecoration(
//                               color: const Color(0xff4b6285),
//                               borderRadius: BorderRadius.circular(15)),
//                           child: const Padding(
//                             padding: EdgeInsets.fromLTRB(13, 10, 30, 10),
//                             child: SizedBox(
//                               height: 300,
//                               width: 300,
//                               child: Text(
//                                 'Al agregar matrículas,\ntenés la opción de elegir cual querés\nusar al momento de reservar.\nPodés agregar hasta 5 matrículas.',
//                                 style: TextStyle(
//                                   color: Color(0xffbcd1ef),
//                                   fontSize: 17,
//                                   fontFamily: "DM Sans",
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(
//                                 width: 180,
//                                 height: 60,
//                                 child: Text(
//                                   'Si lo que estás buscando\nes cambiar la matrícula\nya asociada',
//                                   textDirection: TextDirection.rtl,
//                                   style: TextStyle(
//                                     color: Color(0xff2c3f66),
//                                     fontSize: 15,
//                                     fontFamily: "DM Sans",
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // Navigator.of(context).push(_createRouteToReg());
//                                 },
//                                 // Button
//                                 child: Container(
//                                   width: 130,
//                                   height: 53,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: const Color(0xff001138),
//                                       width: 3,
//                                     ),
//                                     color: const Color(0xff2c3f66),
//                                   ),
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: const [
//                                       Center(
//                                         child: Text(
//                                           "Vení acá",
//                                           style: TextStyle(
//                                               color: Color(0xffbcd1ef),
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w700,
//                                               fontFamily: 'DM Sans'),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context, '/');
//                                 },
//                                 child: Container(
//                                   width: 80,
//                                   height: 60,
//                                   child: const SizedBox(
//                                     child: Icon(
//                                       FontAwesomeIcons.arrowCircleLeft,
//                                       size: 40,
//                                       color: Color(0xff2c3f66),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: const Color(0xff2c3f66),
//                                       width: 3,
//                                     ),
//                                     color: const Color(0xff4b6285),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   pageController.animateToPage(1,
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       curve: Curves.easeOut);
//                                 },
//                                 child: Container(
//                                   width: 220,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: const Color(0xff00091f),
//                                       width: 3,
//                                     ),
//                                     color: const Color(0xff001138),
//                                   ),
//                                   padding: const EdgeInsets.all(0.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: const [
//                                       Text(
//                                         "AGREGAR",
//                                         style: TextStyle(
//                                           color: Color(0xffbcd1ef),
//                                           fontSize: 20,
//                                           fontFamily: "DM Sans",
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Add new plate
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 30,
//                                 child: Text('1',
//                                     style: TextStyle(
//                                         color: Color(0xff2c3f66),
//                                         fontFamily: 'DM Sans',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700)),
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 height: 45,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: 45,
//                                       width: 200,
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(10.0),
//                                         child: Text(
//                                           'DEF5678',
//                                           style: TextStyle(
//                                               fontFamily: 'DM Sans',
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w700,
//                                               color: Color(0xff4b6285)),
//                                         ),
//                                       ),
//                                       decoration: const BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15)),
//                                         color:
//                                             Color.fromARGB(100, 188, 209, 239),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 100,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     'ABC1234',
//                                     style: TextStyle(
//                                         fontFamily: 'FE-Font',
//                                         fontSize: 17,
//                                         color: Color(0xff4b6285)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 30,
//                                 child: Text('2',
//                                     style: TextStyle(
//                                         color: Color(0xff2c3f66),
//                                         fontFamily: 'DM Sans',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700)),
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 height: 45,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: const [
//                                     Expanded(
//                                         child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       style: TextStyle(
//                                           fontFamily: 'DM Sans',
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xff4b6285)),
//                                       autofocus: true,
//                                       cursorHeight: 25.0,
//                                       cursorColor: Color(0xff001138),
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               color: Color.fromARGB(0, 0, 0, 0),
//                                               width: 0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(15)),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Color.fromARGB(0, 0, 0, 0),
//                                                 width: 0)),
//                                         hintText: 'Matrícula',
//                                         hintStyle: TextStyle(
//                                             color: Color(0x4c000000),
//                                             fontFamily: 'DM Sans',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700),
//                                         filled: true,
//                                         fillColor: Color(0xffbcd1ef),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 100,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     'ABC1234',
//                                     style: TextStyle(
//                                         fontFamily: 'FE-Font',
//                                         fontSize: 17,
//                                         color: Color(0xff4b6285)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 30,
//                                 child: Text('3',
//                                     style: TextStyle(
//                                         color: Color(0xff2c3f66),
//                                         fontFamily: 'DM Sans',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700)),
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 height: 45,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: const [
//                                     Expanded(
//                                         child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       style: TextStyle(
//                                           fontFamily: 'DM Sans',
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xff4b6285)),
//                                       autofocus: true,
//                                       cursorHeight: 25.0,
//                                       cursorColor: Color(0xff001138),
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               color: Color.fromARGB(0, 0, 0, 0),
//                                               width: 0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(15)),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Color.fromARGB(0, 0, 0, 0),
//                                                 width: 0)),
//                                         hintText: 'Matrícula',
//                                         hintStyle: TextStyle(
//                                             color: Color(0x4c000000),
//                                             fontFamily: 'DM Sans',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700),
//                                         filled: true,
//                                         fillColor: Color(0xffbcd1ef),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 100,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     'ABC1234',
//                                     style: TextStyle(
//                                         fontFamily: 'FE-Font',
//                                         fontSize: 17,
//                                         color: Color(0xff4b6285)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 30,
//                                 child: Text('4',
//                                     style: TextStyle(
//                                         color: Color(0xff2c3f66),
//                                         fontFamily: 'DM Sans',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700)),
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 height: 45,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: const [
//                                     Expanded(
//                                         child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       style: TextStyle(
//                                           fontFamily: 'DM Sans',
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xff4b6285)),
//                                       autofocus: true,
//                                       cursorHeight: 25.0,
//                                       cursorColor: Color(0xff001138),
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               color: Color.fromARGB(0, 0, 0, 0),
//                                               width: 0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(15)),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Color.fromARGB(0, 0, 0, 0),
//                                                 width: 0)),
//                                         hintText: 'Matrícula',
//                                         hintStyle: TextStyle(
//                                             color: Color(0x4c000000),
//                                             fontFamily: 'DM Sans',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700),
//                                         filled: true,
//                                         fillColor: Color(0xffbcd1ef),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 100,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     'ABC1234',
//                                     style: TextStyle(
//                                         fontFamily: 'FE-Font',
//                                         fontSize: 17,
//                                         color: Color(0xff4b6285)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 30,
//                                 child: Text('5',
//                                     style: TextStyle(
//                                         color: Color(0xff2c3f66),
//                                         fontFamily: 'DM Sans',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w700)),
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 height: 45,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: const [
//                                     Expanded(
//                                         child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       style: TextStyle(
//                                           fontFamily: 'DM Sans',
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xff4b6285)),
//                                       autofocus: true,
//                                       cursorHeight: 25.0,
//                                       cursorColor: Color(0xff001138),
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               color: Color.fromARGB(0, 0, 0, 0),
//                                               width: 0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(15)),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Color.fromARGB(0, 0, 0, 0),
//                                                 width: 0)),
//                                         hintText: 'Matrícula',
//                                         hintStyle: TextStyle(
//                                             color: Color(0x4c000000),
//                                             fontFamily: 'DM Sans',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w700),
//                                         filled: true,
//                                         fillColor: Color(0xffbcd1ef),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 100,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     'ABC1234',
//                                     style: TextStyle(
//                                         fontFamily: 'FE-Font',
//                                         fontSize: 17,
//                                         color: Color(0xff4b6285)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         SizedBox(
//                           width: 330,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   pageController.animateToPage(0,
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       curve: Curves.easeOut);
//                                 },
//                                 child: Container(
//                                   width: 80,
//                                   height: 60,
//                                   child: const SizedBox(
//                                     child: Icon(
//                                       FontAwesomeIcons.arrowCircleLeft,
//                                       size: 40,
//                                       color: Color(0xff2c3f66),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: const Color(0xff2c3f66),
//                                       width: 3,
//                                     ),
//                                     color: const Color(0xff4b6285),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 30),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context, '/');
//                                 },
//                                 child: Container(
//                                   width: 220,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: const Color(0xff00091f),
//                                       width: 3,
//                                     ),
//                                     color: const Color(0xff001138),
//                                   ),
//                                   padding: const EdgeInsets.all(0.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: const [
//                                       Text(
//                                         "¡LISTO!",
//                                         style: TextStyle(
//                                           color: Color(0xffbcd1ef),
//                                           fontSize: 20,
//                                           fontFamily: "DM Sans",
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Page Indicator
//               Container(
//                 height: 40,
//                 width: 97,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: const Color(0xff4b6285),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: SmoothPageIndicator(
//                     controller: pageController,
//                     count: 2,
//                     effect: const ExpandingDotsEffect(
//                         activeDotColor: Color(0xff2c3f66),
//                         dotColor: Color.fromARGB(150, 44, 63, 102)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20)
//             ],
//           )),
//     );
//   }
// }
