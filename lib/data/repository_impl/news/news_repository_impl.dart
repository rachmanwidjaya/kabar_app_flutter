import 'package:dartz/dartz.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import '../../../core/exceptions/app_exception.dart';
import '../../../core/exceptions/parser_exeption.dart';
import '../../../domain/entities/news/home_entity.dart';
import '../../../domain/entities/news/news_category_entity.dart';
import '../../../domain/entities/news/news_entity.dart';
import '../../../domain/entities/news/news_read_entity.dart';
import '../../../domain/repository/api_repository.dart';
import '../../../domain/repository/news_repository.dart';

part '_parser.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiRepository apiRepository;

  NewsRepositoryImpl({required this.apiRepository});

  @override
  Future<Either<Exception, HomeEntity>> loadHome() async {
    try {
      return await apiRepository
          .request('https://www.liputan6.com/')
          .then((value) => Right(_Parser().parseHome(value)));
    } catch (e, s) {
      return Left(AppException(message: '$e', error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Exception, List<NewsEntity>>> loadNewsByCategoryList(
      String endPoint) async {
    try {
      return await apiRepository
          .request(endPoint)
          .then((value) => Right(_Parser().parseNewList(value)));
    } catch (e, s) {
      return Left(AppException(message: '$e', error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Exception, NewsReadEntiry>> loadNewsRead(
      String endPoint) async {
    try {
      return await apiRepository
          .request(endPoint)
          .then((value) => Right(_Parser().parseRead(value)));
    } catch (e, s) {
      return Left(AppException(message: '$e', error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Exception, List<NewsEntity>>> loadNewsByTag(
      String endPoint) async {
    try {
      return await apiRepository
          .request(endPoint)
          .then((value) => Right(_Parser().parseByTag(value)));
    } catch (e, s) {
      return Left(AppException(message: '$e', error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Exception, List<NewsEntity>>> search(String keyword) async {
    try {
      return await apiRepository
          .request(
              'https://www.liputan6.com/search?q=${keyword.replaceAll(" ", "+")}')
          .then((value) => Right(_Parser().parseNewList(value)));
    } catch (e, s) {
      return Left(AppException(message: '$e', error: e, stackTrace: s));
    }
  }
}
