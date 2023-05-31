import 'package:flutter/material.dart';
import './HalamanUtama.dart';
import './HalamanKonfirmasiPenyewaan.dart';
import './HalamanEvent.dart';
import './widgets/CustomBottomNavigationBar.dart';

void main() {
  runApp(Detail());
}

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int indexBottom;

  @override
  void initState() {
    indexBottom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A3C44),
      // showWidget[index],
      body: ListView(
        children: [
          Column(
            children: [
              //sebagai pengganti appbar
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                color: Color(0xff46838A),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HalamanUtama(),
                    ));
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),

              //banner foto sampul serta profile picture nya
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
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
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

              SizedBox(height: 20),
              //container biodata profile
              Container(
                child: biodataProfile(),
              ),

              SizedBox(
                height: 10,
              ),
              //deskripsi dari profile nya, dibungkung container biar relatif
              Container(
                child: deskripsiProfile(),
              ),

              SizedBox(
                height: 10,
              ),
              //membuat footer action container tombol sewa
              footerActionSewa()
            ],
          )
        ],
      ),

      //bottom untuk navigasinya
      bottomNavigationBar: CustomBottomNavigationBar(indexBottom: indexBottom),
    );
  }
}

//extract widget untuk footer action tombol sewa
class footerActionSewa extends StatefulWidget {
  const footerActionSewa({
    super.key,
  });

  @override
  State<footerActionSewa> createState() => _footerActionSewaState();
}

class _footerActionSewaState extends State<footerActionSewa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xffF2F2F2)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Biaya Jasa",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rp. 130.000",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                ),
                Text("/hari")
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KonfirmasiPenyewaan(),
                    ));
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  "Sewa",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

//extract widget untuk biodata profile nya

class biodataProfile extends StatelessWidget {
  const biodataProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Text(
                "Alamat",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                ": Desa Lohbener",
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text("Telp/Wa", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                width: 10,
              ),
              Text(": 08123864465")
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text("Jenis Kelamin",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                width: 10,
              ),
              Text(": Pria")
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text("Umur", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                width: 10,
              ),
              Text(": 45")
            ],
          ),
        ]),
      ),
    );
  }
}

//extract widget untuk deskripsi profile
class deskripsiProfile extends StatelessWidget {
  const deskripsiProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                Text("- Petani Jagung \n- Petani Padi \n- Petani Bawang")
              ],
            ),
            Column(
              children: [
                Text("Rating", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 5,
                ),

                //row buat icon bintang
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
                ),
                SizedBox(
                  height: 5,
                ),
                Text("10 Tersewa",
                    style: TextStyle(fontWeight: FontWeight.w600))
              ],
            )
          ],
        ),
      ),
    );
  }
}
