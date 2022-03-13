import 'package:flutter/material.dart';
import 'package:flutter_tmdb/constants.dart';

import 'package:flutter_tmdb/service_locator.dart';
import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:flutter_tmdb/models/movie_model.dart';
import 'package:flutter_tmdb/ui/screens/detail/widgets/detail_text.dart';
import 'package:flutter_tmdb/ui/screens/detail/widgets/play_container.dart';
import 'package:flutter_tmdb/utlities.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<MovieModel>(
          stream: getIt<MoviesBloc>().movie,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                      image: DecorationImage(
                        image: NetworkImage("$kPictureBaseUrl/${snapshot.data?.backdropPath}"),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                      ),
                    ),
                    child: ListView(
                      children: [
                        DetailText(
                          title: "Title",
                          text: snapshot.data?.title ?? "",
                        ),
                        DetailText(
                          title: "Overview",
                          text: snapshot.data?.overview ?? "",
                        ),
                        if (snapshot.hasData && snapshot.data!.budget! > 0)
                          DetailText(
                            title: "Budget",
                            text: intToDollars(snapshot.data!.budget!),
                          ),
                        if (snapshot.hasData && snapshot.data!.revenue! > 0)
                          DetailText(
                            title: "Revenue",
                            text: intToDollars(snapshot.data!.revenue!),
                          ),

                        /// TODO: All movies seem to have their video property set to false.
                        /// Uncomment when/if the API is fixed.
                        if (snapshot.hasData /* && snapshotData!.video! */)
                          Center(
                            child: PlayContainer(playMessage: snapshot.data!.title!),
                          )
                      ],
                    ),
                  );
          }),
    );
  }
}
