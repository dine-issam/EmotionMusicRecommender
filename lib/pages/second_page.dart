import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_recommendation_ai_app/pages/third_page.dart';
import 'package:music_recommendation_ai_app/utils/my_background.dart';
import 'package:music_recommendation_ai_app/utils/my_loading_circle.dart';
import 'package:music_recommendation_ai_app/utils/my_random_circles.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<String> genres = [
    'Jazz',
    'Rock',
    'Amapiano',
    'R&B',
    'Latin',
    'Hip-Hop',
    'Hip-Life',
    'Reggae',
    'Gospel',
    'Afrobeat',
    'Blues',
    'Country',
    'Punk',
    'Pop',
  ];

  final Set<String> _selectedGenres = {};
  // Selected mood
  String? _selectedMood;

  // Selected mood image
  String? _selectedMoodImage;

  // PlayList
  List<Map<String, String>> _playlist = [];

  // Loading state
  // ignore: unused_field
  bool _isLoading = false;

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: '',// Put your Api 
  );
// Function to submit mood and genres and fetch playlist
  Future<void> _submitSelections() async {
    if (_selectedMood == null || _selectedGenres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select a mood and at least one genre")));
      return;
    }
    setState(() {
      _isLoading = true;
      showLoadingCircle(context);
    });

    // Construct the prompt text using the selected mood and genres
    final promptText =
        'I want just a listed music playlist that has 20 songs for '
        'Mood: $_selectedMood, Genres: ${_selectedGenres.join(', ')} '
        'in the format of a list of maps like this: [{"artist": "Drake", "title": "Hotline Bling"}]. do not use any word with it like json or something like that ';

    // API call to get playlist recommendations
    final response = await model.generateContent([Content.text(promptText)]);

    print(response.text);

    // Check if the response has text and is not empty
    if (response.text != null && response.text!.isNotEmpty) {
      try {
        // Parse the JSON response into a list of maps
        final List<dynamic> jsonResponse = jsonDecode(response.text!);
        final List<Map<String, String>> playlist = jsonResponse
            .map((item) => {
                  'artist': item['artist'] as String,
                  'title': item['title'] as String,
                })
            .toList();

        // Print the playlist for debugging
        print('Final playlist: $playlist');

        // Set the playlist in state
        setState(() {
          _playlist = playlist;
          _isLoading = false;
          hideLoadingCircle(context);
        });

        // Navigate to ThirdPage with the selected mood and playlist
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThirdPage(
              imageMood: _selectedMoodImage ?? '',
              mood: _selectedMood ?? '',
              playlist: _playlist,
            ),
          ),
        );
      } catch (e) {
        print('Error parsing response: $e');
        setState(() {
          _isLoading = false;
          hideLoadingCircle(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to parse playlist')),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch playlist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        backgroundImage: "assets/images/background.png",
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: MyRandomCircles(
                onMoodSelected: (mood, image) {
                  _selectedMood = mood;
                  _selectedMoodImage = image;
                },
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Genre",
                        style: GoogleFonts.inter(
                            color: const Color(0xFFFFFFFF).withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Wrap(
                          children: genres.map((genre) {
                            final isSelected = _selectedGenres.contains(genre);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_selectedGenres.contains(genre)) {
                                    _selectedGenres.remove(genre);
                                  } else {
                                    _selectedGenres.add(genre);
                                  }
                                });
                              },
                              // Container with border around each genre
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                margin:
                                    const EdgeInsets.only(right: 4.0, top: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 0.4,
                                    color: const Color(0xFFFFFFFF)
                                        .withOpacity(0.8),
                                  ),
                                ),
                                // Container for each genre
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF0000FF)
                                        : const Color(0xFFFFFFFF)
                                            .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  // Text for each genre
                                  child: Text(
                                    genre,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? const Color(0xFFFFFFFF)
                                          : const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: _submitSelections,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 140, vertical: 15),
                          margin: const EdgeInsets.only(bottom: 60),
                          decoration: BoxDecoration(
                              color: const Color(
                                0xFFFFCCCC,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Submit",
                            style: GoogleFonts.inter(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
