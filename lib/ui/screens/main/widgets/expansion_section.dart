import 'package:flutter/material.dart';
import 'package:flutter_tmdb/ui/screens/main/widgets/card.dart';

class MainExpansionSection extends StatelessWidget {
  final bool initiallyExpanded;
  final String title;

  const MainExpansionSection({Key? key, required this.title, this.initiallyExpanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: ExpansionTile(
          title: Text(title),
          backgroundColor: Colors.white,
          initiallyExpanded: initiallyExpanded,
          collapsedBackgroundColor: Colors.white,
          children: [
            SizedBox(
              height: 154.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => MainCard(
                  isFirst: index == 0,
                  isLast: index == 9,
                  url: "https://picsum.photos/96/128",
                  title: "Movie name",
                ),
                itemCount: 10,
              ),
            ),
            // So the horizontal scrollbar overscroll glow on Android would be properly aligned
            const SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }
}
