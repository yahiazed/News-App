import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsapp/core/Network/networkinfo.dart';
import 'package:newsapp/features/newsfeatures/data/data_sources/local_data_source.dart';
import 'package:newsapp/features/newsfeatures/data/data_sources/remotedatasource.dart';
import 'package:newsapp/features/newsfeatures/data/repositoryimpl.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_BusinessNews_use_case.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_science_news_use_case.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_sports_news_use_case.dart';
import 'package:newsapp/features/newsfeatures/domain/repository.dart';
import 'package:newsapp/features/newsfeatures/presentation/cubit/app_cubit.dart';
import 'package:newsapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(
      () => GetAllScienceNewsUseCase(newsRepository: sl()));
  sl.registerLazySingleton(() => GetAllSportsNewsUseCase(newsRepository: sl()));
  sl.registerFactory(() => AppCubit(
      getAllBusinessNewsUseCase: sl(),
      networkInfo: sl(),
      getAllScienceNewsUseCase: sl(),
      getAllSportsNewsUseCase: sl(),
      sharedPreferences: sl()));
  // needs repository
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://newsapi.org/',
      receiveDataWhenStatusError: true,
    ),
  );
  sl.registerLazySingleton(() => MyApp(sharedPreferences: sl()));
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NewsRepository>(() => RepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
  sl.registerLazySingleton(() => GetAllBusinessNewsUseCase(repository: sl()));
}
