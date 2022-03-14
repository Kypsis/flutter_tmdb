import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:flutter_tmdb/models/movie_model.dart';
import 'package:flutter_tmdb/models/movies_model.dart';
import 'package:flutter_tmdb/repositories/movies_repository.dart';

class MoviesBloc {
  final _repository = MoviesRepository();

  final _latestMovies = BehaviorSubject<List<MoviesResultModel>>();
  final _popularMovies = BehaviorSubject<List<MoviesResultModel>>();
  final _topRatedMovies = BehaviorSubject<List<MoviesResultModel>>();
  final _upcomingMovies = BehaviorSubject<List<MoviesResultModel>>();
  final _movie = BehaviorSubject<MovieModel>();

  void getLatestMovies() async {
    List<MoviesResultModel> response = await _repository.getLatestMovies();
    _latestMovies.sink.add(response);
    if (kDebugMode) {
      print("⤵️ Getting latest movies");
    }
  }

  void getPopularMovies() async {
    List<MoviesResultModel> response = await _repository.getPopularMovies();
    _popularMovies.sink.add(response);
  }

  void getTopRatedMovies() async {
    List<MoviesResultModel> response = await _repository.getTopRatedMovies();
    _topRatedMovies.sink.add(response);
  }

  void getUpcomingMovies() async {
    List<MoviesResultModel> response = await _repository.getUpcomingMovies();
    _upcomingMovies.sink.add(response);
  }

  void getMovie(int id) async {
    MovieModel response = await _repository.getMovie(id);
    _movie.sink.add(response);
  }

  dispose() {
    _latestMovies.close();
    _popularMovies.close();
    _topRatedMovies.close();
    _upcomingMovies.close();
    _movie.close();
  }

  ValueStream<List<MoviesResultModel>> get latestMovies => _latestMovies.stream;
  ValueStream<List<MoviesResultModel>> get popularMovies => _popularMovies.stream;
  ValueStream<List<MoviesResultModel>> get topRatedMovies => _topRatedMovies.stream;
  ValueStream<List<MoviesResultModel>> get upcomingMovies => _upcomingMovies.stream;
  ValueStream<MovieModel> get movie => _movie.stream;
}
