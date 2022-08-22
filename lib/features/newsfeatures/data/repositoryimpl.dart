import 'package:newsapp/core/Network/networkinfo.dart';
import 'package:newsapp/core/error/exception.dart';
import 'package:newsapp/features/newsfeatures/data/data_sources/remotedatasource.dart';
import 'package:newsapp/features/newsfeatures/domain/entites/news.dart';

import 'package:newsapp/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../domain/repository.dart';
import 'data_sources/local_data_source.dart';
import 'model/newsmodel.dart';

typedef Future<List<NewsModel>> typeData();
typedef Future<Unit> f(List<NewsModel> cached);

class RepositoryImpl implements NewsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<News>>> getAllBusinessNews() async {
    if (await networkInfo.isConnect) {
      try {
        final remoteNews = await remoteDataSource.getAllBusinessNews();
        await localDataSource.cachedBusinessNews(remoteNews);
        return right(remoteNews);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        return right(await localDataSource.getCachedBusinessNews());
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<News>>> getAllScienceNews() async {
    if (await networkInfo.isConnect) {
      try {
        final remoteNews = await remoteDataSource.getAllScienceNews();
        await localDataSource.cachedScienceNews(remoteNews);
        return right(remoteNews);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        return right(await localDataSource.getCachedScienceNews());
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<News>>> getAllSportsNews() async {
    return getdata(
        remotefunction: remoteDataSource.getAllSportsNews,
        FunctionLocal: localDataSource.cachedSportsNews,
        getFunction: localDataSource.getCachedSportsNews);
  }

  Future<Either<Failure, List<News>>> getdata({
    required Future<List<NewsModel>> remotefunction(),
    required Future<Unit> FunctionLocal(List<NewsModel> list),
    required Future<List<NewsModel>> getFunction(),
  }) async {
    if (await networkInfo.isConnect) {
      try {
        final remoteNews = await remotefunction();
        await FunctionLocal(remoteNews);
        return right(remoteNews);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        return right(await getFunction());
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }
}
