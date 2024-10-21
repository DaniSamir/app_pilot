import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/presenter/index.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  ContactListCubit contactCubit = I.getDependency<ContactListCubit>();

  @override
  void initState() {
    super.initState();
    contactCubit.getContactList();
  }

  List<ContactModel>? contactModel = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListCubit, ContactListState>(
      listener: (context, state) {
        if (state is ContactListErrorState) {
        } else if (state is ContactListSuccessState) {
          contactModel = state.contactModelList;
        }
      },
      bloc: contactCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            title: Text(
              'Todos os Contatos',
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
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactModel?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 10, right: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              contactModel![index].nameUser,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: AppPilotoColors().primary(),
                              ),
                            ),
                          ),
                        ),
                        subtitle: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 5, right: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                contactModel![index].phone,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: AppPilotoColors().primary(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        leading: const CircleAvatar(
                          radius: 20.0,
                          backgroundImage: AssetImage('images/user.png'),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashBoardScreen()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
