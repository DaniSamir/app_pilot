import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/widgets/caroussel_option.dart';
import 'package:flutter/material.dart';

List<CarouselOption> carouselOptions(BuildContext context) {
  return [
    CarouselOption(
      icon: Icon(
        Icons.add_circle_rounded,
        color: AppPilotoColors().primary(),
        size: 32,
      ),
      title: 'Adicionar Contatos',
      description: "Adicione contatos para não esquecer",
      buttonText: 'Adicionar',
      buttonFunction: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateUser()),
        );
      },
    ),
    CarouselOption(
      icon: Icon(
        Icons.favorite,
        color: AppPilotoColors().gray(),
        size: 32,
      ),
      title: 'Favoritos',
      description: "Adicione seus contatos mais\n próximos.",
      buttonText: 'Favoritar',
      buttonFunction: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateUser()),
        );
      },
    ),
    CarouselOption(
      icon: Icon(
        Icons.list,
        color: AppPilotoColors().primary(),
        size: 32,
      ),
      title: 'Lista de Contatos',
      description: "Veja todos os seus contatos.",
      buttonText: 'Ver',
      buttonFunction: () {
        ///TODO: feature Favorites
      },
    ),
  ];
}
