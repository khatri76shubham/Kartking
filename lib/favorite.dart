import 'package:flutter/material.dart';
import 'package:kartking/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import 'constant/colors.dart';

class Favorite extends StatefulWidget {
  String? sname;
  String? simage;
  String? srating;
  String? slocation;

  Favorite({Key? key, this.simage, this.slocation, this.sname, this.srating})
      : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of(context);
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: whitecolor,
      ),
      child: IconButton(
        alignment: Alignment.center,
        onPressed: () {
          favoriteProvider.addfavoriteData(
              simage: widget.simage,
              slocation: widget.slocation,
              sname: widget.sname,
              srating: widget.srating);
          setState(() {
            if (isfavorite) {
              isfavorite = false;
            } else {
              isfavorite = true;
            }
          });
        },
        color: Colors.red,
        icon: (isfavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border)),
      ),
    );
  }
}
