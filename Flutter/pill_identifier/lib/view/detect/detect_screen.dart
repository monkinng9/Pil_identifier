import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'cropper/ui_helper.dart'
    if (dart.library.io) 'cropper/mobile_ui_helper.dart'
    if (dart.library.html) 'cropper/web_ui_helper.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({Key? key}) : super(key: key);

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  String? message = "";
  File? selectedImage;

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://e786-101-51-12-191.ngrok.io/upload"));

    final header = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(header);
    final reponse = await request.send();
    http.Response res = await http.Response.fromStream(reponse);
    final resJson = jsonDecode(res.body);
    message = resJson["message"];
    print(message);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _croppedFile?.path;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบุเม็ดยาด้วยรูปภาพ'),
        centerTitle: true,
        backgroundColor: HexColor("#DE614A"),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        // height: 450,
        // padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              insertImage(imagePath),
              Container(
                width: 146,
                height: 100,
                margin: const EdgeInsets.only(
                    top: 20, left: 92, right: 92, bottom: 84),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.black)),
                          elevation: MaterialStateProperty.all(4),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              HexColor("#FFFFFF")),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _clear();
                        },
                        child: const Text(
                          "ลบรูปภาพ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(4),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              HexColor("#DE614A")),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("ทำนายภาพ"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container insertImage(String? imagePath) {
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 56),
      width: 250,
      height: 250,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            _cropImage();
          },
          child: Column(
            children: [
              if (_croppedFile != null) ...[
                Container(
                    margin: const EdgeInsets.only(left: 31, right: 31, top: 21),
                    child: Image.file(File(imagePath!), fit: BoxFit.cover)),
              ] else ...[
                Container(
                    margin: const EdgeInsets.only(left: 31, right: 31, top: 21),
                    child: SvgPicture.asset("assets/add_image.svg")),
                const Text("กดเพื่อเพิ่มภาพเม็ดยา"),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> _cropImage() async {
    await _uploadImage();
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: buildUiSettings(context),
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}
