import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class count extends StatefulWidget {
  count({Key? key}) : super(key: key);

  @override
  State<count> createState() => _countState();
}

class _countState extends State<count> {
  int count = 1;
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(color: textcolor),
            borderRadius: BorderRadius.circular(8)),
        child: istrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          istrue = false;
                        });
                      }
                      if (count > 1) {
                        setState(() {
                          count--;
                        });
                      }
                    },
                    child: Icon(Icons.remove, size: 15, color: textcolor),
                  ),
                  Text(
                    '$count',
                    style: TextStyle(
                        color: textcolor, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color: textcolor,
                    ),
                  )
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      istrue = true;
                    });
                  },
                  child: Text(
                    'add',
                    style: TextStyle(color: primarycolor),
                  ),
                ),
              ));
  }
}
