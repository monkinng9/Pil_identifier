import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({Key? key}) : super(key: key);

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
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

  Future getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Text("Please pick a Image to upload")
                : Image.file(selectedImage!),
            TextButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: uploadImage,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  "Upload",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
