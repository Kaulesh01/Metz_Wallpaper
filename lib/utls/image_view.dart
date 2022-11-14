import 'dart:io';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
//import 'dart:js' as js;

class ImageView extends StatefulWidget {
  final String imgPath;

  const ImageView({key, this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Future<void> _setwallpaper_home() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imgPath);
    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    Navigator.pop(context);
    return _toast("Wallpaper set On Home Screen");
  }

  Future<void> _setwallpaper_lock() async {
    int location = WallpaperManager.LOCK_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imgPath);
    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    Navigator.pop(context);

    return _toast("Wallpaper set On Lock Screen");
  }

  Future<void> _setwallpaper_both() async {
    int location = WallpaperManager.BOTH_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imgPath);
    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    Navigator.pop(context);
    return _toast("Wallpaper set On Both Screen");
  }

  _toast(String toastmsg) {
    return Fluttertoast.showToast(
        msg: toastmsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black26,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.imgPath))),
              child: Stack(children: <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                Hero(
                  tag: widget.imgPath,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 16.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                              1.0, 1.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: kIsWeb
                        ? Image.network(widget.imgPath, fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl: widget.imgPath,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xfff5f8fd),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 5),
              alignment: AlignmentDirectional.topStart,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Apply'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: _setwallpaper_home,
                                  child: Text('SET HOMESCREEN')),
                              TextButton(
                                  onPressed: _setwallpaper_lock,
                                  child: Text('SET LOCKSCREEN')),
                              TextButton(
                                  onPressed: _setwallpaper_both,
                                  child: Text('SET BOTH')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel')),
                            ],
                          ),
                        );
                      },
                      child: RawMaterialButton(
                        elevation: 2.0,
                        fillColor: Colors.deepPurpleAccent,
                        child: Icon(
                          Icons.download,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await Permission.photos;
    } else {
      /* PermissionStatus permission = */ await Permission.storage;
    }
  }
}
