// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterfire_ui/firestore.dart';

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//       BuildContext context, Widget child, ScrollableDetails details) {
//     return child;
//   }
// }

// // class Time {
// //   static Duration duration = const Duration(seconds: 0);
// // }

// class Inspector extends StatefulWidget {
//   const Inspector({Key? key}) : super(key: key);

//   @override
//   State<Inspector> createState() => _InspectorState();
// }

// class _InspectorState extends State<Inspector> {
//   final String? uid = FirebaseAuth.instance.currentUser?.uid;

//   String plate = '';
//   DocumentReference docRef =
//       FirebaseFirestore.instance.collection('users').doc();

//   void getPlate() async {
//     await FirebaseFirestore.instance.runTransaction((transaction) async {
//       final snapshot = await transaction.get(docRef);
//       final plateFirestore = snapshot.get("plate");
//       setState(() {
//         plate = plateFirestore;
//       });
//     });
//   }

//   void getPlates() async {
//     QuerySnapshot query =
//         await FirebaseFirestore.instance.collection('users').get();
//     print(query);
//   }

//   Future getRiver() async {
//     return await FirebaseFirestore.instance.collection('users').get();
//   }

//   final river = FirebaseFirestore.instance.collection('users').snapshots();

//   final usersQuery = FirebaseFirestore.instance
//       .collection('users')
//       .where('isCurrentlyParked', isEqualTo: false);

//   @override
//   void initState() {
//     //getPlates();
//     //setState(() {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController plateController = TextEditingController();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(100),
//           child: AppBar(
//             automaticallyImplyLeading: true,
//             backgroundColor: const Color(0xff161b33),
//             elevation: 0,
//             title: Column(
//               children: [
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   height: 70,
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value != null && value.length < 6) {
//                         return 'Te faltan caracteres';
//                       } else if (value != null && value.length > 7) {
//                         return 'Tenés alguna letra o número extra';
//                       } else if (value != null &&
//                           value.length == 6 &&
//                           !value.startsWith('H')) {
//                         return 'Te faltan caracteres';
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: plateController,
//                     textInputAction: TextInputAction.done,
//                     textCapitalization: TextCapitalization.characters,
//                     style: const TextStyle(
//                       fontFamily: 'DM Sans',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xffbcd1ef),
//                     ),
//                     autofocus: false,
//                     cursorHeight: 25.0,
//                     cursorColor: const Color(0xffbcd1ef),
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       helperText: ' ',
//                       errorStyle: TextStyle(
//                           color: Color.fromARGB(255, 255, 158, 158),
//                           fontWeight: FontWeight.w400),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 255, 158, 158),
//                           width: 1,
//                         ),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 255, 158, 158),
//                           width: 1,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide:
//                             BorderSide(color: Color(0xffbcd1ef), width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide:
//                             BorderSide(color: Color(0xffbcd1ef), width: 1),
//                       ),
//                       labelText: 'Matrícula',
//                       labelStyle: TextStyle(
//                           color: Color.fromARGB(100, 188, 209, 239),
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: const Color(0xff161b33),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: FirestoreListView<Map<String, dynamic>>(
//                   query: usersQuery,
//                   itemBuilder: (context, snapshot) {
//                     Map<String, dynamic> user = snapshot.data();
//                     return Column(
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: Container(
//                             height: 70,
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 15, 18, 35),
//                             ),
//                             child: Row(
//                               children: [
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   user['plate'],
//                                   style: const TextStyle(
//                                     fontFamily: 'DM Sans',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     color: Color(0xffbcd1ef),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: Container(
//                             height: 1,
//                             decoration: BoxDecoration(
//                               color: const Color(0xffbcd1ef).withOpacity(0.1),
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
