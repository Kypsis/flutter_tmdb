import 'dart:async';

import 'package:flutter_tmdb/api/client.dart';
import 'package:flutter_tmdb/models/movies_model.dart';

class MoviesRepository {
  MoviesRepository({TMDBApiClient? tmdbApiClient})
      : _tmdbApiClient = tmdbApiClient ?? TMDBApiClient();

  final TMDBApiClient _tmdbApiClient;

  Future<List<MoviesResult>> getLatestMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.now_playing);
    return [...?movies.results];
  }

  Future<List<MoviesResult>> getPopularMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.popular);
    return [...?movies.results];
  }

  Future<List<MoviesResult>> getTopRatedMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.top_rated);
    return [...?movies.results];
  }

  Future<List<MoviesResult>> getUpcomingMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.upcoming);
    return [...?movies.results];
  }
}
