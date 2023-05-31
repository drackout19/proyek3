import 'dart:ui';

import 'package:flutter/material.dart';
import './form_isi_ktp.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './widgets/CustomBottomNavigationBar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'init.dart' as urlHttp;

void main() {
  runApp(PageMember());
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageMember(),
    );
  }
}

//extract widget tampilan ketika sudah terkonfirmasi admin
class PageMember extends StatefulWidget {
  @override
  State<PageMember> createState() => _PageMemberState();
}

class _PageMemberState extends State<PageMember> {
  // List status = [];
  late double ratingBuruh = 0;

  late int jumlahTersewa = 0;

  TextEditingController judulC = TextEditingController();

  TextEditingController deskripsiC = TextEditingController();

  TextEditingController biayaJasaC = TextEditingController();

  //post postigan jasa
  Future<bool> Kirim() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    final uri = Uri.parse("${urlHttp.urlHTTP.uri}insert_postingan.php");
    var request = http.MultipartRequest('POST', uri);
    print("Id_akun ${id_akun}");
    request.fields['id_akun'] = id_akun.toString();
    request.fields['judul'] = judulC.text;
    request.fields['deskripsi'] = deskripsiC.text;
    request.fields['biaya_jasa'] = biayaJasaC.text;

    //send all request post file to http and keep waiting that result after this
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Postingan berhasil terkirim");

      final snackBar = SnackBar(
        content: const Text(
          'Postingan berhasil terkirim!',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[300],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return true;
    } else {
      print("Image Not Uploaded");
      return false;
    }

    // setState(() {});
  }

  //get rating dan tersewa
  Future<void> getRating() async {
    dynamic id_akun = await SessionManager().get("id_akun");

    // final uri = Uri.parse(
    //     "http://192.168.56.1:8080/proyek3_api/get_rating.php?id_akun=${id_akun.toString()}");
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_rating.php?id_akun=${id_akun.toString()}");

    try {
      var response = await http.get(uri);

      List dataRating = jsonDecode(response.body);
      Map dataMap = dataRating[0] as Map;
      ratingBuruh = double.parse(dataMap['rating']);
      jumlahTersewa = int.parse(dataMap['jumlah_tersewa']);

      // statusMap = status[0] as Map;
      // print(statusMap['status']);
    } catch (e) {
      print("ada error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // PageUtama(
        //     ratingBuruh: ratingBuruh,
        //     jumlahTersewa: jumlahTersewa,
        //     judulC: judulC,
        //     deskripsiC: deskripsiC,
        //     biayaJasaC: biayaJasaC);
        FutureBuilder(
      future: getRating(),
      builder: (context, snapshot) {
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
                          builder: (context) => FormKtp(),
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: -8,
                                blurRadius: 10,
                                offset: Offset(0, 0))
                          ],
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        SizedBox(height: 10),
                        //foto profile serta emblem baletani
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://picsum.photos/id/238/200/300"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Mang Binjai",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 110,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Color(0xffEAC117),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Member BaleTani",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.check_circle,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        //pembatas
                        Divider(color: Colors.black54, thickness: 1),

                        //informasi rating dan tersewa
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Column info rating
                            Column(
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  "Rating",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 20),
                                // IconBintang(),
                                RatingBarIndicator(
                                  rating: ratingBuruh,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),

                            //sizedbox
                            SizedBox(width: 100),

                            //Column info tersewa
                            Column(
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  "Tersewa",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 20),
                                Text("${jumlahTersewa} Kali")
                              ],
                            ),
                          ],
                        ),

                        //sizedbox and divider
                        SizedBox(height: 5),
                        Divider(color: Colors.black54, thickness: 1),

                        //section buat postingan jasa
                        Text("Buat Postingan Jasa",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            //column untuk membungkus konten didalam form postingan
                            child: Column(
                              children: [
                                //row untuk logo publik serta button posting
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 10),
                                        Icon(Icons.public, size: 20),
                                        SizedBox(width: 5),
                                        Text("Publik",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          var x = await Kirim();
                                          if (x == true) {
                                            judulC.text = '';
                                            deskripsiC.text = '';
                                            biayaJasaC.text = '';
                                          }
                                        },
                                        child: Text("Posting"))
                                  ],
                                ),

                                //divider
                                Divider(color: Colors.black54, thickness: 1),
                                //form judul
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 200),
                                  child: TextFormField(
                                    controller: judulC,
                                    decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      label: Text("Judul"),
                                    ),
                                  ),
                                ),

                                //form deskripsi
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    controller: deskripsiC,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      label: Text(
                                          "Tuliskan deskripsi postingan anda"),
                                    ),
                                  ),
                                ),

                                //form biaya jasa nya
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 200),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Rp.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: biayaJasaC,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              // border: OutlineInputBorder(),
                                              // label: Text("Biaya jasa"),
                                              hintText: " 150.000",
                                              labelText: " Biaya jasa"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
      },
    );
  }
}

//extract widget untuk halaman page member
class PageUtama extends StatefulWidget {
  //constructor
  PageUtama(
      {this.ratingBuruh = 0,
      this.jumlahTersewa = 0,
      required this.judulC,
      required this.deskripsiC,
      required this.biayaJasaC});

  late double ratingBuruh;
  late int jumlahTersewa;
  late TextEditingController judulC;
  late TextEditingController deskripsiC;
  late TextEditingController biayaJasaC;

  @override
  State<PageUtama> createState() => _PageUtamaState();
}

class _PageUtamaState extends State<PageUtama> {
  // late TextEditingController judulC;
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -8,
                            blurRadius: 10,
                            offset: Offset(0, 0))
                      ],
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    SizedBox(height: 10),
                    //foto profile serta emblem baletani
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://picsum.photos/id/238/200/300"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Mang Binjai",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 110,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xffEAC117),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Member BaleTani",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      size: 15,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    //pembatas
                    Divider(color: Colors.black54, thickness: 1),

                    //informasi rating dan tersewa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Column info rating
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              "Rating",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            // IconBintang(),
                            RatingBarIndicator(
                              rating: widget.ratingBuruh,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),

                        //sizedbox
                        SizedBox(width: 100),

                        //Column info tersewa
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              "Tersewa",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            Text("${widget.jumlahTersewa} Kali")
                          ],
                        ),
                      ],
                    ),

                    //sizedbox and divider
                    SizedBox(height: 5),
                    Divider(color: Colors.black54, thickness: 1),

                    //section buat postingan jasa
                    Text("Buat Postingan Jasa",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        //column untuk membungkus konten didalam form postingan
                        child: Column(
                          children: [
                            //row untuk logo publik serta button posting
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(Icons.public, size: 20),
                                    SizedBox(width: 5),
                                    Text("Publik",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // Kirim();
                                    },
                                    child: Text("Posting"))
                              ],
                            ),

                            //divider
                            Divider(color: Colors.black54, thickness: 1),
                            //form judul
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 200),
                              child: TextField(
                                controller: widget.judulC,
                                //focusNode: FocusNode(),

                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  label: Text("Judul"),
                                ),
                              ),
                            ),

                            //form deskripsi
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: widget.deskripsiC,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  label:
                                      Text("Tuliskan deskripsi postingan anda"),
                                ),
                              ),
                            ),

                            //form biaya jasa nya
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 200),
                              child: Row(
                                children: [
                                  Text(
                                    "Rp.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: widget.biayaJasaC,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          // border: OutlineInputBorder(),
                                          // label: Text("Biaya jasa"),
                                          hintText: " 150.000",
                                          labelText: " Biaya jasa"),
                                    ),
                                  ),
                                ],
                              ),
                            )
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
