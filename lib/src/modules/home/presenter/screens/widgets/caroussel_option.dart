import 'package:flutter/material.dart';

class CarouselOption extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final String buttonText;
  final Function() buttonFunction;
  final bool deactivateButton;

  const CarouselOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonFunction,
    this.deactivateButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(
          title,
        ),
        Text(description),
        ElevatedButton(
          onPressed: deactivateButton ? null : buttonFunction,
          child: Text(buttonText),
        ),
      ],
    );
  }
}