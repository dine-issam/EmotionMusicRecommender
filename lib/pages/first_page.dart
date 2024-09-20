import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_recommendation_ai_app/pages/second_page.dart';
import 'package:music_recommendation_ai_app/utils/my_background.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyBackground(
      backgroundImage: "assets/images/sonnet.png",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              height: 1.6,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text:
                                    'AI curated music playlist just for your mood \n',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              TextSpan(
                                text: 'Get Started Now!',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),

                            // Container for arrow forward
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SecondPage()));
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCCCC)
                                          .withOpacity(0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                        height: 60.0,
                                        width: 60.0,
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          shape: BoxShape.circle,
                                        ),

                                        // Arrow forward centered
                                        child: const Center(
                                          // Arrow forward
                                          child: Icon(
                                            Icons.arrow_forward,
                                          ),
                                        )))))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
