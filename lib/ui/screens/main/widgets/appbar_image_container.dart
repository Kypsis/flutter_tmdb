import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_tmdb/constants.dart';

class AppbarImageContainer extends StatelessWidget {
  final String imagePath;

  const AppbarImageContainer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CurveRadius.m),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF444444),
            blurRadius: 4.0,
            offset: Offset(1.0, 2.0), // Shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CurveRadius.m),
        child: CachedNetworkImage(
          imageUrl: "$kPictureBaseUrl/w500$imagePath",
          height: 192.0,
          width: 192.0,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
