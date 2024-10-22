// ignore_for_file: prefer_const_constructors

import 'package:app_piloto/core/components/styles/app_piloto_colors.dart';
import 'package:app_piloto/src/modules/home/presenter/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;

  @override
  final Size preferredSize;

  TopBar({
    super.key,
    required this.title,
    required this.child,
    required this.onPressed,
  }) : preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: 'topBarBtn',
                child: Card(
                  elevation: 10,
                  shape: kBackButtonShape,
                  child: MaterialButton(
                    height: 20,
                    minWidth: 50,
                    elevation: 10,
                    shape: kBackButtonShape,
                    onPressed: () {
                      MaterialPageRoute(builder: (context) => DashBoardScreen());
                    },
                    child: child,
                  ),
                ),
              ),
              Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      MaterialPageRoute(builder: (context) => DashBoardScreen());
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  color: AppPilotoColors().black(),
);

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;
  bool? withCircle;

  CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 2.0,
    this.withCircle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Wrap(
        children: [
          Container(
            color: AppPilotoColors().primary(),
            child: AppBar(
              centerTitle: true,
              leading: leading,
              title: Padding(padding: EdgeInsets.only(top: 10), child: title),
              backgroundColor: AppPilotoColors().primary(),
              actions: actions,
            ),
          ),
          SizedBox.fromSize(
            size: preferredSize,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return ClipRect(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    height: 20,
                    width: double.infinity,
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppPilotoColors().primary(),
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(40.0),
                              bottomRight: const Radius.circular(40.0),
                            )),
                        child: withCircle!
                            ? Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(70, 10, 20, 0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: AssetImage('images/user.png'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            'Usuário Teste',
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              color: AppPilotoColors().white(),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : SizedBox.shrink()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => withCircle! ? Size.fromHeight(60.0) : Size.fromHeight(25.0);
}
