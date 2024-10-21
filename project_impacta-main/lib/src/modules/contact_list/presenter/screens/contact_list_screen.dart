import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/core/components/widgets/top_bar.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
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
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            children: [
              StreamBuilder(
                stream:
                    //db.collection('crud').snapshots(),
                    //  db.collection('crud').snapshots(),
                    FirebaseFirestore.instance.collection('crud').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];

                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10, right: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    documentSnapshot["nameUser"],
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
                                      documentSnapshot["phone"],
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
    );
  }
}
