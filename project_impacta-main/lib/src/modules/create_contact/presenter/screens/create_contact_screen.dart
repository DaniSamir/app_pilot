import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/app_piloto_loading.dart';
import 'package:app_piloto/core/components/widgets/input_formatter.dart';
import 'package:app_piloto/core/components/widgets/text_field_custom.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  CreateContactCubit contactCubit = I.getDependency<CreateContactCubit>();

  TextEditingController? nameUserController = TextEditingController();
  TextEditingController? userIdController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateContactCubit, CreateContactState>(
      listener: (context, state) {
        if (state is CreateContactErrorState) {
          CreateContactModal().createContactSuccessModal(context);
        } else if (state is CreateContactSuccessState) {
          CreateContactModal().createContactSuccessModal(context);
        }
      },
      bloc: contactCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            title: Text(
              'Criar Contato',
              style: GoogleFonts.comfortaa(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppPilotoColors().white()),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()),
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage('images/user.png'),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppPilotoColors().primary(),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            )),
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            CreateContactFormField(
                              controller: nameUserController,
                              text: 'Nome',
                              icon: Icons.account_circle_outlined,
                              listTextInputFormatter: [
                                LengthLimitingTextInputFormatter(20)
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            CreateContactFormField(
                              controller: userIdController,
                              text: 'Id',
                              icon: Icons.perm_identity_outlined,
                              listTextInputFormatter: [
                                phoneTextFormatter,
                                LengthLimitingTextInputFormatter(20)
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            CreateContactFormField(
                              controller: phoneController,
                              text: 'Telefone',
                              icon: Icons.email,
                              listTextInputFormatter: [
                                phoneTextFormatter,
                                LengthLimitingTextInputFormatter(20)
                              ],
                              keyboardType: TextInputType.datetime,
                            ),
                            const SizedBox(height: 10.0),
                            CreateContactFormField(
                              controller: emailController,
                              text: 'E-mail',
                              icon: Icons.email,
                              listTextInputFormatter: [
                                LengthLimitingTextInputFormatter(20)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 45),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  elevation: 8.0,
                                  backgroundColor: AppPilotoColors().primary(),
                                  shape: raisedButtonBorder(),
                                ),
                                onPressed: () {
                                  ContactModel contactModel = ContactModel(
                                      nameUser: nameUserController!.text,
                                      userId: userIdController!.text,
                                      phone: phoneController!.text,
                                      email: emailController!.text);
                                  contactCubit.createUser(contactModel);
                                },
                                child: Text(
                                  'Enviar',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 20,
                                    color: AppPilotoColors().white(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              state is CreateContactLoadingState
                  ? const AppPilotoLoading()
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
