import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/favorites/presenter/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel>? contactModel = [];
  FavoritesCubit contactCubit = I.getDependency<FavoritesCubit>();

  @override
  void initState() {
    super.initState();
    contactModel = contactCubit.readFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {},
      bloc: contactCubit,
      child: Scaffold(
        backgroundColor: AppPilotoColors().white(),
        appBar: CustomAppBar(
          withCircle: true,
          title: Text(
            'App Piloto',
            style: GoogleFonts.comfortaa(fontSize: 24, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
          ),
          leading: Icon(
            Icons.menu,
            color: AppPilotoColors().purple(),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CarouselWidget(),
                    const SizedBox(height: 20),
                    Container(
                      height: 284,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppPilotoColors().purple(),
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Contatos favoritos',
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: AppPilotoColors().white(),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              contactModel!.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: contactModel!.length,
                                      controller: ScrollController(),
                                      itemBuilder: (context, index) {
                                        return ListTileContact(
                                          nameUser: contactModel![index].nameUser,
                                          phone: contactModel![index].phone,
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 24),
                                          Icon(
                                            Icons.sentiment_very_satisfied_sharp,
                                            color: AppPilotoColors().white(),
                                            size: 48,
                                          ),
                                          const SizedBox(height: 16),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Seus contatos favoritos aparecerão aqui assim que você adicioná-los!',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.comfortaa(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: AppPilotoColors().white(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(height: 16)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
