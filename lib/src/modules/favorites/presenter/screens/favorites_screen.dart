import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/home_screen.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ContactListCubit _contactCubit = I.getDependency<ContactListCubit>();
  final UpdateContactCubit _updateContactCubit = I.getDependency<UpdateContactCubit>();

  List<ContactModel>? contactModel = [];

  @override
  void initState() {
    _contactCubit.getContactList();
    super.initState();
  }

  void showContactWithoutFavoriteSuccess() {
    AppPilotoModal().showGenericModal(
      context,
      'Alteração realizada! \n Para favoritar novamente vá até Lista de Contatos.',
      () => Navigator.of(context).pop(context),
      Icon(Icons.heart_broken, color: AppPilotoColors().purple(), size: 48),
      false,
      'Ok',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListCubit, ContactListState>(
      listener: (context, state) {
        _contactCubit.resetState();
        if (state is ContactListErrorState) {
          _contactCubit.resetState();
          AppPilotoModal().showErrorModal(context, 'Ops! Houve um erro ao obter a lista! Por favor, tente mais tarde!');
        } else if (state is ContactListSuccessState && state.contactModelList != null) {
          _contactCubit.resetState();
          contactModel = state.contactModelList?.where((element) => element.isFavorite! == true).toList();
        }
      },
      bloc: _contactCubit,
      builder: (context, state) {
        return BlocConsumer<UpdateContactCubit, UpdateContactState>(
            listener: (context, state) {
              _updateContactCubit.resetState();
              if (state is UpdateContactErrorState) {
                _updateContactCubit.resetState();
                AppPilotoModal().showErrorModal(context, 'Ops! Houve um erro ao obter a lista! Por favor, tente mais tarde!');
              } else if (state is UpdateContactSuccessState) {
                _updateContactCubit.resetState();
                showContactWithoutFavoriteSuccess();
              }
            },
            bloc: _updateContactCubit,
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppPilotoColors().white(),
                appBar: CustomAppBar(
                  title: Text(
                    'Favoritos',
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
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    contactModel!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  iconSize: 32,
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    AppPilotoModal().showConfirmModal(
                                                        context, 'Poxa, esperamos que esteja tudo bem!\n Gostaria de excluir este contato dos favoritos? ', () async {
                                                      Navigator.of(context).pop(context);
                                                      ContactModel contactModelUpdate = ContactModel(
                                                          nameUser: contactModel![index].nameUser,
                                                          phone: contactModel![index].phone,
                                                          email: contactModel![index].email,
                                                          userId: contactModel![index].userId,
                                                          isFavorite: false);

                                                      await _updateContactCubit.updateContact(contactModelUpdate);
                                                    }, Icon(Icons.sentiment_dissatisfied, color: AppPilotoColors().purple(), size: 48));
                                                  },
                                                  icon: Icon(Icons.heart_broken, color: AppPilotoColors().purple()),
                                                ),
                                              ],
                                            )
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
                            ))
                        : Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.sentiment_very_satisfied_sharp,
                                  color: AppPilotoColors().purple(),
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Nadinha por aqui!\nSeus contatos favoritos aparecerão aqui assim que você adicioná-los!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppPilotoColors().purple(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              );
            });
      },
    );
  }
}
