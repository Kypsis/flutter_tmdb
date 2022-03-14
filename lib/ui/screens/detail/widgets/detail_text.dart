import 'package:flutter/material.dart';

import 'package:flutter_tmdb/constants.dart';

class DetailText extends StatelessWidget {
  final String title;
  final String text;

  const DetailText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: Spacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$title:",
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          const SizedBox(width: Spacing.xs),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
