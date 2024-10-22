import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppPilotoLoading extends StatelessWidget {
  const AppPilotoLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: AppPilotoColors().orange(),
          rightDotColor: AppPilotoColors().orange(),
          size: 30,
        ),
      ),
    );
  }
}
