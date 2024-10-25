import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/widgets/index.dart';
import 'package:flutter/material.dart';

List<CarouselOption> carouselOptions(BuildContext context) {
  return [
    CarouselOption(
      icon: Icon(
        Icons.group_add_sharp,
        color: AppPilotoColors().purple(),
        size: 32,
      ),
      title: 'Adicionar contatos',
      description: "Adicione contatos para não esquecer.",
      buttonText: 'Adicionar',
      buttonFunction: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateUserScreen()),
        );
      },
    ),
    CarouselOption(
      icon: Icon(
        Icons.list,
        color: AppPilotoColors().purple(),
        size: 32,
      ),
      title: 'Lista de Contatos',
      description: "Veja todos os seus contatos.",
      buttonText: 'Ver',
      buttonFunction: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ContactList()),
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
      description: "Em breve você terá acesso a sua lista de favoritos.",
      buttonText: 'Favoritar',
      buttonFunction: () {
        //TODO: feature Favorites
      },
    ),
  ];
}
