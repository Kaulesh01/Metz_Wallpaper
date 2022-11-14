import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metz_wallpaper/data.dart';
import 'package:metz_wallpaper/pages/catogories_screen.dart';
import 'package:metz_wallpaper/pages/search.dart';

import 'package:metz_wallpaper/widget/widgets.dart';

import 'package:http/http.dart' as http;

import '../utls/catagories_model.dart';
import '../utls/photos_model.dart';

class homescreen extends StatefulWidget {
  const homescreen();

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<CategorieModel> categories = [];
  List<PhotosModel> photos = [];

  getTrendingWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=mobile%20wallpape&per_page=240&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  final searchController = new TextEditingController();

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    categories = getCategories();
    super.initState();
    getTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  height: 150,
                  child: ListView(
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorieScreen(
                                        categorie: "winter wallpapers",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 150,
                          width: 375,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2VEsKGSg-SCT87aIQkh2gLEro0nz4KhDu-w&usqp=CAU"),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorieScreen(
                                        categorie: "Space wallpapers",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 150,
                          width: 375,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/space.jpg'),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorieScreen(
                                        categorie: "minimal",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 150,
                          width: 375,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/minimal.jpg'),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorieScreen(
                                        categorie: "4k wallpapers",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 150,
                          width: 375,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/4k.jpg"),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 16.0,
                        spreadRadius: 5.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        textAlign: TextAlign.center,
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "    search wallpapers",
                            border: InputBorder.none),
                      )),
                      InkWell(
                          onTap: () {
                            if (searchController.text != "") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView(
                                            search: searchController.text,
                                          )));
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.search)))
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        '  Recently Uploaded :',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    wallPaper(photos, context),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
