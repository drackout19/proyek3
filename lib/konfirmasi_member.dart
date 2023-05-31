//import pages
import 'package:bale_tani2/home.dart';

import './form_isi_ktp.dart';
import './PageMember.dart';
import 'init.dart' as urlHttp;

//import packages bawaan flutter
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './login.dart';
import './widgets/CustomBottomNavigationBar.dart';

void main() {
  runApp(KonfirmasiMember());
}

class KonfirmasiMember extends StatelessWidget {
  const KonfirmasiMember({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KonfirmasiPage(),
    );
  }
}

class KonfirmasiPage extends StatefulWidget {
  @override
  State<KonfirmasiPage> createState() => _KonfirmasiPageState();
}

class _KonfirmasiPageState extends State<KonfirmasiPage> {
  List status = [];
  String? isKonfirmasi;

  dynamic? visit;

  Future<void> statusKonfirmasi() async {
    dynamic id_akun = await SessionManager().get("id_akun");

    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_status_konfirmasi.php?id_akun=${id_akun.toString()}");

    try {
      var response = await http.get(uri);

      status = jsonDecode(response.body);
      Map statusMap = status[0] as Map;
      // await SessionManager().set("visited", false);
      await SessionManager().containsKey("visited").then((value) async {
        if (value == false) {
          //belum pernah dibuat session nya
          await SessionManager().set("visited", false); //set false value nya
        }
      });
      await checkVisited();
      isKonfirmasi = statusMap['status'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkVisited() async {
    await SessionManager().get("visited").then((value) async {
      visit = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: statusKonfirmasi(),
      builder: (context, snapshot) {
        if (isKonfirmasi == '1') {
          return Konfirmasi(
            visit: visit,
          );
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return const Menunggu();
          }
        }
      },
    );
  }
}

//extract widget tampilan ketika sudah terkonfirmasi admin
class Konfirmasi extends StatelessWidget {
  // const Konfirmasi({
  //   super.key,
  // });
  Konfirmasi({required this.visit});

  late bool visit;

  @override
  Widget build(BuildContext context) {
    return visit
        ? PageMember()
        : Scaffold(
            body: ListView(
              children: [
                Column(
                  children: [
                    //pengganti dari appbar
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      width: double.infinity,
                      color: Color(0xff46838A),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FormIsiKtp(),
                          ));
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //konten bungkus informasi
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: -8,
                                  blurRadius: 10,
                                  offset: Offset(0, 0))
                            ],
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Status",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Pengajuan Anda Sudah Diterima",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff18B10B)),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.amber[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(width: 0.2)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(17),
                                    child: Text(
                                      "Sekarang anda sudah menjadi member Baletani",
                                      style:
                                          TextStyle(fontSize: 18, height: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  //button untuk lebih lanjut
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await SessionManager()
                                            .set("visited", true);
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => Page1(),
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("LEBIH LANJUT  ",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                          Icon(Icons.arrow_forward)
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff74CD82),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                )
              ],
            ),
            //bottom navigation bar nya
            bottomNavigationBar: CustomBottomNavigationBar(indexBottom: 2),
          );
  }
}

//extract widget tampilan ketika sedang menunggu
class Menunggu extends StatelessWidget {
  const Menunggu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              //pengganti dari appbar
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                color: Color(0xff46838A),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormIsiKtp(),
                    ));
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              //konten bungkus informasi
              Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -8,
                            blurRadius: 10,
                            offset: Offset(0, 0))
                      ],
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Status",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Menunggu Konfirmasi Admin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff18B10B)),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.amber[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(width: 0.2)),
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Text(
                            "Pengajuan anda sebagai member petani Baletani telah dikirim, mohon menunggu untuk konfirmasi dari admin",
                            style: TextStyle(fontSize: 18, height: 1.5),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              // Text(
              //     "Pengajuan anda sebagai member petani telah dikirim, mohon menunggu untuk konfirmasi dari admin"),
            ],
          )
        ],
      ),
      //bottom navigation bar nya
      bottomNavigationBar: CustomBottomNavigationBar(indexBottom: 2),
    );
  }
}
