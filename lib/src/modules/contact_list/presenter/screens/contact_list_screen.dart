import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/presenter/index.dart';
import 'package:app_piloto/src/modules/favorites/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  ContactListCubit contactCubit = I.getDependency<ContactListCubit>();
  FavoritesCubit favoritesCubit = I.getDependency<FavoritesCubit>();

  @override
  void initState() {
    super.initState();
    contactCubit.getContactList();
    listOfPossibleFavorites = favoritesCubit.readFavorite();
  }

  List<ContactModel>? contactModel = [];
  List<ContactModel?>? listOfPossibleFavorites = [];
  bool withIconFavorite = false;

  bool isInFavorites(ContactModel? contactModel) {
    try {
      listOfPossibleFavorites!.firstWhere((e) => e?.phone == contactModel?.phone);
      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListCubit, ContactListState>(
      listener: (context, state) {
        if (state is ContactListErrorState) {
        } else if (state is ContactListSuccessState) {
          contactModel = state.contactModelList;
        } else if (state is DeleteContactSuccessState) {
          AppPilotoModal().showSuccessModal(context, 'Contato deletado com sucesso!');
        }
      },
      bloc: contactCubit,
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
                            title: Container(
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
                            trailing: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                withIconFavorite = isInFavorites(contactModel![index]);
                                AppPilotoModal().showContact(context: context, dismissible: true, contactModel: contactModel![index], withIconFavorite: withIconFavorite);
                              },
                              icon: Icon(Icons.arrow_forward_ios_outlined, color: AppPilotoColors().purple()),
                            ),
                            subtitle: Column(
                              children: [
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
            ],
          ),
        );
      },
    );
  }
}
