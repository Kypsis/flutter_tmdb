import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<MoviesBloc>(MoviesBloc());
}
