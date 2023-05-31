//dependencies package
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
//pages
import 'package:bale_tani2/pageGabungMitra.dart';
import '../konfirmasi_member.dart';
import 'package:bale_tani2/PageMember.dart';
import '../edit_profile.dart';
import '../init.dart' as urlHttp;

class FormIsiKtp extends StatelessWidget {
  const FormIsiKtp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: FormKtp(),
    );
  }
}

class FormKtp extends StatefulWidget {
  const FormKtp({super.key});

  @override
  State<FormKtp> createState() => _FormKtpState();
}

class _FormKtpState extends State<FormKtp> {
  late String selectedImagePath = '';
  late String selectedImagePathKtp = '';
  late String selectedImagePathSelfieKtp = '';
  late String fotoKtp = '';
  late String fotoSelfieKtp = '';
  File? _image;
  File? _imageSelfieKtp;
  final picker = ImagePicker();

  //data variabel ktp
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController tempatLahirC = TextEditingController();
  TextEditingController tglLahirC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController kelDesC = TextEditingController();
  TextEditingController kcmtnC = TextEditingController();
  TextEditingController kabC = TextEditingController();
  TextEditingController provC = TextEditingController();

  Future<void> getDataKtp() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    final uri = Uri.parse(
        "${urlHttp.urlHTTP.uri}get_data_ktp.php?id_akun=${id_akun.toString()}");
    try {
      var response = await http.get(uri);

      List dataKtp = jsonDecode(response.body);

      Map dataProfil = dataKtp[0] as Map; //data profil
      Map dataAlamat = dataKtp[1] as Map; //data alamat buruh
      //ratingBuruh = double.parse(dataProfil['rating']);
      // jumlahTersewa = int.parse(dataProfil['jumlah_tersewa']);

      // print(dataStatusKonfirmasi as Map);
      // Map dataStsKnfrmsi = dataStatusKonfirmasi as Map;
      Map dataPrfl = dataProfil as Map;
      Map dataAlmt = dataAlamat as Map;
      nikC = TextEditingController(text: "${dataPrfl['nik_ktp']}");
      nameC = TextEditingController(text: "${dataPrfl['nama']}");
      tempatLahirC = TextEditingController(text: "${dataPrfl['tempat_lahir']}");
      tglLahirC = TextEditingController(text: "${dataPrfl['tgl_lahir']}");
      alamatC = TextEditingController(text: "${dataAlmt['alamat']}");
      rtC = TextEditingController(text: "${dataAlmt['rt']}");
      rwC = TextEditingController(text: "${dataAlmt['rw']}");
      kelDesC = TextEditingController(text: "${dataAlmt['kel_desa']}");
      kcmtnC = TextEditingController(text: "${dataAlmt['kecamatan']}");
      kabC = TextEditingController(text: "${dataAlmt['kabupaten']}");
      provC = TextEditingController(text: "${dataAlmt['provinsi']}");

      fotoKtp = dataPrfl['foto_ktp'];
      fotoSelfieKtp = dataPrfl['foto_selfie_ktp'];
      //print(selectedImagePathSelfieKtp);
      // print(data['nik_ktp']);
    } catch (e) {
      print("ada error ${e}");
    }
  }

  //upload data
  Future<void> uploadData() async {
    dynamic id_akun = await SessionManager().get("id_akun");
    final uri =
        Uri.parse("${urlHttp.urlHTTP.uri}update_ktp.php");
    var request = http.MultipartRequest('POST', uri);
    print(id_akun);
    request.fields['id_akun'] = id_akun.toString();
    request.fields['nama'] = nameC.text;
    request.fields['nik'] = nikC.text;
    request.fields['tempat_lahir'] = tempatLahirC.text;
    request.fields['tgl_lahir'] = tglLahirC.text;
    request.fields['alamat'] = alamatC.text;
    request.fields['rt'] = rtC.text;
    request.fields['rw'] = rwC.text;
    request.fields['kel_desa'] = kelDesC.text;
    request.fields['kec'] = kcmtnC.text;
    request.fields['kab'] = kabC.text;
    request.fields['prov'] = provC.text;

    var pic = await http.MultipartFile.fromPath("image_ktp", _image!.path);
    var picSelfieKtp = await http.MultipartFile.fromPath(
        "image_selfie", _imageSelfieKtp!.path);

    //insert to $_FILES in php, and in php will catch in the $_FILES
    request.files.add(pic);
    request.files.add(picSelfieKtp);

    //send all request post file to http and keep waiting that result after this
    var response = await request.send();

    if (response.statusCode == 200) {
      await SessionManager().set("visited_ktp", true); //set true value nya

      print("Image Uploaded");

      //arahkan langsung ke page lain jika berhasil
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => KonfirmasiMember(),
      //   ),
      // );
    } else {
      print("Image Not Uploaded");
    }

    setState(() {});
  }

  //function future untuk menjalankan perintah ambil gambar
  Future<void> choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDataKtp(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => bantuanMemberBaleTani(),
                  ));
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    //sebagai pengganti appar
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   height: 60,
                    //   width: double.infinity,
                    //   color: Color(0xff46838A),

                    //   // child: IconButton(
                    //   //   onPressed: () {
                    //   //     Navigator.of(context).push(MaterialPageRoute(
                    //   //       builder: (context) => PageGabungMitra(),
                    //   //     ));
                    //   //   },
                    //   //   icon: Icon(Icons.arrow_back),
                    //   // ),
                    // ),

                    // ini section untuk form form isi ktp nya
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: -8,
                                  blurRadius: 10,
                                  offset: Offset(0, 0))
                            ],
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            labelForm(label: "NIK", controller: nikC),
                            labelForm(label: "Nama", controller: nameC),
                            labelForm(
                                label: "Tempat Lahir",
                                controller: tempatLahirC),
                            labelForm(
                                label: "Tanggal Lahir", controller: tglLahirC),
                            labelForm(label: "Alamat", controller: alamatC),

                            labelForm(
                              label: "RT",
                              controller: rtC,
                            ),
                            labelForm(
                              label: "RW",
                              controller: rwC,
                            ),
                            labelForm(
                              label: "Kel/Desa",
                              controller: kelDesC,
                            ),
                            labelForm(
                              label: "Kecamatan",
                              controller: kcmtnC,
                            ),
                            labelForm(
                              label: "Kabupaten",
                              controller: kabC,
                            ),
                            labelForm(
                              label: "Provinsi",
                              controller: provC,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Foto KTP",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 20,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      selectImage();
                                      // setState(() {});
                                    },
                                    child: Text(
                                      "Pilih File",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // default gambar ketika belum pilih gambar untuk foto ktp
                            selectedImagePath == ''
                                ? Image.network(
                                    '${urlHttp.urlHTTP.uri}uploads/${fotoKtp}',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('tidak dapat memuat gambar');
                                    },
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    File(selectedImagePath),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('tidak dapat memuat gambar');
                                    },
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                            SizedBox(height: 30),
                            //foto selfie dgn ktp
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Selfie KTP",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 20,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      selectImageSelfieKtp();
                                      // setState(() {});
                                    },
                                    child: Text(
                                      "Pilih File",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // default gambar ketika belum pilih gambar untuk foto selfie dgn ktp
                            selectedImagePathSelfieKtp == ''
                                ? Image.network(
                                    '${urlHttp.urlHTTP.uri}uploads/selfie/${fotoSelfieKtp}',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text(
                                          'tidak dapat memuat gambar selfie');
                                    },
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    File(selectedImagePathSelfieKtp),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('tidak dapat memuat gambar');
                                    },
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                            Divider(
                              color: Colors.black,
                              height: 5,
                              thickness: 0.5,
                              indent: 1,
                              endIndent: 5,
                            ),
                            // button upload
                            ElevatedButton(
                              onPressed: () {
                                uploadData();
                              },
                              child: Text("Ubah Data"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  //fungsi untuk menjalankan file pick nya
  Future<void> selectImage() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            // var pickedImage = await picker.pickImage(
                            //     source: ImageSource.gallery);
                            // _image = File(selectedImagePath);
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {
                                _image = File(selectedImagePath);
                                print(_image);
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/gallery.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  Text('Gallery'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/img/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> selectImageSelfieKtp() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePathSelfieKtp =
                                await selectImageFromGallery();
                            // var pickedImage = await picker.pickImage(
                            //     source: ImageSource.gallery);
                            // _image = File(selectedImagePath);
                            print('Image_Path:-');
                            print(selectedImagePathSelfieKtp);
                            if (selectedImagePathSelfieKtp != '') {
                              Navigator.pop(context);
                              setState(() {
                                _imageSelfieKtp =
                                    File(selectedImagePathSelfieKtp);
                                //print(_imageSelfieKtp);
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/gallery.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  Text('Gallery'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/img/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // fungsi untuk ambil dari galeri
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }

    // var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //   _image = File(pickedImage!.path);
    // });
  }

  // fungsi untuk ambil dari galeri
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}

//extract widget untuk form nya
class labelForm extends StatelessWidget {
  // const labelForm({super.key});
  labelForm(
      {required this.label,
      required this.controller,
      this.width = 200,
      this.height = 30,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.marginL = 20});

  late String label;
  late TextEditingController controller;
  late double width;
  late double height;
  late MainAxisAlignment mainAxisAlignment;
  late double marginL;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Container(
            width: width,
            height: height,
            margin: EdgeInsets.only(left: marginL),
            child: TextField(
              controller: controller,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // labelText: "Nama",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
