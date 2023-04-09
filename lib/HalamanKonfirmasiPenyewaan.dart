import 'package:flutter/material.dart';
import './DetailList.dart';
import './HalamanUtama.dart';
import './HalamanEvent.dart';
import './widgets/CustomBottomNavigationBar.dart';

void main() {
  runApp(KonfirmasiPenyewaan());
}

class KonfirmasiPenyewaan extends StatelessWidget {
  const KonfirmasiPenyewaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KonfirmasiSewa(),
    );
  }
}

class KonfirmasiSewa extends StatefulWidget {
  const KonfirmasiSewa({super.key});

  @override
  State<KonfirmasiSewa> createState() => _KonfirmasiSewaState();
}

class _KonfirmasiSewaState extends State<KonfirmasiSewa>
    with SingleTickerProviderStateMixin {
  late TabController tabC = TabController(length: 2, vsync: this);

  late int indexBottom;

  void initState() {
    indexBottom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A3C44),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff46838A),
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Detail(),
              ));
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        bottom: TabBar(
          controller: tabC,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "Menunggu",
            ),
            Tab(
              text: "Terkonfirmasi",
            ),
          ],
        ),
      ),

      //konten dari tabbarnya
      body: TabBarView(controller: tabC, children: [
        //halaman menunggu
        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            //semuanya kita bungkus dlam SingleChildScrollView
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  //container informasi serta action batalkan
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //gambar profile
                              Container(
                                width: 80,
                                height: 80,
                                //margin: EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://picsum.photos/200/300"),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              //nama akun dan emblem baletani
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mang Binjai"),
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

                          //informasi harga jasa serta icon button batalkan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Biaya Jasa: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Rp135.000",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ]),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => Detail(),
                                  // ));
                                },
                                child: Text("Batalkan"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),

        //halaman terkonfirmasi
        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            //semuanya kita bungkus dlam SingleChildScrollView
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  //container informasi serta action batalkan
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //gambar profile
                              Container(
                                width: 80,
                                height: 80,
                                //margin: EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://picsum.photos/200/300"),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              //nama akun dan emblem baletani
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mang Binjai"),
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

                          //informasi harga jasa serta icon button batalkan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Biaya Jasa: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Rp135.000",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ]),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => Detail(),
                                  // ));
                                },
                                child: Text("Beri Upah"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ]),

      //bottom navigation bar
      bottomNavigationBar: CustomBottomNavigationBar(indexBottom: indexBottom),
    );
  }
}
