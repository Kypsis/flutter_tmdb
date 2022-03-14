import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:flutter_tmdb/service_locator.dart';
import 'package:flutter_tmdb/ui/screens/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupGetIt();
  getIt<MoviesBloc>().getLatestMovies();
  getIt<MoviesBloc>().getPopularMovies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter TMDB',
      home: MainScreen(),
    );
  }
}
