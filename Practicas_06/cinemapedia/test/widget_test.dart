// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinemapedia/main.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';

void main() {
  testWidgets('app loads without crashing', (WidgetTester tester) async {
    dotenv.loadFromString(envString: 'THE_MOVIEDB_KEY=test-key');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWith(
            (ref) => MovieRepositoryImpl(_FakeMoviesDatasource()),
          ),
        ],
        child: const MainApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}

class _FakeMoviesDatasource extends MoviesDatasource {
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async => [];

  @override
  Future<List<Movie>> getPopular({int page = 1}) async => [];

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => [];

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => [];

  @override
  Future<Movie> getMovieById(String id) async => throw UnimplementedError();

  @override
  Future<List<Movie>> searchMovies(String query) async => [];
}
