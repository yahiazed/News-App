import 'package:dio/dio.dart';
import 'package:newsapp/core/error/exception.dart';
import 'package:newsapp/features/newsfeatures/data/model/newsmodel.dart';
import 'package:newsapp/features/newsfeatures/domain/entites/news.dart';
import 'package:newsapp/features/newsfeatures/domain/news_use_cases.dart/get_BusinessNews_use_case.dart';

abstract class RemoteDataSource {
  Future<List<NewsModel>> getAllBusinessNews();
  Future<List<NewsModel>> getAllSportsNews();
  Future<List<NewsModel>> getAllScienceNews();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});
  @override
  Future<List<NewsModel>> getAllBusinessNews() async {
    List<NewsModel> newsList = [];
    int? statusCode;

    await dio.get('v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) async {
      value.data['articles'].forEach((element) {
        newsList.add(NewsModel.fromJson(element));
        statusCode = value.statusCode;
      });
    });
    if (statusCode == 200) {
      return Future.value(newsList);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getAllScienceNews() {
    return _futureData('science');
  }

  @override
  Future<List<NewsModel>> getAllSportsNews() {
    return _futureData('sports');
  }

  Future<List<NewsModel>> _futureData(String type) async {
    List<NewsModel> newsList = [];
    int? statusCode;
    await dio.get('v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': type,
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) async {
      statusCode = value.statusCode;
      value.data['articles'].forEach((element) {
        newsList.add(NewsModel.fromJson(element));
      });
    });
    if (statusCode == 200) {
      return Future.value(newsList);
    } else {
      throw ServerException();
    }
  }
}
