import 'package:flutter/material.dart';
import './login.dart';
import './edit_profile.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: content(),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Ini halaman home");
  }
}

class content extends StatefulWidget {
  const content({Key? key}) : super(key: key);

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  late int index;

  final List<Widget> showWidget = <Widget>[
    PageHome(),
    Text("test"),
    Text("test"),
    edit_profile(),
  ];

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: showWidget[index], 

        //bottom navigation
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            print(value);
            print("TEST");
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.event_available_outlined), label: "Event"),
        BottomNavigationBarItem(icon: Icon(Icons.notification_add_outlined), label: "Notifikasi"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
        ]
      ),
      );
      }
      }