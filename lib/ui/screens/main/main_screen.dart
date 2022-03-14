import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tmdb/models/movies_model.dart';

import 'package:flutter_tmdb/utlities.dart';
import 'package:flutter_tmdb/service_locator.dart';
import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:flutter_tmdb/ui/screens/main/widgets/expansion_section.dart';
import 'package:flutter_tmdb/ui/screens/main/widgets/appbar_image_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? timer;

  void initializePeriodicFetch() {
    timer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => getIt<MoviesBloc>().getLatestMovies());
  }

  void togglePeriodicFetch() {
    if (timer?.isActive == true) {
      timer?.cancel();
    } else {
      initializePeriodicFetch();
    }
  }

  @override
  void initState() {
    super.initState();
    initializePeriodicFetch();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // So the app extends behind iPhone notch
      //extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 256.0,
            backgroundColor: Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: StreamBuilder<List<MoviesResultModel>>(
                  stream: getIt<MoviesBloc>().popularMovies,
                  builder: (context, snapshot) {
                    final int randomIndex = getRandomIndex(snapshot.data?.length ?? 1);

                    if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error loading image")),
                      );
                    }
                    return snapshot.connectionState == ConnectionState.waiting ||
                            snapshot.data == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppbarImageContainer(imagePath: snapshot.data![randomIndex].posterPath!);
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                MainExpansionSection(
                  title: "Latest movies",
                  initiallyExpanded: true,
                  movies: getIt<MoviesBloc>().latestMovies,
                  callback: () => togglePeriodicFetch(),
                ),
                MainExpansionSection(
                  title: "Popular movies",
                  initiallyExpanded: true,
                  movies: getIt<MoviesBloc>().popularMovies,
                ),
                MainExpansionSection(
                  title: "Top Rated movies",
                  movies: getIt<MoviesBloc>().topRatedMovies,
                  callback: () => getIt<MoviesBloc>().getTopRatedMovies(),
                ),
                MainExpansionSection(
                  title: "Upcoming movies",
                  movies: getIt<MoviesBloc>().upcomingMovies,
                  callback: () => getIt<MoviesBloc>().getUpcomingMovies(),
                ),
              ],
            ),
          ),
          // Compensating for extendBodyBehindAppBar: true property
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom),
          )
        ],
      ),
    );
  }
}
