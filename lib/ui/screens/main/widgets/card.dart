import 'package:flutter/material.dart';

import 'package:flutter_tmdb/ui/screens/detail/detail_screen.dart';

class MainCard extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String url;
  final String title;

  const MainCard(
      {Key? key,
      required this.isFirst,
      required this.isLast,
      required this.url,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
          context: context,
          builder: (context) => const DetailScreen(),
        )
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 8.0,
          left: isFirst ? 16.0 : 8.0,
          right: isLast ? 16.0 : 8.0,
        ),
        width: 96.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                url,
                height: 120.0,
                width: 96.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            //FIXME
            FittedBox(
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }
}
