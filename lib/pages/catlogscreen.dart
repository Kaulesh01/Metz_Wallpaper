import 'package:flutter/material.dart';

import '../utls/catagories_model.dart';

import 'package:metz_wallpaper/data.dart';

class catlogscreen extends StatefulWidget {
  const catlogscreen();

  @override
  State<catlogscreen> createState() => _catlogscreenState();
}

class _catlogscreenState extends State<catlogscreen> {
  List<CategorieModel> categories = new List();
  @override
  void initState() {
    //getWallpaper();

    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                '  Catogories:',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
                padding: EdgeInsets.only(bottom: 135),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
