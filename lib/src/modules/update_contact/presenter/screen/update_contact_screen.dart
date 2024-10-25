import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/app_piloto_loading.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/text_field_custom.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateContactScreen extends StatefulWidget {
  final ContactModel? contactModel;
  const UpdateContactScreen({required this.contactModel, super.key});

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final UpdateContactCubit _updateContactCubit = I.getDependency<UpdateContactCubit>();
  final incrementId = ValueNotifier<int>(0);
  TextEditingController nameUserController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool readOnly = true;
  @override
  void initState() {
    super.initState();
    popularTextcontroller();
  }

  void popularTextcontroller() {
    nameUserController.text = widget.contactModel!.nameUser;
    phoneController.text = widget.contactModel!.phone;
    emailController.text = widget.contactModel!.email;
  }

  bool checkAllFieldsFilled() {
    return emailController.text.isNotEmpty && phoneController.text.isNotEmpty && emailController.text.isNotEmpty;
  }

  void showSuccessUpdate() {
    AppPilotoModal().showGenericModal(context, 'Contato editado com sucesso!', () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen())),
        Icon(Icons.sentiment_very_satisfied_sharp, color: AppPilotoColors().green(), size: 48), false, 'Ok');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateContactCubit, UpdateContactState>(
      listener: (context, state) {
        if (state is UpdateContactErrorState) {
          AppPilotoModal().showErrorModal(context, 'Ops! Ocorreu um erro. Tente mais tarde!');
        } else if (state is UpdateContactSuccessState) {
          _updateContactCubit.resetState();
          showSuccessUpdate();
        }
      },
      bloc: _updateContactCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            title: Text(
              'Editar contato',
              style: GoogleFonts.comfortaa(fontSize: 26, fontWeight: FontWeight.w700, color: AppPilotoColors().white()),
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
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppPilotoColors().purple(),
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                        child: CreateContactForm(
                          nameUserController: nameUserController,
                          phoneController: phoneController,
                          emailController: emailController,
                          readOnly: readOnly,
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
                                  backgroundColor: readOnly ? AppPilotoColors().gray() : AppPilotoColors().purple(),
                                  shape: raisedButtonBorder(),
                                ),
                                onPressed: () async {
                                  if (checkAllFieldsFilled()) {
                                    final newId = incrementId.value + 1;
                                    newId.toString();
                                    ContactModel contactModelUpdate = ContactModel(
                                        nameUser: nameUserController.text, phone: phoneController.text, email: emailController.text, userId: widget.contactModel!.userId);
                                    await _updateContactCubit.updateContact(contactModelUpdate);
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
                          IconButton(
                            onPressed: () {
                              setState(() {
                                readOnly = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppPilotoColors().purple(),
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
