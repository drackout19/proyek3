import 'package:flutter/material.dart';
import './daftar.dart';
import './HalamanUtama.dart';
// import './home.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: content(),
    );
  }
}

class content extends StatefulWidget {
  const content({super.key});

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  bool isHidden = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 48, 127, 133),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(height: 35),
          TextField(
            controller: emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelText: "no telepon",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.perm_contact_cal),
            ),
          ),
          SizedBox(height: 25),
          TextField(
            controller: passC,
            autocorrect: false,
            obscureText: _obsecureText,
            textInputAction: TextInputAction.done,
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
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.vpn_key),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              //button login
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HalamanUtama(),
                    ),
                  );
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Belum punya akun?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => daftar(),
                    ),
                  );
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.grey.withOpacity(0),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
