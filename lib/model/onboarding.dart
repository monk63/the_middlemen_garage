import 'package:flutter/material.dart';
import '../Components/constantsOnboarding.dart';

class OnboardingContent {
  String title;
  String description;
  List<Color> gradient;

  OnboardingContent(
      {required this.title, required this.description, required this.gradient});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Experience your food',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget cursus nibh arcu, magna euismod. Sed justo, nunc cras ornare.',
    gradient: gradient1,
  ),
  OnboardingContent(
    title: 'Taste the\ngoodness',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget cursus nibh arcu, magna euismod. Sed justo, nunc cras ornare.',
    gradient: gradient2,
  ),
  OnboardingContent(
    title: 'Delivery in\nminutes',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget cursus nibh arcu, magna euismod. Sed justo, nunc cras ornare.',
    gradient: gradient3,
  ),
];