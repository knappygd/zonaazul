import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zonaazul/firebase/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:zonaazul/utils/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zonaazul/screens/history/hive/data.dart';

/// Routes ///
// ============== //
// screens
import 'screens/login_reg.dart';

// screens/login
import 'screens/login/login.dart';

// screens/reg
import 'screens/reg/reg.dart';

// screens/request
import 'screens/request/request.dart';

// screens/account
import 'screens/account/account.dart';

// screens/account/options
import 'screens/account/options/modify.dart';

// screens/account/options/modify
import 'screens/account/options/modify/newemail.dart';
import 'screens/account/options/modify/newname.dart';
import 'screens/account/options/modify/newpassword.dart';
import 'screens/account/options/modify/newplate.dart';

// screens/bluecard
import 'screens/bluecard/cardinfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  AwesomeNotifications().initialize(
    'resource://drawable/ic_notificationicon',
    [
      NotificationChannel(
        channelKey: 'an_channel',
        channelName: 'Notificación de tiempo',
        channelDescription: 'Tiempo de estacionamiento agotado',
        importance: NotificationImportance.High,
        channelShowBadge: true,
        defaultColor: Colors.blue[600],
      ),
    ],
  );
  runApp(const ZonaAzul());
}

Map<String, WidgetBuilder> routes = {
  '/': (context) => const AuthWrapper(),
  '/login_reg': (context) => const LoginReg(),
  '/reg/reg': (context) => const Reg(),
  '/login/login': (context) => const Login(),
  '/request/request': (context) => const Request(),
  '/account/account': (context) => const Account(),
  '/account/options/modify': (context) => const Modify(),
  '/account/options/modify/newemail': (context) => const NewEmail(),
  '/account/options/modify/newname': (context) => const NewName(),
  // ignore: prefer_const_constructors
  '/account/options/modify/newpassword': (context) => NewPassword(),
  '/account/options/modify/newplate': (context) => const NewPlate(),
  '/bluecard/cardinfo': (context) => const CardInfo(),
};

class ZonaAzul extends StatelessWidget {
  const ZonaAzul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (_) => Auth(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Auth>().authStateChanges,
          initialData: null,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return const Request();
    }
    return const LoginReg();
  }
}
