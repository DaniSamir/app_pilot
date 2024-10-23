import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/widgets/carousel_home/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  CarouselSliderController? carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(height: MediaQuery.sizeOf(context).height * 0.32),
      items: carouselOptions(context).map((option) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.all(8),
              height: MediaQuery.sizeOf(context).height,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppPilotoColors().white(),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      option.icon,
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          option.title,
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppPilotoColors().black(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        option.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppPilotoColors().black(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 16,
                        decoration: BoxDecoration(
                          color: option.buttonText.toUpperCase() == 'FAVORITAR' ? AppPilotoColors().gray() : AppPilotoColors().purple(),
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                        child: TextButton(
                          onPressed: !option.deactivateButton ? option.buttonFunction : null,
                          child: Text(
                            option.buttonText,
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppPilotoColors().white(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
