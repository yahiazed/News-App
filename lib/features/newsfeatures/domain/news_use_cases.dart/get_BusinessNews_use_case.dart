import 'package:dartz/dartz.dart';
import 'package:newsapp/features/newsfeatures/domain/repository.dart';

import '../../../../core/error/failure.dart';
import '../entites/news.dart';

class GetAllBusinessNewsUseCase {
  final NewsRepository repository;

  GetAllBusinessNewsUseCase({required this.repository});

  Future<Either<Failure, List<News>>> call() async {
    return await repository.getAllBusinessNews();
  }
}
