import 'package:flutter/material.dart';
import 'HalamanUtama.dart';
import 'widgets/CustomBottomNavigationBar.dart';

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
        bottomNavigationBar:
            CustomBottomNavigationBar(indexBottom: indexBottom),
      ),
    );
  }
}
