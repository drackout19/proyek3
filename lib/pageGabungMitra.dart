import 'package:flutter/material.dart';
import './widgets/CustomBottomNavigationBar.dart';
import 'package:lottie/lottie.dart';

class PageGabungMitra extends StatefulWidget {
  const PageGabungMitra({super.key});

  @override
  State<PageGabungMitra> createState() => _PageGabungMitraState();
}

class _PageGabungMitraState extends State<PageGabungMitra> {
  late int indexBottom;
  void initState() {
    indexBottom = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                                    onPressed: () {},
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
                                      backgroundColor: Color(0xff46838A),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    width: 120,
                                    height: 120,
                                    child: Lottie.asset(
                                        "assets/lotties/siapkan-ktp.json")))),
                        ListTile(
                          title: Text("2. Isi data diri sesuai dalam KTP",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
