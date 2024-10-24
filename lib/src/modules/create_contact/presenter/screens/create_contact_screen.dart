import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/app_piloto_loading.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/text_field_custom.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  CreateContactCubit contactCubit = I.getDependency<CreateContactCubit>();
  final incrementId = ValueNotifier<int>(0);
  TextEditingController nameUserController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool checkAllFieldsFilled() {
    return emailController.text.isNotEmpty && phoneController.text.isNotEmpty && emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateContactCubit, CreateContactState>(
      listener: (context, state) {
        if (state is CreateContactErrorState) {
          AppPilotoModal().showErrorModal(context, 'Ops! Ocorreu um erro. Tente mais tarde!');
        } else if (state is CreateContactSuccessState) {
          AppPilotoModal().showSuccessModal(context, 'Contato criado com sucesso!');
        }
      },
      bloc: contactCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            title: Text(
              'Criar contato',
              style: GoogleFonts.comfortaa(fontSize: 26, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
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
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: AssetImage('images/user.png'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 275,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppPilotoColors().purple(),
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                        child: CreateContactForm(
                          nameUserController: nameUserController,
                          phoneController: phoneController,
                          emailController: emailController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  elevation: 8,
                                  backgroundColor: AppPilotoColors().purple(),
                                  shape: raisedButtonBorder(),
                                ),
                                onPressed: () {
                                  if (checkAllFieldsFilled()) {
                                    final newId = incrementId.value + 1;
                                    newId.toString();
                                    ContactModel contactModel = ContactModel(
                                      nameUser: nameUserController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                    );
                                    contactCubit.createUser(contactModel);
                                  } else {
                                    AppPilotoModal().showErrorModal(context, 'Ops! Parece que há campos que não foram preenchidos!');
                                  }
                                },
                                child: Text(
                                  'Enviar',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 20,
                                    color: AppPilotoColors().white(),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              state is CreateContactLoadingState ? const AppPilotoLoading() : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
