import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_tmdb/constants.dart';
import 'package:flutter_tmdb/service_locator.dart';
import 'package:flutter_tmdb/blocs/movies_bloc.dart';
import 'package:flutter_tmdb/ui/screens/detail/detail_screen.dart';

class MainCard extends StatelessWidget {
  final int id;
  final bool isFirst;
  final bool isLast;
  final String url;
  final String title;

  const MainCard({
    Key? key,
    required this.id,
    required this.isFirst,
    required this.isLast,
    required this.url,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        getIt<MoviesBloc>().getMovie(id),
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CurveRadius.m)),
          builder: (context) => const DetailScreen(),
        )
      },
      child: Container(
        margin: EdgeInsets.only(
          top: Spacing.xs,
          left: isFirst ? Spacing.m : Spacing.xs,
          right: isLast ? Spacing.m : Spacing.xs,
        ),
        width: 96.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(CurveRadius.m),
              child: CachedNetworkImage(
                imageUrl: url,
                height: 120.0,
                width: 96.0,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(height: Spacing.xs),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
