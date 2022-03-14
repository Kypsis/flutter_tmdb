import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_tmdb/utlities.dart';
import 'package:flutter_tmdb/constants.dart';
import 'package:flutter_tmdb/service_locator.dart';
import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:flutter_tmdb/models/movie_model.dart';
import 'package:flutter_tmdb/ui/screens/detail/widgets/detail_text.dart';
import 'package:flutter_tmdb/ui/screens/detail/widgets/play_container.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<MovieModel>(
          stream: getIt<MoviesBloc>().movie,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error loading image")),
              );
            }
            return snapshot.connectionState == ConnectionState.waiting || snapshot.data == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RepaintBoundary(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: Spacing.l, top: Spacing.m, right: Spacing.l),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.all(Radius.circular(CurveRadius.m)),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "$kPictureBaseUrl/w780${snapshot.data?.backdropPath}"),
                          fit: BoxFit.cover,
                          colorFilter:
                              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                        ),
                      ),
                      child: ListView(
                        children: [
                          DetailText(
                            key: const ValueKey("title"),
                            title: "Title",
                            text: snapshot.data?.title ?? "",
                          ),
                          DetailText(
                            key: const ValueKey("overview"),
                            title: "Overview",
                            text: snapshot.data?.overview ?? "",
                          ),
                          if (snapshot.hasData && snapshot.data!.budget! > 0)
                            DetailText(
                              key: const ValueKey("budget"),
                              title: "Budget",
                              text: intToDollars(snapshot.data!.budget!),
                            ),
                          if (snapshot.hasData && snapshot.data!.revenue! > 0)
                            DetailText(
                              key: const ValueKey("revenue"),
                              title: "Revenue",
                              text: intToDollars(snapshot.data!.revenue!),
                            ),

                          /// TODO: All movies seem to have their video property set to false.
                          /// Uncomment when/if the API is fixed.
                          if (snapshot.hasData /* && snapshotData!.video! */)
                            Center(
                              key: const ValueKey("playContainer"),
                              child: PlayContainer(playMessage: snapshot.data!.title!),
                            )
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
