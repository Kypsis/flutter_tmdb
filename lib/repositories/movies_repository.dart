import 'dart:async';

import 'package:flutter_tmdb/api/client.dart';
import 'package:flutter_tmdb/models/movie_model.dart';
import 'package:flutter_tmdb/models/movies_model.dart';

class MoviesRepository {
  MoviesRepository({TMDBApiClient? tmdbApiClient})
      : _tmdbApiClient = tmdbApiClient ?? TMDBApiClient();

  final TMDBApiClient _tmdbApiClient;

  Future<List<MoviesResultModel>> getLatestMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.now_playing);
    return [...?movies.results];
  }

  Future<List<MoviesResultModel>> getPopularMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.popular);
    return [...?movies.results];
  }

  Future<List<MoviesResultModel>> getTopRatedMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.top_rated);
    return [...?movies.results];
  }

  Future<List<MoviesResultModel>> getUpcomingMovies() async {
    final movies = await _tmdbApiClient.getMovies(MovieCategory.upcoming);
    return [...?movies.results];
  }

  Future<MovieModel> getMovie(int id) async {
    final movie = await _tmdbApiClient.getMovie(id);
    return movie;
  }
}
