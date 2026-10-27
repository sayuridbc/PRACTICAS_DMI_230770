import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:riverpod/riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MoviesNotifier(getNowPlayingMovies: moviesRepository.getNowPlaying);
});

typedef GetNowPlayingMoviesCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  
int currentPage = 0;

MoviesNotifier(): super([]) {
    loadNextPage();
  }

  final Future<List<Movie>> Function({int page}) getNowPlayingMovies;

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies (page: currentPage);
    state = [...state, ...movies];                                                                          
  }
 

}