//dependencies package
import 'package:bale_tani2/daftar.dart';
import 'package:bale_tani2/konfirmasi_member.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

//partial widgets
import './widgets/CustomBottomNavigationBar.dart';

//page require
import 'init.dart' as urlHttp;
import 'dart:convert';
import 'package:bale_tani2/HalamanUtama.dart';
import './form_isi_ktp.dart';

import 'package:flutter/material.dart';
import './PageMember.dart';

class PageGabungMitra extends StatefulWidget {
  const PageGabungMitra({super.key});

  @override
  State<PageGabungMitra> createState() => _PageGabungMitraState();
}

class _PageGabungMitraState extends State<PageGabungMitra> {
  late int indexBottom;
  late dynamic visit = false;
  void initState() {
    indexBottom = 2;
    super.initState();
  }

  Future<void> getVisit() async {
    await SessionManager().get("visited_ktp").then((value) async {
      visit = value;
    });
    print(visit);
  }

  Future<dynamic?> cekIsBuruh() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    //String id_akun = "210301";
    print("id_akun skrng => ${id_akun}");

    // final uri = Uri.parse(
    //     "http://192.168.56.1:8080/proyek3_api/get_rating.php?id_akun=${id_akun.toString()}");
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_is_buruh_petani.php?id_akun=${id_akun.toString()}");

    try {
      var response = await http.get(uri);

      List isBuruhTani = jsonDecode(response.body);
      Map dataMap = isBuruhTani[0] as Map;
      // ratingBuruh = double.parse(dataMap['rating']);
      // jumlahTersewa = int.parse(dataMap['jumlah_tersewa']);
      print(dataMap["status"]);
      // statusMap = status[0] as Map;
      //print(statusMap['status']);
      return dataMap['status'];
    } catch (e) {
      print("ada error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
      future: getVisit(),
      builder: (context, snapshot) {
        if (visit == false) {
          return FutureBuilder(
            future: cekIsBuruh(),
            builder: (context, snapshot2) {
              if (snapshot2.data == 1 &&
                  snapshot2.connectionState == ConnectionState.done) {
                return Scaffold(
                  backgroundColor: Color(0xff2A3C44),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Color(0xff46838A),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.elliptical(100, 50),
                                      bottomRight: Radius.elliptical(100, 50))),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 190,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all( Radius.elliptical(150, 50))
                                  // ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  height: 110,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "DAFTARKAN DIRI ANDA",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff5B9848)),
                                          ),
                                          Text("KE BALAI TANI",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff5B9848))),
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormIsiKtp(),
                                                ));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("DAFTAR SEKARANG  ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  Icon(Icons.arrow_forward)
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff46838A),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),

                                    // border: Border.all(width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: -8,
                                          blurRadius: 10,
                                          offset: Offset(0, 0))
                                    ],
                                    color: Color(0xffF2F2F2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                            elevation: 15,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  ListTile(
                                      title: Text("1. Siapkan KTP",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              width: 120,
                                              height: 120,
                                              child: Lottie.asset(
                                                  "assets/lotties/siapkan-ktp.json")))),
                                  ListTile(
                                    title: Text(
                                        "2. Isi data diri sesuai dalam KTP",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 15, bottom: 30, top: 30),
                                            width: 90,
                                            height: 90,
                                            child: Lottie.asset(
                                                "assets/lotties/ktp-isi-gerak.json"))),
                                  ),
                                  ListTile(
                                    title: Text("3. Foto diri dengan KTP",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 30, top: 30),
                                            width: 90,
                                            height: 90,
                                            child: Lottie.asset(
                                                "assets/lotties/selfie-ktp.json"))),
                                  ),
                                  ListTile(
                                    title: Text("4. Menunggu konfirmasi admin",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            width: 130,
                                            height: 130,
                                            child: Lottie.asset(
                                                "assets/lotties/konfirmasi-ktp.json"))),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  bottomNavigationBar:
                      CustomBottomNavigationBar(indexBottom: indexBottom),
                );
              } else {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                } else {
                  return Scaffold(
                    body: AlertDialog(
                      title: Text("Baletani Tim"),
                      content: Text(
                          "Anda belum di ijinkan akses untuk daftar menjadi Member BaleTani, segera daftar menjadi buruh tani terlebih dahulu!"),
                      actions: [
                        TextButton(
                          child: Text(
                            "tutup",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HalamanUtama(),
                            ));
                          },
                        ),
                        TextButton(
                          child: Text("daftar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  daftar(),
                            ));
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          );
        } else {
          return KonfirmasiPage();
        }
      },
    ));
  }
}
