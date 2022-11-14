import 'package:flutter/material.dart';
import 'package:metz_wallpaper/pages/search.dart';

class userpage extends StatefulWidget {
  const userpage();

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  final searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.8,
              ],
              colors: [
                Colors.deepPurpleAccent,
                Colors.black26,
              ],
            )),
            child: Column(children: [
              AppBar(
                backgroundColor: Colors.deepPurpleAccent,
                title: Text('Metz wallpapper'),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      maxRadius: 60,
                      backgroundImage: AssetImage('assets/profile.png'))),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'PROFILE :',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30),
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
                          hintText: "search wallpapers",
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
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              _itembar("LOGIN IN", Icon(Icons.person)),
              _itembar("RATEAPP", Icon(Icons.star_border)),
              _itembar("FAVORITE WALLPAPER", Icon(Icons.favorite_border)),
            ]),
          ),
        ),
      ),
    );
  }
}
//https://thumbs.dreamstime.com/b/anonimos-icon-profie-social-network-over-color-background-differnt-uses-icon-social-profile-148257454.jpg

_itembar(String bartext, Icon icondata) {
  return InkWell(
    child: Container(
      height: 50,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16.0,
            spreadRadius: 5.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
        color: Colors.black12,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              bartext,
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: icondata,
          ),
        ],
      ),
    ),
  );
}
