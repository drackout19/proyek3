import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 127, 133),
        body: Center(
          child: Column(
                    children: [
                      SizedBox(height: 150,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), 
                        width: 450,
                        height: 150,
                        decoration: BoxDecoration(
                        image: DecorationImage(image: 
                          AssetImage("assets/baletani.jpeg"),
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                    ElevatedButton(onPressed: () {}, 
                      child: Text("LOGIN", 
                        style: TextStyle(color: Colors.white),
                        ),
                      style: ElevatedButton.styleFrom(
                      primary: Colors.blue.withOpacity(0),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                  SizedBox(height: 20),
                    ElevatedButton(onPressed: () {}, 
                      child: Text("DAFTAR", 
                        style: TextStyle(color: Colors.black),
                        ),
                      style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ],
          ),
        ),
      ),
    );
  }
}