import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.artist, required this.title});
  final String artist;
  final String title;

  Future<void> _openSpotify() async {
    final playlistQuery = '$artist $title';
    String modifiedString = playlistQuery.replaceAll(' ', '%20');
    final url = Uri.parse('https://open.spotify.com/search/$modifiedString');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openYoutube() async {
    final playlistQuery = '$artist+$title';
    final url = Uri.parse(
        'https://www.youtube.com/results?search_query=$playlistQuery');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Center(
                    child: Text(
                      'Listen to the song on?',
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // spotify container
                      GestureDetector(
                        onTap: _openSpotify,
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/spotify.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // Youtube container
                      GestureDetector(
                        onTap: _openYoutube,
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/youtube.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Image.asset("assets/images/sonnetlogo.png"),
        ),
        title: Text(
          artist,
          style: GoogleFonts.inter(
              color: const Color(0xFFFFFFFF).withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(
            title,
            style: GoogleFonts.inter(
                color: const Color(0xFFFFFFFF).withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
