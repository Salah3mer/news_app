import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/network/local/cash_helper.dart';
import 'package:news_app/news_cubit/states.dart';
import 'package:news_app/screens/allNewes/allNews.dart';
import 'package:news_app/screens/business_screen/businss_screen.dart';
import 'package:news_app/screens/sciences/sciences.dart';
import 'package:news_app/screens/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    All_Newes_Screen(),
    Business_Screen(),
    Sport_Screen(),
    Sciences_Screen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.newspaper), label: 'All News'),
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
  ];

  int currentIndex = 0;

  void bottomNavChange(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  List<dynamic> business = [];

  getBusinessData() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '60c0f90b6582441abfd7ce1ef7dc76ef',
    }).then((value) {
      business = value.data['articles'];
      emit(GetBusinessNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessNewsErrorState(error.toString()));
    });
  }

  List<dynamic> sport = [];

  void getSportsData() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        'apiKey': '60c0f90b6582441abfd7ce1ef7dc76ef',
        'country': 'eg',
        'category': 'sports',
      },
    ).then((value) {
      sport = value.data['articles'];
      emit(GetSportNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSportNewsErrorState(error.toString()));
    });
  }

  List<dynamic> sciences = [];

  void getSciencesData() {
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'apiKey': '60c0f90b6582441abfd7ce1ef7dc76ef',
      'country': 'eg',
      'category': 'science',
    }).then((value) {
      print('==================================');

      sciences = value.data['articles'];
      print(sciences);
      print('==================================');

      emit(GetSciencesNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSciencesNewsErrorState(error.toString()));
    });
  }

  List<dynamic> everything = [];

  void getEverything() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {'country': 'eg', 'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'},
    ).then((value) {
      everything = value.data['articles'];
      print('=====${everything.length}=====');
      emit(GetEverythingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetEverythingErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
          'q':'$value',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      search = value.data['articles'];
      print('=====${everything.length}=====');
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeMood({bool shareMood}) {
    if (shareMood != null) {
      isDark = shareMood;
      emit(ChangeMoodState());
    } else {
      isDark = !isDark;
      Cash_Helper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeMoodState());
        print('isDark $value');
      }).catchError((error){
        print(error);
      });
    }
  }
}
