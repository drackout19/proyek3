import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:math';

import './login.dart';
import './HalamanUtama.dart';
import './daftar.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'init.dart' as urlHttp;

// class daftar extends StatelessWidget {
//   const daftar({
//     super.key,
//   });
// }

class daftarAkun extends StatefulWidget {
  const daftarAkun({Key? key}) : super(key: key);

  @override
  State<daftarAkun> createState() => _daftarAkunState();
}

class _daftarAkunState extends State<daftarAkun> {
  bool isHidden = true;
  bool _obsecureText = true;

  TextEditingController kontak = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> insertrecord() async {
    if (kontak.text != "" || password.text != "") {
      try {
        String uri = "${urlHttp.urlHTTP.uri}insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "kontak": kontak.text,
          "password": confirmPassword.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print(response);
          int id_akun = int.parse(response["id_akun"]);
          await SessionManager().set("id_akun", id_akun);
          await SessionManager().set("kontak", kontak.text);
          await SessionManager().set("visited_ktp", false);

          print("Record Insert Success");
          kontak.text = "";
          confirmPassword.text = "";
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => daftar(),
            ),
          );
        } else {
          print("Some Issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 127, 133),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "DAFTAR",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            SizedBox(height: 35),
            formDaftar(
              label: "Kontak / Telepon",
              controller: kontak,
            ),
            SizedBox(height: 20),
            TextField(
              controller: password,
              autocorrect: false,
              obscureText: _obsecureText,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  icon: Icon(
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

            //confirm password
            SizedBox(height: 20),
            TextField(
              controller: confirmPassword,
              autocorrect: false,
              obscureText: _obsecureText,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  icon: Icon(
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

            //button daftar
            ElevatedButton(
              onPressed: () {
                if (password.text != confirmPassword.text) {
                  print("konfirmasi password tidak sesuai");
                } else {
                  // print(kontak.text);
                  // print(password.text);
                  insertrecord();
                }
                // jika berhasil arahkan ke page selanjutnya
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => daftar(),
                //   ),
                // );
              },
              child: Text(
                "Daftar",
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
              child: Text(
                "Sudah punya akun?",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text(
                "Masuk",
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

//extract widget untuk tiap form field daftar nya
class formDaftar extends StatelessWidget {
  formDaftar({required this.label, required this.controller});

  late String label;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
