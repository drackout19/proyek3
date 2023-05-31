import 'package:flutter/material.dart';
import 'dart:math';

import './login.dart';
import './HalamanUtama.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'init.dart' as urlHttp;

// class daftar extends StatelessWidget {
//   const daftar({
//     super.key,
//   });
// }

class daftar extends StatelessWidget {
  const daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: daftarPage(),
    );
  }
}

class daftarPage extends StatefulWidget {
  const daftarPage({Key? key}) : super(key: key);

  @override
  State<daftarPage> createState() => _daftarPageState();
}

class _daftarPageState extends State<daftarPage> {
  bool isHidden = true;
  bool _obsecureText = true;
  late dynamic idAkun;

  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kontak = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController umur = TextEditingController();

  Future<void> getIdAkun(String kontak) async {
    String uri = "${urlHttp.urlHTTP.uri}get_id_akun.php?kontak=${kontak}";
    var res = await http.get(Uri.parse(uri));
    var response = jsonDecode(res.body);
    String id_akun = response[0]['id_akun'];
    await SessionManager().set('kontak', kontak);
    await SessionManager().set('id_akun', id_akun);
    //print(response[0]['id_akun']);
    // print("isi responnya => ${response}");
  }

  Future<void> insertrecord() async {
    if (nama.text != "" || alamat.text != "") {
      try {
        String uri = "${urlHttp.urlHTTP.uri}insert_data_buruh.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nama": nama.text,
          "alamat": alamat.text,
          "kontak": kontak.text,
          "jenisKelamin": jenisKelamin.text,
          "umur": umur.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Insert Success");

          await SessionManager().set('kontak', kontak.text);
          await getIdAkun(kontak.text);

          nama.text = "";
          alamat.text = "";
          kontak.text = "";
          jenisKelamin.text = "";
          umur.text = "";

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HalamanUtama(),
            ),
          );
        } else {
          print("Some Issue");
        }
      } catch (e) {
        print(e);

        //snackbar
        final snackBar = SnackBar(
          content: const Text(
            'Gagal mengajukan data, pastikan isikan kontak sesuai dengan akun anda',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        print(
            "Gagal mengajukan data, pastikan isikan kontak sesuai dengan akun anda");
      }
    } else {
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 48, 127, 133),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              "Isikan Data Diri Anda Untuk Menjadi Buruh Tani",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          SizedBox(height: 35),
          formDaftar(
            label: "Nama",
            controller: nama,
          ),
          SizedBox(height: 20),
          formDaftar(
            label: "Alamat",
            controller: alamat,
          ),
          SizedBox(height: 20),
          formDaftar(
            label: "Kontak / telepon",
            controller: kontak,
          ),
          SizedBox(height: 20),
          formDaftar(
            label: "Jenis kelamin",
            controller: jenisKelamin,
          ),
          SizedBox(height: 20),
          formDaftar(
            label: "Umur",
            controller: umur,
          ),
          SizedBox(height: 20),
          //button daftar
          ElevatedButton(
            onPressed: () {
              insertrecord();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => HalamanUtama(),
              //   ),
              // );
            },
            child: Text(
              "Ajukan",
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
          // Center(
          //   child: Text(
          //     "Sudah punya akun?",
          //     style: TextStyle(color: Colors.black),
          //   ),
          // ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HalamanUtama(),
                ),
              );
            },
            child: Text(
              "Lewati",
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
