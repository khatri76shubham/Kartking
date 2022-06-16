// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:kartking/add_address_detail.dart';
import 'package:kartking/provider/address_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/google_map.dart';
import 'package:provider/provider.dart';

class Adddeliveryaddress extends StatefulWidget {
  const Adddeliveryaddress({Key? key}) : super(key: key);

  @override
  State<Adddeliveryaddress> createState() => _AdddeliveryaddressState();
}

enum Addresstype { Home, Work, Other }

class _AdddeliveryaddressState extends State<Adddeliveryaddress> {
  var mytype = Addresstype.Home;

  @override
  Widget build(BuildContext context) {
    Addressprovider addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: addressProvider.isloading == false
            ? MaterialButton(
                onPressed: () {
                  addressProvider.vaildator(context, mytype);
                },
                color: primarycolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'save',
                  style: TextStyle(color: textcolor),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Googlemap()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primarycolor,
                        offset: const Offset(1.0, 3.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  height: 47,
                  width: double.infinity,
                  child: Center(
                      child: addressProvider.setlocation == null
                          ? const Text('Set location')
                          : const Text("Done")),
                ),
              ),
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: whitecolor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: textcolor,
                    offset: const Offset(0.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const ListTile(
                    title: Text("Address Type"),
                  ),
                  RadioListTile(
                    value: Addresstype.Home,
                    groupValue: mytype,
                    title: const Text('Home'),
                    secondary: const Icon(Icons.home),
                    onChanged: (Addresstype? value) {
                      setState(() {
                        mytype = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    value: Addresstype.Work,
                    groupValue: mytype,
                    title: const Text('Work'),
                    secondary: const Icon(Icons.work),
                    onChanged: (Addresstype? value) {
                      setState(() {
                        mytype = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    value: Addresstype.Other,
                    groupValue: mytype,
                    title: const Text('Others'),
                    secondary: const Icon(Icons.other_houses_outlined),
                    onChanged: (Addresstype? value) {
                      setState(() {
                        mytype = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: whitecolor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: textcolor,
                    offset: const Offset(0.0, 2.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Addressdetail(
                      controller: addressProvider.name,
                      keboardtype: TextInputType.text,
                      labtext: "Name",
                      max: 20,
                    ),
                    Addressdetail(
                      controller: addressProvider.mobileno,
                      keboardtype: TextInputType.phone,
                      labtext: "Mobile no.",
                      max: 10,
                    ),
                    Addressdetail(
                      controller: addressProvider.area,
                      keboardtype: TextInputType.text,
                      labtext: "Area/society",
                      max: 50,
                    ),
                    Addressdetail(
                      controller: addressProvider.street,
                      keboardtype: TextInputType.text,
                      labtext: "street",
                      max: 50,
                    ),
                    Addressdetail(
                      controller: addressProvider.landmark,
                      keboardtype: TextInputType.text,
                      labtext: "landmark",
                      max: 50,
                    ),
                    Addressdetail(
                      controller: addressProvider.city,
                      keboardtype: TextInputType.text,
                      labtext: "city",
                      max: 20,
                    ),
                    Addressdetail(
                        controller: addressProvider.state,
                        keboardtype: TextInputType.text,
                        labtext: "state",
                        max: 20),
                    Addressdetail(
                      controller: addressProvider.pincode,
                      keboardtype: TextInputType.number,
                      labtext: "pincode",
                      max: 6,
                    ),
                  ],
                ),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
