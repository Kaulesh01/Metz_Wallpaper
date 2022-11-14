import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metz_wallpaper/data.dart';

import '../utls/photos_model.dart';
import '../widget/widgets.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;

  CategorieScreen({@required this.categorie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotosModel> photos = new List();

  getCategorieWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=240&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Row(
                  children: [
                    Text("      "),
                    Text(
                      widget.categorie,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      " :",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              wallPaper(photos, context),
            ],
          ),
        ),
      ),
    );
  }
}
