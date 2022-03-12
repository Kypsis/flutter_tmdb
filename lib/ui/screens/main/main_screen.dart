import 'package:flutter/material.dart';
import 'package:flutter_tmdb/ui/screens/main/widgets/expansion_section.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 192.0,
                  width: 192.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF444444),
                        blurRadius: 4.0,
                        offset: Offset(1.0, 2.0), // Shadow position
                      ),
                    ],
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://picsum.photos/192/192"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const MainExpansionSection(
                  title: "Latest movies",
                  initiallyExpanded: true,
                ),
                const MainExpansionSection(
                  title: "Popular movies",
                  initiallyExpanded: true,
                ),
                const MainExpansionSection(title: "Top Rated movies"),
                const MainExpansionSection(title: "Upcoming movies"),
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