//dependencies package

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

//pages
import './HalamanUtama.dart';
import './edit_profil/editKtp.dart';
import './form_isi_ktp.dart' as daftar_awal_ktp;
import './daftar.dart';
import './widgets/CustomBottomNavigationBar.dart';
import 'init.dart' as urlHttp;

class edit_profile extends StatefulWidget {
  const edit_profile({Key? key}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  late int index;
  late int indexBottom;

  @override
  void initState() {
    index = 0;
    indexBottom = 3;
    super.initState();
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

      //print("Isi data => ${isBuruhTani[1]['statusKonfirmasiBuruh']}");
      //Map dataMap = isBuruhTani[0] as Map;
      // ratingBuruh = double.parse(dataMap['rating']);
      // jumlahTersewa = int.parse(dataMap['jumlah_tersewa']);
      // print(dataMap["status"]);
      // statusMap = status[0] as Map;
      //print(statusMap['status']);

      return isBuruhTani;
    } catch (e) {
      print("ada error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 127, 133),
        body: ListView(
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Column(
                children: [
                  //jangan kasih appbar untuk back ke halaman sebelumnya
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   height: 40,
                  //   width: double.infinity,
                  //   color: Color(0xff46838A),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => HalamanUtama(),
                  //       ));
                  //     },
                  //     icon: Icon(Icons.arrow_back),
                  //   ),
                  // ),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: 145,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage("https://picsum.photos/500/300"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 80,
                            height: 80,
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
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Mang Binjai",
                                  style: TextStyle(
                                      color: Colors.white,
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
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                ),
                child: Column(children: [
                  SizedBox(height: 20),
                  Text(
                    "Pengaturan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Pengaturan Akun",
                            style: TextStyle(color: Colors.black),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FormAkun(),
                            ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Pengaturan Profil",
                            style: TextStyle(color: Colors.black),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FormProfil(),
                            ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Pengaturan Alamat",
                            style: TextStyle(color: Colors.black),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FormAlamat(),
                            ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bantuan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Daftar Sebagai Buruh Tani",
                            style: TextStyle(color: Colors.black),
                          )),
                      Builder(builder: (BuildContext context) {
                        return IconButton(
                            onPressed: () {
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   content: Text('Elevated button is'),
                              //   behavior: SnackBarBehavior.floating,
                              // ));
                              cekIsBuruh().then((value) {
                                if (value[0]['status'] == 1 &&
                                        value[1]['statusKonfirmasiBuruh'] ==
                                            '1' ||
                                    value[0]['status'] != null) {
                                  // print("value mantap ${value}");
                                  final snackBar = SnackBar(
                                    content: const Text(
                                      'anda sudah terdaftar sebagai Buruh Tani!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green[300],
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => daftar(),
                                  ));
                                }
                              });

                              //   // Navigator.of(context).push(MaterialPageRoute(
                              //   //   builder: (context) => daftar(),
                              //   // ));
                              // },
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ));
                      }),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Ajukan Penghapusan Akun",
                            style: TextStyle(color: Colors.black),
                          )),
                      IconButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => bantuanMemberBaleTani(),
                            // ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Member Baletani",
                            style: TextStyle(color: Colors.black),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => bantuanMemberBaleTani(),
                            ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                ]),
              ),
              //konten form profil
              // FormProfil(),
            ]),
        bottomNavigationBar:
            CustomBottomNavigationBar(indexBottom: indexBottom),
      ),
    );
  }
}

//extract widget untuk form akun
class FormAkun extends StatefulWidget {
  const FormAkun({super.key});

  @override
  State<FormAkun> createState() => _FormAkunState();
}

