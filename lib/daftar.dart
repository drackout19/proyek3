import 'package:flutter/material.dart';
import 'dart:math';

import 'package:proyek/login.dart';
import 'package:proyek/home.dart';

// class daftar extends StatelessWidget {
//   const daftar({
//     super.key,
//   });
// }

class daftar extends StatefulWidget {
  const daftar({Key? key}) : super(key: key);

  @override
  State<daftar> createState() => _daftarState();
}

class _daftarState extends State<daftar> {
  bool isHidden = true;
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 127, 133),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Center(child: Text("DAFTAR", 
            style: TextStyle(
              color: Colors.white, fontSize: 30),
              ),
            ),
            SizedBox(height: 35),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "Nama",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "E-Mail",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "Telepon",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "Alamat",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              obscureText: _obsecureText,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    }, icon: Icon(
                      _obsecureText ? Icons.visibility_off : Icons.visibility,
                      ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              obscureText: _obsecureText,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    }, icon: Icon(
                      _obsecureText ? Icons.visibility_off : Icons.visibility,
                      ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: 
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "Confirm Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
                ElevatedButton(onPressed: () {Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HalamanUtama(),
                    ),
                  );}, 
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
            SizedBox(height: 15),
            Center(
              child: Text("Sudah punya akun?", 
                style: TextStyle(
                  color: Colors.black),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => login(),
                    ),
                  );
              }, 
                  child: Text("Login",
                    style: TextStyle(color: Colors.white),
                    ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.grey.withOpacity(0),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
