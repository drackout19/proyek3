import 'package:flutter/material.dart';
import '../DetailList.dart';
import '../HalamanEvent.dart';
import '../pageGabungMitra.dart';
import '../HalamanUtama.dart';
import '../edit_profile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  // const CustomBottomNavigationBar({super.key});
  CustomBottomNavigationBar({required this.indexBottom});

  late int indexBottom;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  final List<Widget> showWidget = <Widget>[
    HalamanUtama(),
    Event(),
    PageGabungMitra(),
    edit_profile()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xffF2F2F2),
      selectedItemColor: Color(0xff61A861),
      unselectedItemColor: Color(0xffC8C8C8),
      currentIndex: widget.indexBottom,
      onTap: (value) {
        // setState(() {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => showWidget[value],
        ));
        widget.indexBottom = value;
        print(widget.indexBottom);
        // });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: "Event",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_membership),
          label: "Member",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profil",
        ),
      ],
    );
  }
}
