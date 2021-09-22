import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/home_layout.dart';
import 'package:newsapp/shared/cubit/bloc_observer.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/state.dart';
import 'package:newsapp/shared/network/local/cached_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBool('isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getGeneral()
        ..getHealth()
        ..getSports()
        ..changeTheme(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark().copyWith(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      systemNavigationBarColor: Colors.black),
                )),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme(
                  bodyText1:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.green,
                    systemNavigationBarColor: Colors.green),
                backgroundColor: Colors.green,
                elevation: 4.0,
              ),
            ),
            home: new SplashScreen(
                seconds: 2,
                navigateAfterSeconds: new HomeLayout(),
                title: new Text(
                  'Get The Latest News !',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      color: Colors.green),
                ),
                image: new Image.asset(
                  'assets/images/news.png',
                ),
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: TextStyle(),
                photoSize: 200.0,
                loaderColor: Colors.green),
          );
        },
      ),
    );
  }
}
