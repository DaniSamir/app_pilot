import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/app_piloto_loading.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
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
  ContactListCubit contactCubit = I.getDependency<ContactListCubit>();

  @override
  void initState() {
    super.initState();
    contactCubit.getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListCubit, ContactListState>(
      listener: (context, state) {
        if (state is ContactListErrorState) {
          AppPilotoModal().showErrorModal(context, 'Ops! Ocorreu um erro. Tente novamente mais tarde!');
        } else if (state is ContactListSuccessState) {
          contactModel = state.contactModelList?.reversed.toList();
        }
      },
      bloc: contactCubit,
      builder: (context, state) {
        return Scaffold(
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
                              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Últimos contatos adicionados',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppPilotoColors().white(),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: contactModel == null
                                      ? 0
                                      : contactModel!.length > 3
                                          ? 3
                                          : contactModel!.length,
                                  controller: ScrollController(),
                                  itemBuilder: (context, index) {
                                    return ListTileContact(
                                      nameUser: contactModel![index].nameUser,
                                      phone: contactModel![index].phone,
                                    );
                                  },
                                ),
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
              state is ContactListLoadingState ? const AppPilotoLoading() : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
