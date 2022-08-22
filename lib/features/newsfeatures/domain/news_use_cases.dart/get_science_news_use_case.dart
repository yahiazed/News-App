import 'package:dartz/dartz.dart';
import 'package:newsapp/features/newsfeatures/domain/repository.dart';

import '../../../../core/error/failure.dart';
import '../entites/news.dart';

class GetAllScienceNewsUseCase {
  NewsRepository newsRepository;
  GetAllScienceNewsUseCase({required this.newsRepository});
  Future<Either<Failure, List<News>>> call() async {
    return await newsRepository.getAllScienceNews();
  }
}
