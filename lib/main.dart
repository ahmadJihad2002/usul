import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usul/modules/about/about.dart';
import 'package:usul/modules/home/home.dart';
import 'package:usul/modules/productDetail/productDetail.dart';
import 'package:usul/shared/components/constanse.dart';
import 'package:usul/shared/cubit/cubit.dart';
import 'package:usul/shared/cubit/states.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {

    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC5xQags9bPWItWGOiwwir5TFpsADDtYag",
          authDomain: "kamaldodeen-3764d.firebaseapp.com",
          projectId: "kamaldodeen-3764d",
          storageBucket: "kamaldodeen-3764d.appspot.com",
          messagingSenderId: "614967291168",
          appId: "1:614967291168:web:b5264e1512da9d258ffb45",
          measurementId: "G-QW888N1SC8"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp(startWidget: Home()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getHomeData()
              ..getAdminData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (ontext, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: {
              'ProductDetail': (context) => const ProductDetail(),
              'home': (context) => const Home(),
              'about': (context) => const About(),
            },
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.greenAccent),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: const TextTheme(
                    bodySmall: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w200),
                    bodyMedium: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400))
                 ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
