import 'package:flutter/material.dart';
import 'package:proyek/home.dart';


class edit_profile extends StatefulWidget {
  const edit_profile({Key? key}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  bool isHidden = true;
  bool _obsecureText = true;
  late int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 127, 133),
        body: 
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                Column(
            children: [
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
              ],

          ),
                SizedBox(height: 25),
                TextField(
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: 
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: 
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  labelText: "Telepon",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: 
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  labelText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    }, icon: Icon(
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
                SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, 
                  child: Text("UBAH", 
                    style: TextStyle(color: Colors.black),
                    ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ), 
              ]
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.green,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: index,
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //     });
      //   },
      //   items: [
      //   BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
      //   BottomNavigationBarItem(icon: Icon(Icons.event_available_outlined), label: "Event"),
      //   BottomNavigationBarItem(icon: Icon(Icons.notification_add_outlined), label: "Notifikasi"),
      //   BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
      //   ]
      // ),
    ),
    );
  }
}