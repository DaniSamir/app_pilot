import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/app_piloto_loading.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/presenter/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/home_screen.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactListCubit _contactCubit = I.getDependency<ContactListCubit>();

  @override
  void initState() {
    _contactCubit.getContactList();
    super.initState();
  }

  List<ContactModel>? contactModel = [];
  List<ContactModel?>? listOfPossibleFavorites = [];
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListCubit, ContactListState>(
      listener: (context, state) {
        if (state is ContactListErrorState) {
          _contactCubit.resetState();
          AppPilotoModal().showErrorModal(context, 'Ops! Houve um erro ao obter a lista! Por favor, tente mais tarde!');
        } else if (state is ContactListSuccessState && state.contactModelList != null) {
          _contactCubit.resetState();
          contactModel = state.contactModelList;
        } else if (state is DeleteContactSuccessState) {
          _contactCubit.resetState();
          AppPilotoModal().showSuccessModal(context, 'Contato deletado com sucesso!');
        }
      },
      bloc: _contactCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            title: Text(
              'Todos os contatos',
              style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppPilotoColors().white(),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppPilotoColors().white(),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: AppPilotoColors().white(),
                        ),
                        itemCount: contactModel!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: AppPilotoColors().gray()),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Nome: ${contactModel![index].nameUser}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppPilotoColors().purple(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Tel.: ${contactModel![index].phone}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppPilotoColors().purple(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Email: ${contactModel![index].email}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppPilotoColors().purple(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 2),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 32,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => UpdateContactScreen(
                                              contactModel: contactModel![index],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit, color: AppPilotoColors().purple()),
                                    ),
                                    const SizedBox(height: 2),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 32,
                                      onPressed: () {
                                        _contactCubit.deleteContact(contactModel![index].userId!);
                                      },
                                      icon: Icon(Icons.delete, color: AppPilotoColors().purple()),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            leading: const CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage('images/user.png'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              state is ContactListLoadingState || state is UpdateContactLoadingState ? const AppPilotoLoading() : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
