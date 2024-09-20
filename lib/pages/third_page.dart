import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_recommendation_ai_app/utils/my_background.dart';
import 'package:music_recommendation_ai_app/utils/my_list_tile.dart';

class ThirdPage extends StatelessWidget {
  final String imageMood;
  final String mood;
  final List<Map<String, String>> playlist;

  const ThirdPage(
      {super.key,
      required this.imageMood,
      required this.mood,
      required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        backgroundImage: "assets/images/background.png",
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Stack(children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageMood),
                        fit: BoxFit.contain,
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    margin: const EdgeInsets.only(right: 4.0, top: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 0.4,
                        color: const Color(0xFFFFFFFF).withOpacity(0.8),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        mood,
                        style: GoogleFonts.inter(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: const Border(
                      top: BorderSide(
                        width: 0.4,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child:
                      // Playlist text here
                      Text(
                    'Playlist',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFFFFF).withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        final song = playlist[index];
                        return MyListTile(
                            artist: song['artist']!, title: song['title']!);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
