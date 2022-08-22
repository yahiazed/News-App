import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/error/failure.dart';
import 'package:newsapp/core/shared/app_localization.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_BusinessNews_use_case.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_science_news_use_case.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_sports_news_use_case.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_states.dart';
import 'package:newsapp/features/newsfeatures/presentation/screens/business_screen.dart';
import 'package:newsapp/features/newsfeatures/presentation/screens/science.dart';
import 'package:newsapp/features/newsfeatures/presentation/screens/sportsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Network/networkinfo.dart';
import '../../domain/entites/news.dart';

class AppCubit extends Cubit<AppStates> {
  GetAllBusinessNewsUseCase getAllBusinessNewsUseCase;
  GetAllScienceNewsUseCase getAllScienceNewsUseCase;
  GetAllSportsNewsUseCase getAllSportsNewsUseCase;
  SharedPreferences sharedPreferences;
  NetworkInfo networkInfo;
  AppCubit(
      {required this.getAllBusinessNewsUseCase,
      required this.networkInfo,
      required this.getAllScienceNewsUseCase,
      required this.getAllSportsNewsUseCase,
      required this.sharedPreferences})
      : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int bottomIndex = 0;
  bool isDark = true;
  void changeTheme() {
    emit(ThemeStateOne());
    isDark = !isDark;
    sharedPreferences.setBool('isDark', isDark);
    emit(ThemeStateTwo());
  }

  bool internetConnectionChecker = false;

  List<Widget> Screens = [
    BusinessSC(),
    SportsSC(),
    ScienceSC(),
  ];
  List<String> titles = ["Business", "Sports", "Science"];
  void changeBottomIndex(int index) {
    bottomIndex = index;
    emit(BottomNavBarChangeState());
  }

  List<News> businessList = [];

  Future getAllBusinessNews() async {
    emit(LoadingBusinessNews());
    final list = await getAllBusinessNewsUseCase();
    list.fold((failure) {
      _message(failure);
      emit(ErrorBusinessNews());
    }, (news) {
      businessList = news;
      emit(SuccessBusinessNews());
    });
  }

  List<News> sportsList = [];

  Future getAllSportsNews() async {
    emit(LoadingSportsNews());
    final list = await getAllSportsNewsUseCase();
    list.fold((failure) {
      _message(failure);
      emit(ErrorSportsNews());
    }, (news) {
      sportsList = news;
      emit(SuccessSportsNews());
    });
  }

  List<News> scienceList = [];

  Future getAllScienceNews() async {
    emit(LoadingScienceNews());
    final list = await getAllScienceNewsUseCase();
    list.fold((failure) {
      _message(failure);
      emit(ErrorScienceNews());
    }, (news) {
      scienceList = news;
      emit(SuccessScienceNews());
    });
  }

  String _message(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'ServerFailure';
      case EmptyCacheFailure:
        return 'First use ';
      case OfflineFailure:
        return ' There is no Internet';
      default:
        return 'UnEXcepted Error please try again';
    }
  }
}
