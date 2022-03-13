import 'package:flutter/material.dart';

class PlayContainer extends StatelessWidget {
  final String playMessage;

  const PlayContainer({Key? key, required this.playMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(playMessage)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        height: 96.0,
        width: 154.0,
        decoration:
            BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
        child: const Icon(
          Icons.play_circle_filled_outlined,
          color: Colors.white,
          size: 48.0,
        ),
      ),
    );
  }
}
