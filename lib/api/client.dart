// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter_tmdb/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_tmdb/models/movies_model.dart';

enum MovieCategory {
  now_playing,
  popular,
  top_rated,
  upcoming,
}

class MoviesRequestFailure implements Exception {}

class MoviesNotFoundFailure implements Exception {}

class MovieRequestFailure implements Exception {}

class MovieNotFoundFailure implements Exception {}

class TMDBApiClient {
  static const _baseUrl = "api.themoviedb.org";
  final http.Client _httpClient;

  TMDBApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  Future<MoviesModel> getMovies(MovieCategory category) async {
    final queryParameters = {
      "api_key": dotenv.env["TMDB_KEY"],
      "language": "en-US",
      "page": "1",
    };

    final latestMoviesRequest = Uri.https(_baseUrl, "/3/movie/${category.name}", queryParameters);

    final latestMoviesResponse = await _httpClient.get(latestMoviesRequest);

    if (latestMoviesResponse.statusCode != 200) {
      throw MoviesRequestFailure();
    }

    final bodyJson = jsonDecode(latestMoviesResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw MoviesNotFoundFailure();
    }

    return MoviesModel.fromJson(bodyJson);
  }

  Future<MovieModel> getMovie(int movieId) async {
    final queryParameters = {
      "api_key": dotenv.env["TMDB_KEY"],
      "language": "en-US",
    };

    final latestMoviesRequest = Uri.https(_baseUrl, "/3/movie/$movieId", queryParameters);

    final latestMoviesResponse = await _httpClient.get(latestMoviesRequest);

    if (latestMoviesResponse.statusCode != 200) {
      throw MovieRequestFailure();
    }

    final bodyJson = jsonDecode(latestMoviesResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty || bodyJson["status_code"] == 34) {
      throw MovieNotFoundFailure();
    }

    return MovieModel.fromJson(bodyJson);
  }
}
