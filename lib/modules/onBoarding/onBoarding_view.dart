import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingView extends StatefulWidget {
  static String routeName = "/onBoarding_view";
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> introPages = [
    {
      "topImage": "assets/images/onBoardingLogo.png",
      "middleImage": "assets/images/pg1.png",
      "text": "Personalize Your Experience",
      "Text2": "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    },
    {
      "topImage": "assets/images/onBoardingLogo.png",
      "middleImage": "assets/images/pg2.png",
      "text": "Find Events That Inspire You",
      "Text2": "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you",
    },
    {
      "topImage": "assets/images/onBoardingLogo.png",
      "middleImage": "assets/images/pg3.png",
      "text": "Effortless Event Planning",
      "Text2": "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    },
    {
      "topImage": "assets/images/onBoardingLogo.png",
      "middleImage": "assets/images/pg4.png",
      "text": "Connect with Friends & Share Moments",
      "Text2": "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Center(
              child: Image.asset(
                introPages[_currentPage]["topImage"]!,
                height: 60,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: introPages.length,
              itemBuilder: (context, index) {
                final page = introPages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      page["middleImage"]!,
                      height: size.height * 0.45,
                      width: size.width * 0.95,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            page["text"]!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: "Inter",
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            page["Text2"]!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Inter",
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/1p.png",
                              height: size.height * 0.1,
                              width: size.width * 0.9,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {

                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.primaryColor,
                                minimumSize: Size(size.width * 0.8, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                "Let's Start",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),

            if (_currentPage > 0)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorPalette.primaryColor, width: 2),
                          ),
                          child: const Icon(Icons.arrow_back, color: ColorPalette.primaryColor),
                        ),
                      ),
                    const Spacer(),
                    if (_currentPage < introPages.length - 1)
                      GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorPalette.primaryColor, width: 2),
                          ),
                          child: const Icon(Icons.arrow_forward, color: ColorPalette.primaryColor),
                        ),
                      ),
                  ],
                ),
              ),
            if (_currentPage > 0)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introPages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 6,
                      width: _currentPage == index ? 20 : 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? ColorPalette.primaryColor : Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentPage == introPages.length - 1)
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () async {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isFirstRun', false);

                    Navigator.pushNamed(context, PagesRouteName.layout);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPalette.primaryColor, width: 2),
                    ),
                    child: const Icon(Icons.arrow_forward, color: ColorPalette.primaryColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
