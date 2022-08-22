// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/style/theme/light_theme.dart';
import 'package:newsapp/features/newsfeatures/data/model/newsmodel.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_cubit.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_states.dart';
import 'package:newsapp/features/newsfeatures/presentation/screens/Home.dart';
import 'package:newsapp/core/Colors/Colorss.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/shared/app_localization.dart';
import 'core/shared/bloc_observer.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await di.init();
  runApp(di.sl<MyApp>());
}

class MyApp extends StatelessWidget {
  SharedPreferences sharedPreferences;
  MyApp({super.key, required this.sharedPreferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<AppCubit>()
              ..getAllBusinessNews()
              ..getAllScienceNews()
              ..getAllSportsNews(),
          )
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            bool? isDark = sharedPreferences.getBool('isDark');
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }

                return supportedLocales.first;
              },
              theme: isDark ?? AppCubit.get(context).isDark ? Dark : Light,
              home: const HomeSC(),
            );
          },
        ));
  }
}
