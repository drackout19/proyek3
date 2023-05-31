import 'package:flutter/material.dart';
import 'widgets/CustomBottomNavigationBar.dart';

class DetailEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2A3C44),
        title: Text("BaleTani"),
      ),
      body: Container(
        color: Color(0xffC8C8C8),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Header",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Kembali"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(indexBottom: 1)
    );
  }
}
