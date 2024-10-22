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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: deactivateButton ? null : buttonFunction,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
