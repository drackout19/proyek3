import 'package:flutter/material.dart';
import './DetailList.dart';
import './HalamanEvent.dart';
import './pageGabungMitra.dart';
import './widgets/CustomBottomNavigationBar.dart';

void main() {
  runApp(HalamanUtama());
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  // const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //ini untuk navigasinya
  late int index;
// -------

  late String str;
  late int angka;
  late int indexBottom;
  final List kategori = [
    {
      "judul": "Tim Baletani",
      "data": "tim",
    },
    {
      "judul": "Personal",
      "data": "personal",
    },
  ];

  //list widget untuk petani tim bale tani
  final List<Widget> listTampilTim = <Widget>[
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: Icons.check_circle_rounded,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: Icons.check_circle_rounded,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: Icons.check_circle_rounded,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
  ];

  //list widget untuk petani personal
  final List<Widget> listTampilPersonal = <Widget>[
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: null,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: null,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
    ListPetaniTim(
        profilGambar: "https://picsum.photos/200/300",
        nama: "Mang Soleh",
        iconProfile: null,
        judul: "Buruh Jagung",
        alamat: "Desa Lohbener",
        kontak: "081786346717"),
  ];

  late String kategoriAwal;
  late List<Widget> listTampil;

  @override
  void initState() {
    //inisialisasi untuk kategori dropdown
    kategoriAwal = kategori[0]["data"];

    str = "Hellow";
    angka = 1;
    indexBottom = 0;
    index = 0;

    listTampil = listTampilTim.map<Widget>((c) => c).toList();
    // listTampil = listTampilTim;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 70,
                  color: Color(0xff46838A),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 1),
                      // ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      width: double.infinity,
                      height: 56,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(Icons.search),
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
            Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(width: 1),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: -8, blurRadius: 10, offset: Offset(0, 0))
                ],
                color: Color(0xffF2F2F2),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Buruh Tani",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 0, top: 10),
                        child: DropdownButton(
                            elevation: 0,
                            underline: Container(color: Colors.transparent),
                            value: kategoriAwal,
                            items: kategori
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text("${e['judul']}"),
                                    value: e['data'] as String,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                kategoriAwal = value!;
                                if (kategoriAwal == "tim") {
                                  listTampil = listTampilTim
                                      .map<Widget>((c) => c)
                                      .toList();
                                } else if (kategoriAwal == "personal") {
                                  listTampil = listTampilPersonal
                                      .map<Widget>((c) => c)
                                      .toList();
                                }
                                // print(kategoriAwal);
                              });
                            }),
                        // Text(
                        //   "Kelompok",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //panggil list petani
            for (int i = 0; i < listTampil.length; i++) listTampil[i],
          ],
        ),
      ),

      //bottom navigation

      bottomNavigationBar: CustomBottomNavigationBar(indexBottom: indexBottom,),
    );
  }
}

//ekstract widget list petani tim baletani
class ListPetaniTim extends StatelessWidget {
  final String? profilGambar;
  final String? nama;
  final IconData? iconProfile;
  final String? judul;
  final String? alamat;
  final String? kontak;

  ListPetaniTim(
      {this.profilGambar,
      this.nama,
      this.iconProfile,
      this.judul,
      this.alamat,
      this.kontak});
  // ListPetaniTim({String profilGambar, String nama, String judul, String alamat, String kontak, Icon icon}) {
  //   this.profilGambar = profilGambar;
  //   this.nama = nama;
  //   this.alamat = alamat;
  //   this.kontak = kontak;
  //   this.icon = icon;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 180,
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //buat profile picture nya
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 80,
                // margin: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      image: NetworkImage(profilGambar!), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
              ),
              Text(nama!),
              // iconProfile,
              Icon(
                iconProfile,
                color: Colors.green,
                size: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.grey[350],
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    judul!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Alamat",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Icon(Icons.home, size: 15),
                      Text(
                        alamat!,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Kontak",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Icon(Icons.call, size: 15),
                      Text(
                        " ${kontak!}",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Text("________________________"),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Detail(),
                  ));
                },
                child: Text("Detail"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff46838A),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        // border: Border.all(width: 1),
        boxShadow: [
          BoxShadow(spreadRadius: -8, blurRadius: 10, offset: Offset(0, 0))
        ],
        color: Color(0xffF2F2F2),
      ),
    );
  }
}
