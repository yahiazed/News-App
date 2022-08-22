import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/news.dart';
import '../repository.dart';

class GetAllSportsNewsUseCase {
  NewsRepository newsRepository;
  GetAllSportsNewsUseCase({required this.newsRepository});
  Future<Either<Failure, List<News>>> call() async {
    return await newsRepository.getAllSportsNews();
  }
}