class _FormAkunState extends State<FormAkun> {
  bool isHidden = true;
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff46838A),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            //foto profil serta sampul
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: 145,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/500/300"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/id/238/200/300"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "ubah",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text("Mang Binjai",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 110,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xffEAC117),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                )
              ],
            ),
            SizedBox(height: 10),
            TextField(
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                labelText: "Kontak",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              autocorrect: false,
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//extract widget untuk form profil
class FormProfil extends StatefulWidget {
  const FormProfil({super.key});

  @override
  State<FormProfil> createState() => _FormProfilState();
}

class _FormProfilState extends State<FormProfil> {
  //  bool isHidden = true;
  // bool _obsecureText = true;
  TextEditingController namaC = new TextEditingController();
  TextEditingController jenisKlmnC = new TextEditingController();
  TextEditingController umurC = new TextEditingController();
  late Map dataStatusKonfirmasi = {};
  late Map dataStatusMember = {};
  Future<void> getDataProfile() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    print("ini id akun => ${id_akun}");
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_data_profile.php?id_akun=${id_akun.toString()}");
    try {
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      print("Isi data => ${data}");
      Map dataForm = data[0] as Map; //data alamat
      // Map dataStatus = data[1] as Map; //data status konfirmasi buruh
      // Map dataStatusMember = data[2] as Map; //data status apakah member
      // print(dataForm);
      //  Map dataAlamat = data[0] as Map; //data alamat
      dataStatusKonfirmasi = data[1] as Map; //data status konfirmasi buruh tani
      dataStatusMember = data[2] as Map; //data status apakah member?
      // print(dataAlamat);
      // print(dataStatusKonfirmasi);
      // print(dataStatusMember);

      //ratingBuruh = double.parse(dataProfil['rating']);
      // jumlahTersewa = int.parse(dataProfil['jumlah_tersewa']);

      // print(dataStatusKonfirmasi as Map);
      // Map dataStsKnfrmsi = dataStatusKonfirmasi as Map;
      // Map dataPrfl = dataProfil as Map;
      // Map dataAlmt = dataAlamat as Map;
      // nikC = TextEditingController(text: "${dataPrfl['nik_ktp']}");
      // nameC = TextEditingController(text: "${dataPrfl['nama']}");
      // tempatLahirC = TextEditingController(text: "${dataPrfl['tempat_lahir']}");
      // tglLahirC = TextEditingController(text: "${dataPrfl['tgl_lahir']}");

      namaC = TextEditingController(text: "${dataForm['nama']}");
      jenisKlmnC = TextEditingController(text: "${dataForm['jenis_kelamin']}");
      umurC = TextEditingController(text: "${dataForm['umur']}");

      // rtC = TextEditingController(text: "${dataAlmt['rt']}");
      // rwC = TextEditingController(text: "${dataAlmt['rw']}");
      // kelDesC = TextEditingController(text: "${dataAlmt['kel_desa']}");
      // kcmtnC = TextEditingController(text: "${dataAlmt['kecamatan']}");
      // kabC = TextEditingController(text: "${dataAlmt['kabupaten']}");
      // provC = TextEditingController(text: "${dataAlmt['provinsi']}");

      // fotoKtp = dataPrfl['foto_ktp'];
      // fotoSelfieKtp = dataPrfl['foto_selfie_ktp'];
      //print(selectedImagePathSelfieKtp);
      // print(data['nik_ktp']);
    } catch (e) {
      print("ada error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDataProfile(),
      builder: (context, snapshot) {
        if (dataStatusKonfirmasi["status"] != '0' &&
            dataStatusKonfirmasi["status"] != null) {
          if (dataStatusMember["statusMember"] == null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff46838A),
              ),
              body: Container(
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    //foto profil serta sampul
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 145,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage("https://picsum.photos/500/300"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://picsum.photos/id/238/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "ubah",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Mang Binjai",
                                    style: TextStyle(
                                        color: Colors.white,
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
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: namaC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Nama",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // TextField(
                    //   autocorrect: false,
                    //   textInputAction: TextInputAction.next,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //     labelText: "Telepon",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    TextField(
                      controller: jenisKlmnC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Jenis Kelamin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: umurC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     // setState(() {
                        //     //   _obsecureText = !_obsecureText;
                        //     // });
                        //   },
                        //   icon: Icon(
                        //     _obsecureText ? Icons.visibility_off : Icons.visibility,
                        //   ),
                        // ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Umur",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Divider(color: Colors.black),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff46838A),
              ),
              body: Container(
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    //foto profil serta sampul
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 145,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage("https://picsum.photos/500/300"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://picsum.photos/id/238/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "ubah",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Mang Binjai",
                                    style: TextStyle(
                                        color: Colors.white,
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
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: namaC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Nama",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // TextField(
                    //   autocorrect: false,
                    //   textInputAction: TextInputAction.next,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //     labelText: "Telepon",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    TextField(
                      controller: jenisKlmnC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Jenis Kelamin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: umurC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     // setState(() {
                        //     //   _obsecureText = !_obsecureText;
                        //     // });
                        //   },
                        //   icon: Icon(
                        //     _obsecureText ? Icons.visibility_off : Icons.visibility,
                        //   ),
                        // ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        labelText: "Umur",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Divider(color: Colors.black),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     "Simpan",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              body: AlertDialog(
                title: Text("Baletani Tim"),
                content: Text("Anda belum diijinkan mengubah profil!"),
                actions: [
                  TextButton(
                    child: Text(
                      "tutup",
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  // TextButton(
                  //   child: Text("daftar"),
                  //   onPressed: () {
                  //     // Navigator.of(context).pop();
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => daftar_awal_ktp.FormIsiKtp(),
                  //     ));
                  //   },
                  // ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}

//extract widget untuk form ubah alamat
class FormAlamat extends StatefulWidget {
  const FormAlamat({super.key});

  @override
  State<FormAlamat> createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  //  bool isHidden = true;
  // bool _obsecureText = true;
  TextEditingController alamatC = new TextEditingController();
  // TextEditingController rtC = TextEditingController(text: "001");
  // TextEditingController rwC = TextEditingController(text: "001");
  // TextEditingController kelDesC = TextEditingController(text: "Singajaya");
  // TextEditingController kcmtnC = TextEditingController(text: "Indramayu");
  // TextEditingController kabC = TextEditingController(text: "Indramayu");
  // TextEditingController provC = TextEditingController(text: "Jawa Barat");

  //function future get data alamat
  late Map dataStatusKonfirmasi = {};
  late Map dataStatusMember = {};

  Future<void> getDataAlamatBuruh() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    print(id_akun);
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_data_alamat_buruh.php?id_akun=${id_akun.toString()}");
    try {
      var response = await http.get(uri);

      List data = jsonDecode(response.body);

      Map dataAlamat = data[0] as Map; //data alamat
      dataStatusKonfirmasi = data[1] as Map; //data status konfirmasi buruh tani
      dataStatusMember = data[2] as Map; //data status apakah member?
      print(dataAlamat);
      print(dataStatusKonfirmasi);
      print(dataStatusMember);
      //ratingBuruh = double.parse(dataProfil['rating']);
      // jumlahTersewa = int.parse(dataProfil['jumlah_tersewa']);

      // print(dataStatusKonfirmasi as Map);
      // Map dataStsKnfrmsi = dataStatusKonfirmasi as Map;
      // Map dataPrfl = dataProfil as Map;
      // Map dataAlmt = dataAlamat as Map;
      // nikC = TextEditingController(text: "${dataPrfl['nik_ktp']}");
      // nameC = TextEditingController(text: "${dataPrfl['nama']}");
      // tempatLahirC = TextEditingController(text: "${dataPrfl['tempat_lahir']}");
      // tglLahirC = TextEditingController(text: "${dataPrfl['tgl_lahir']}");

      alamatC = TextEditingController(text: "${dataAlamat['alamat']}");

      // rtC = TextEditingController(text: "${dataAlmt['rt']}");
      // rwC = TextEditingController(text: "${dataAlmt['rw']}");
      // kelDesC = TextEditingController(text: "${dataAlmt['kel_desa']}");
      // kcmtnC = TextEditingController(text: "${dataAlmt['kecamatan']}");
      // kabC = TextEditingController(text: "${dataAlmt['kabupaten']}");
      // provC = TextEditingController(text: "${dataAlmt['provinsi']}");

      // fotoKtp = dataPrfl['foto_ktp'];
      // fotoSelfieKtp = dataPrfl['foto_selfie_ktp'];
      //print(selectedImagePathSelfieKtp);
      // print(data['nik_ktp']);
    } catch (e) {
      print("ada error ${e}");
      //dataStatusKonfirmasi["status"] = '0'; //tembak aja untuk sementara
    }
  }

  Future<void> updateData() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    final uri = Uri.parse("${urlHttp.urlHTTP.uri}update_alamat.php");
    var request = http.MultipartRequest('POST', uri);
    print(id_akun);
    request.fields['id_akun'] = id_akun.toString();
    // request.fields['nama'] = nameC.text;
    // request.fields['nik'] = nikC.text;
    // request.fields['tempat_lahir'] = tempatLahirC.text;
    // request.fields['tgl_lahir'] = tglLahirC.text;
    request.fields['alamat'] = alamatC.text;
    // request.fields['rt'] = rtC.text;
    // request.fields['rw'] = rwC.text;
    // request.fields['kel_desa'] = kelDesC.text;
    // request.fields['kec'] = kcmtnC.text;
    // request.fields['kab'] = kabC.text;
    // request.fields['prov'] = provC.text;

    // var pic = await http.MultipartFile.fromPath("image_ktp", _image!.path);
    // var picSelfieKtp = await http.MultipartFile.fromPath(
    //     "image_selfie", _imageSelfieKtp!.path);

    // //insert to $_FILES in php, and in php will catch in the $_FILES
    // request.files.add(pic);
    // request.files.add(picSelfieKtp);

    //send all request post file to http and keep waiting that result after this
    var response = await request.send();

    if (response.statusCode == 200) {
      // await SessionManager().set("visited_ktp", true); //set true value nya

      print("Data terkirim pada akun ${id_akun}");
      // print(id_akun);
      final snackBar = SnackBar(
        content: const Text(
          'Data berhasil diperbaharui!',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[300],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("Image Not Uploaded");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataAlamatBuruh(),
        builder: (context, snapshot) {
          if (dataStatusKonfirmasi["status"] != '0' &&
              dataStatusKonfirmasi["status"] != null) {
            if (dataStatusMember["statusMember"] == null) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Alamat Saya"),
                  centerTitle: true,
                  backgroundColor: Color(0xff46838A),
                ),
                body: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      //konten form
                      Column(
                        children: [
                          TextFormField(
                            controller: alamatC,
                            autofillHints: [AutofillHints.countryName],
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              // contentPadding:
                              //     EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                              prefixText: "Alamat : ",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          // TextField(
                          //   enabled: false,
                          //   controller: rtC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "RT : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          // TextField(
                          //   controller: rwC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "RW : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          // TextField(
                          //   controller: kelDesC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "Kelurahan / Desa : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          // TextField(
                          //   controller: kcmtnC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "Kecamatan : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          // TextField(
                          //   controller: kabC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "Kabupaten : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          // TextField(
                          //   controller: provC,
                          //   autocorrect: false,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 20, vertical: 20),
                          //     prefixText: "Provinsi : ",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 20),
                          Divider(),
                          ElevatedButton(
                            onPressed: () {
                              updateData();
                            },
                            child: Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Alamat Saya"),
                  centerTitle: true,
                  backgroundColor: Color(0xff46838A),
                ),
                body: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      //konten form
                      Column(
                        children: [
                          TextFormField(
                            controller: alamatC,
                            enabled: false,
                            autofillHints: [AutofillHints.countryName],
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              // contentPadding:
                              //     EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                              prefixText: "Alamat : ",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          Divider(),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     "Simpan",
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(5),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              return Scaffold(
                body: AlertDialog(
                  title: Text("Baletani Tim"),
                  content: Text("Anda belum diijinkan mengubah alamat!"),
                  actions: [
                    TextButton(
                      child: Text(
                        "tutup",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    // TextButton(
                    //   child: Text("daftar"),
                    //   onPressed: () {
                    //     // Navigator.of(context).pop();
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => daftar_awal_ktp.FormIsiKtp(),
                    //     ));
                    //   },
                    // ),
                  ],
                ),
              );
            }
          }
        });
  }
}

//extract widget bantuan member baletani
class bantuanMemberBaleTani extends StatefulWidget {
  const bantuanMemberBaleTani({super.key});

  @override
  State<bantuanMemberBaleTani> createState() => _bantuanMemberBaleTaniState();
}

class _bantuanMemberBaleTaniState extends State<bantuanMemberBaleTani> {
  Future<dynamic?> cekIsMmember() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    //String id_akun = "210301";
    print("id_akun skrng => ${id_akun}");

    // final uri = Uri.parse(
    //     "http://192.168.56.1:8080/proyek3_api/get_rating.php?id_akun=${id_akun.toString()}");
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_is_member_petani.php?id_akun=${id_akun.toString()}");

    try {
      var response = await http.get(uri);

      List isMemberTani = jsonDecode(response.body);
      Map dataMap = isMemberTani[0] as Map;
      // ratingBuruh = double.parse(dataMap['rating']);
      // jumlahTersewa = int.parse(dataMap['jumlah_tersewa']);
      //print(dataMap);
      // statusMap = status[0] as Map;
      // print(statusMap['status']);
      return dataMap['status'];
    } catch (e) {
      print("ada error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cekIsMmember(),
      builder: (context, snapshot) {
        return (snapshot.data == '1' &&
                snapshot.connectionState == ConnectionState.done)
            ? Scaffold(
                appBar: AppBar(
                  title: Text("Pengaturan"),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => edit_profile(),
                      ));
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                body: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                          ),
                          child: Column(children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Ajukan Ubah Data KTP",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormIsiKtp(),
                                      ));
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : (snapshot.connectionState == ConnectionState.waiting)
                ? Scaffold(body: Center(child: CircularProgressIndicator()))
                : Scaffold(
                    body: AlertDialog(
                      title: Text("Baletani Tim"),
                      content: Text(
                          "Anda belum menjadi member Baletani, segera daftarkan diri anda!"),
                      actions: [
                        TextButton(
                          child: Text(
                            "tutup",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("daftar"),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  daftar_awal_ktp.FormIsiKtp(),
                            ));
                          },
                        ),
                      ],
                    ),
                  );
        ;
      },
    );
  }
}
