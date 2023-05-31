import 'package:flutter/material.dart';
import 'HalamanUtama.dart';
import 'widgets/CustomBottomNavigationBar.dart';
import './detail_event.dart';

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
        backgroundColor: Color(0xff2A3C44),
        appBar: AppBar(
          title: Text("Halaman Event"),
          backgroundColor: Color(0xff46838A),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            String date;
            String text;
            switch (index) {
              case 1:
                date = '26 Maret 2023';
                text = 'Rapat Petani di Lembang';
                break;
              case 2:
                date = '10 Maret 2023';
                text = 'Pembukaan Staff Petani Baru di Baletani';
                break;
              case 3:
                date = '1 Mei 2023';
                text = 'Hari Buruh Sedunia';
                break;
              default:
                date = '23 Maret 2032';
                text = 'Pelatihan Petani Progresif kota Bandung';
                break;
            }

            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(17.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(text),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff46838A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailEvent(),
                  ));
                  },
                  child: Text('Detail'),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(indexBottom: indexBottom),
      ),
    );
  }
}
