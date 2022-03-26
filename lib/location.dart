import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class location extends StatefulWidget {
  location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My address'),
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                child: Text(
              "+ Add Address",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            )),
            Divider(
              color: textcolor,
            ),
            Text('Saved Address'),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: textcolor, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        Text('500 m'), //distance from live location
                      ],
                    ),
                    Column(
                      children: [
                        Text('Home'),
                        Expanded(
                            child: Container(
                          width: 250,
                          height: 40,
                          child: Text(
                            '4-E-263,J.N.V colony , bikaner, rajasthan,334001',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ))
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: primarycolor,
                      child: Icon(
                        Icons.edit,
                        color: whitecolor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
