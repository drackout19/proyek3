import 'package:flutter/material.dart';
import 'HalamanUtama.dart';

void main() {
  runApp(Event());
}

class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventBody(),
    );
  }
}

class EventBody extends StatefulWidget {
  const EventBody({super.key});

  @override
  State<EventBody> createState() => _EventBodyState();
}

class _EventBodyState extends State<EventBody> {
  late int index;
  late int indexBottom;

  final List<Widget> showWidget = <Widget>[
    HalamanUtama(),
    Event(),
  ];

  @override
  void initState() {
    indexBottom = 1;
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Halaman Event"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffF2F2F2),
          selectedItemColor: Color(0xff61A861),
          unselectedItemColor: Color(0xffC8C8C8),
          currentIndex: indexBottom,
          onTap: (value) {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => showWidget[value],
              ));
              indexBottom = value;
              print(indexBottom);
            });
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
        ),
      ),
    );
  }
}
