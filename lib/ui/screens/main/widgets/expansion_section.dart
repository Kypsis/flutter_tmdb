import 'package:flutter/material.dart';
import 'package:flutter_tmdb/constants.dart';
import 'package:flutter_tmdb/models/movies_model.dart';
import 'package:rxdart/streams.dart';

import 'package:flutter_tmdb/ui/screens/main/widgets/card.dart';

class MainExpansionSection extends StatelessWidget {
  final String title;
  final bool initiallyExpanded;
  final ValueStream<List<MoviesResultModel>> movies;
  final VoidCallback? callback;

  const MainExpansionSection({
    Key? key,
    required this.title,
    this.initiallyExpanded = false,
    required this.movies,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: ExpansionTile(
          title: Text(title),
          maintainState: true,
          backgroundColor: Colors.white,
          initiallyExpanded: initiallyExpanded,
          collapsedBackgroundColor: Colors.white,
          onExpansionChanged: (expanding) => {
            if (callback != null) {callback!()}
          },
          children: [
            SizedBox(
              height: 154.0,
              child: StreamBuilder<List<MoviesResultModel>>(
                  stream: movies,
                  builder: (context, snapshot) {
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
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => MainCard(
                              id: snapshot.data![index].id!,
                              isFirst: index == 0,
                              isLast: index == movies.value.length - 1,
                              url: "$kPictureBaseUrl/w500${snapshot.data![index].posterPath}",
                              title: snapshot.data![index].title!,
                            ),
                            itemCount: movies.value.length,
                          );
                  }),
            ),
            // To have the horizontal scrollbar overscroll glow on Android properly aligned
            const SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }
}
