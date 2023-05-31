import 'package:bale_tani2/daftar_akun.dart';
import 'package:flutter/material.dart';
import 'daftar.dart';
import 'daftar_login.dart';
import 'edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: daftarAkun(),
    );
  }
}


//coba firebase
// import 'package:flutter/material.dart';

// void main() {
//   runApp(myApp());
// }

// class myApp extends StatefulWidget {
//   const myApp({super.key});

//   @override
//   State<myApp> createState() => _myAppState();
// }

// class _myAppState extends State<myApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(),
//     );
//   }
// }
