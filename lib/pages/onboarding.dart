import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/onboarding.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // final PageController controller;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: contents.length,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (_, i) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: contents[i].gradient,
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/icons/on1.svg',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 60,
                left: 10,
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/icons/on2.svg',
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Text(contents[i].title),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          // height: 1.5,
                        ),
                        child: Text(
                          contents[i].description,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DotsIndicator(
                            dotsCount: contents.length,
                            position: currentIndex.toDouble(),
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              color: Colors.grey,
                              spacing: const EdgeInsets.all(3),
                              sizes: const [
                                Size(12, 12),
                                Size(12, 12),
                                Size(12, 12),
                              ],
                              activeSize: const Size(50.0, 9.0),
                              activeColor: Colors.white,
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (currentIndex == contents.length - 1) {
                                Navigator.restorablePushNamedAndRemoveUntil(
                                  context,
                                  "/login",
                                  (r) => false,
                                );
                              }
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceIn,
                              );
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    child: Text('Next'),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/on3.svg',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}