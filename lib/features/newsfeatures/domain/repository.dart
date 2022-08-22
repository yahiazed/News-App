import 'package:dartz/dartz.dart';
import 'package:newsapp/features/newsfeatures/domain/entites/news.dart';

import '../../../core/error/failure.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getAllBusinessNews();
  Future<Either<Failure, List<News>>> getAllScienceNews();
  Future<Either<Failure, List<News>>> getAllSportsNews();
}
