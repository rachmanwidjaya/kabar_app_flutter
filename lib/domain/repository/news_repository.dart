import 'package:dartz/dartz.dart';

import '../entities/news/home_entity.dart';
import '../entities/news/news_entity.dart';
import '../entities/news/news_read_entity.dart';

abstract class NewsRepository {
  Future<Either<Exception, HomeEntity>> loadHome();
  Future<Either<Exception, List<NewsEntity>>> loadNewsByCategoryList(
      String endPoint);

  Future<Either<Exception, NewsReadEntiry>> loadNewsRead(String endPoint);

  Future<Either<Exception, List<NewsEntity>>> loadNewsByTag(String endPoint);

  Future<Either<Exception, List<NewsEntity>>> search(String keyword);
}
