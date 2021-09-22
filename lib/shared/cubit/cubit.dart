import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/general%20screen/general_screen.dart';
import 'package:newsapp/modules/health%20screen/health_screen.dart';
import 'package:newsapp/modules/sports%20screen/sports_screen.dart';
import 'package:newsapp/shared/cubit/state.dart';
import 'package:newsapp/shared/network/local/cached_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.emoji_nature_outlined), label: 'General'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.medical_services), label: 'Health'),
  ];

  List<Widget> children = [GeneralScreen(), SportsScreen(), HealthScreen()];

  void changeIndex(int value) {
    currentIndex = value;
    emit(NewsBottomNavState());
  }

  List<dynamic> general = [];
  List<dynamic> sports = [];
  List<dynamic> health = [];
  List<dynamic> search = [];

  getHealth() {
    emit(NewsGetHealthLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'health',
      'apiKey': '86d2da036cb243808261c3a0fc451038'
    }).then((value) {
      health = value.data['articles'];
      print('get data !!');
      emit(NewsGetHealthState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetHealthErrorState(error));
    });
  }

  getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'sports',
      'apiKey': '86d2da036cb243808261c3a0fc451038'
    }).then((value) {
      sports = value.data['articles'];
      print('get data !!');
      emit(NewsGetSportsState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetSportsErrorState(error));
    });
  }

  getGeneral() {
    emit(NewsGetGeneralLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'general',
      'apiKey': '86d2da036cb243808261c3a0fc451038'
    }).then((value) {
      general = value.data['articles'];
      print('get data !!');
      emit(NewsGetGeneralState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetGeneralErrorState(error));
    });
  }

  getSearch(String value) {
    emit(NewsSearchLoadingState());
    DioHelper.getData('v2/everything', {
      'q': '$value',
      'apiKey': '86d2da036cb243808261c3a0fc451038'
    }).then((value) {
      search = value.data['articles'];
      print('get data !!');
      emit(NewsSearchState());
    }).catchError((error) {
      print('$error');
      emit(NewsSearchErrorState(error));
    });
  }

  bool isDark = false;

  changeTheme({bool fromShared}) {
    if (fromShared == null) {
      isDark = !isDark;
      CacheHelper.setBool(key: 'isDark', value: isDark);
      emit(NewsChangeThemeState());
    } else {
      isDark = fromShared;
      emit(NewsChangeThemeState());
    }
  }
}
