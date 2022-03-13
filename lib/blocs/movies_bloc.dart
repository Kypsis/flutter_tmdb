import 'package:rxdart/rxdart.dart';

import 'package:flutter_tmdb/models/movies_model.dart';
import 'package:flutter_tmdb/repositories/movies.dart';

class MoviesBloc {
  final _repository = MoviesRepository();
  final _latestMovies = BehaviorSubject<List<MoviesResult>>();
  final _popularMovies = BehaviorSubject<List<MoviesResult>>();
  final _topRatedMovies = BehaviorSubject<List<MoviesResult>>();
  final _upcomingMovies = BehaviorSubject<List<MoviesResult>>();

  void getLatestMovies() async {
    List<MoviesResult> response = await _repository.getLatestMovies();
    _latestMovies.sink.add(response);
  }

  void getPopularMovies() async {
    List<MoviesResult> response = await _repository.getPopularMovies();
    _popularMovies.sink.add(response);
  }

  void getTopRatedMovies() async {
    List<MoviesResult> response = await _repository.getTopRatedMovies();
    _topRatedMovies.sink.add(response);
  }

  void getUpcomingMovies() async {
    List<MoviesResult> response = await _repository.getUpcomingMovies();
    _upcomingMovies.sink.add(response);
  }

  dispose() {
    _latestMovies.close();
    _popularMovies.close();
    _topRatedMovies.close();
    _upcomingMovies.close();
  }

  ValueStream<List<MoviesResult>> get latestMovies => _latestMovies.stream;
  ValueStream<List<MoviesResult>> get popularMovies => _popularMovies.stream;
  ValueStream<List<MoviesResult>> get topRatedMovies => _topRatedMovies.stream;
  ValueStream<List<MoviesResult>> get upcomingMovies => _upcomingMovies.stream;
}
