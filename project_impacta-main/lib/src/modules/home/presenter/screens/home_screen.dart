import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/src/modules/contact_list/presenter/screens/contact_list_screen.dart';
import 'package:app_piloto/src/modules/create_contact/presenter/screens/create_contact_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  FirebaseFirestore db = FirebaseFirestore.instance;


  // TODO Read Data
  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(nameUser);

    documentReference.get().then((dataSnapshot) {});
  }

  // TODO Update Data
  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(nameUser);

    Map<String, dynamic> students = ({
      "nameUser": nameUser,
      "userId": userId,
      "phone": phone,
      "email": email
    });

    // update data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('$nameUser updated'));
  }

  // TODO Delete Data
  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('crud').doc(nameUser);

    // delete data from Firebase
    documentReference.delete().whenComplete(() => print('$nameUser deleted'));
  }
  // ====================================================== //

  Stream<dynamic>? list() {
    final userRef = db.collection('crud').snapshots();

    //  final result = userRef.collection('crud').snapshots();

    // return result;
    // QuerySnapshot query = await db.collection('crud').get();

    //FirebaseFirestore.instance.collection('crud').snapshots(),
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppPilotoColors().white(),
          appBar: CustomAppBar(
            withCircle: true,
            title: Text(
              'App Piloto',
              style: GoogleFonts.comfortaa(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppPilotoColors().white()),
            ),
            leading: const Icon(Icons.menu),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Meus Atalhos',
                      style: GoogleFonts.comfortaa(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: AppPilotoColors().primary(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: AppPilotoColors().primary(),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: AppPilotoColors().white(),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CreateUser()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Adicionar Contato',
                              style: GoogleFonts.comfortaa(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppPilotoColors().primary(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: AppPilotoColors().primary(),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: AppPilotoColors().white(),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CreateUser()),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Favoritos',
                              style: GoogleFonts.comfortaa(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppPilotoColors().primary(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppPilotoColors().primary(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactList()),
                        ),
                        child: Text('Ver todos os Contatos',
                            style: GoogleFonts.comfortaa(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppPilotoColors().white(),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 25, right: 0),
                            child: Row(
                              children: [],
                            ),
                          ),
                          StreamBuilder(
                            stream:
                                //db.collection('crud').snapshots(),
                                //  db.collection('crud').snapshots(),
                                FirebaseFirestore.instance
                                    .collection('crud')
                                    .snapshots(),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 3,
                                      controller: ScrollController(),
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot documentSnapshot =
                                            snapshot.data!.docs[index];

                                        return ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 5, right: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                documentSnapshot["nameUser"],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.comfortaa(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppPilotoColors().white(),
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
                                                  documentSnapshot["phone"],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.comfortaa(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppPilotoColors()
                                                        .white(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          leading: const CircleAvatar(
                                            radius: 16.0,
                                            backgroundImage:
                                                AssetImage('images/user.png'),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: CircularProgressIndicator(
                                    backgroundColor: AppPilotoColors().black(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
