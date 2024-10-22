import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/modals.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/presenter/index.dart';
import 'package:app_piloto/src/modules/home/presenter/screens/widgets/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // ====================================================== //
  late String nameUser;
  late String userId;
  late String phone;
  late String email;

  CarouselSliderController? carouselController = CarouselSliderController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  // TODO Update Data
  updateData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('crud').doc(nameUser);

    Map<String, dynamic> students = ({"nameUser": nameUser, "userId": userId, "phone": phone, "email": email});

    // update data to Firebase
    documentReference.update(students).whenComplete(() => print('$nameUser updated'));
  }

  // TODO Delete Data
  deleteData() {
    //DocumentReference documentReference = FirebaseFirestore.instance.collection('crud').doc(nameUser);

    // delete data from Firebase
  }
  // ====================================================== //

  @override
  void initState() {
    super.initState();
    contactCubit.getContactList();
  }

  List<ContactModel>? contactModel = [];
  ContactListCubit contactCubit = I.getDependency<ContactListCubit>();

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
              color: AppPilotoColors().primary(),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 5),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(height: MediaQuery.sizeOf(context).height * 0.32),
                        items: carouselOptions(context).map((option) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width,
                                margin: const EdgeInsets.all(8),
                                height: MediaQuery.sizeOf(context).height,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppPilotoColors().white(),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        option.icon,
                                        Container(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Text(
                                            option.title,
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppPilotoColors().black(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          option.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppPilotoColors().black(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Flexible(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: option.buttonText.toUpperCase() == 'FAVORITAR' ? AppPilotoColors().gray() : AppPilotoColors().primary(),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                                bottomLeft: Radius.circular(40.0),
                                                bottomRight: Radius.circular(40.0),
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: !option.deactivateButton ? option.buttonFunction : null,
                                              child: Text(
                                                option.buttonText,
                                                style: GoogleFonts.comfortaa(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppPilotoColors().white(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppPilotoColors().primary(),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Últimos Contatos Adicionados',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppPilotoColors().white(),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: contactModel!.length,
                                    controller: ScrollController(),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(left: 10.0, top: 5, right: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              contactModel![index].nameUser,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.comfortaa(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppPilotoColors().white(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0, top: 5, right: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                contactModel![index].phone,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.comfortaa(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: AppPilotoColors().white(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        leading: const CircleAvatar(
                                          radius: 16.0,
                                          backgroundImage: AssetImage('images/user.png'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
