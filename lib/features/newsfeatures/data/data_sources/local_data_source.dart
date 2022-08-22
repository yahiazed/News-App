import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/exception.dart';
import 'package:newsapp/features/newsfeatures/data/model/newsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/strings/sharedkeys.dart';

abstract class LocalDataSource {
  Future<Unit> cachedBusinessNews(List<NewsModel> businessList);
  Future<List<NewsModel>> getCachedBusinessNews();
  Future<Unit> cachedSportsNews(List<NewsModel> sportsList);
  Future<List<NewsModel>> getCachedSportsNews();
  Future<Unit> cachedScienceNews(List<NewsModel> scienceList);
  Future<List<NewsModel>> getCachedScienceNews();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedBusinessNews(List<NewsModel> businessList) {
    List listToJsonBusiness =
        businessList.map<Map<String, dynamic>>((e) => e.tojson()).toList();
    sharedPreferences.setString(
        'CachedNewsBusinessList', jsonEncode(listToJsonBusiness));
    return Future.value(unit);
  }

  @override
  Future<List<NewsModel>> getCachedBusinessNews() async {
    String? stringJson = sharedPreferences.getString('CachedNewsBusinessList');
    if (stringJson != null) {
      List decodedJsonList = jsonDecode(stringJson);
      List<NewsModel> decodedNews =
          decodedJsonList.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
      return decodedNews;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachedScienceNews(List<NewsModel> scienceList) async {
    return await cache(contentList: scienceList, shared: scienceListShared);
  }

  @override
  Future<Unit> cachedSportsNews(List<NewsModel> sportsList) async {
    return await cache(contentList: sportsList, shared: sportsListShared);
  }

  @override
  Future<List<NewsModel>> getCachedScienceNews() async {
    return await getCached(key: scienceListShared);
  }

  @override
  Future<List<NewsModel>> getCachedSportsNews() async {
    return await getCached(key: sportsListShared);
  }

  Future<Unit> cache(
      {required List<NewsModel> contentList, required String shared}) {
    List listToJsonBusiness =
        contentList.map<Map<String, dynamic>>((e) => e.tojson()).toList();
    sharedPreferences.setString(shared, jsonEncode(listToJsonBusiness));
    return Future.value(unit);
  }

  Future<List<NewsModel>> getCached({
    required String key,
  }) async {
    String? stringJson = sharedPreferences.getString(key);
    if (stringJson != null) {
      List decodedJsonList = jsonDecode(stringJson);
      List<NewsModel> decodedNews =
          decodedJsonList.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
      return decodedNews;
    } else {
      throw EmptyCacheException();
    }
  }
}
