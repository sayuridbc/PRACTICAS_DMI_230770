import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';


final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {

  return MovieRepositoryImpl( MoviedbDatasource());
});