import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:metz_wallpaper/widget/widgets.dart';

import 'package:http/http.dart' as http;

import '../data.dart';
import '../utls/photos_model.dart';

class trending extends StatefulWidget {
  @override
  State<trending> createState() => _trendingState();
}

class _trendingState extends State<trending> {
  List<PhotosModel> photos = new List();
  getWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=mobile%20wallpaper%204k&per_page=240&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    //getWallpaper();
    getWallpaper();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                '   Trending Wallpapers:',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            wallPaper(photos, context),
            SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
