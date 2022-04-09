import 'package:flutter/material.dart';
import 'package:kartking/add_delivery_address.dart';
import 'package:kartking/address_model.dart';
import 'package:kartking/address_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/single_address.dart';
import 'package:provider/provider.dart';

class location extends StatefulWidget {
  location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  @override
  Widget build(BuildContext context) {
    addressprovider addressProvider = Provider.of(context);
    addressProvider.getaddressdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('My address'),
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Adddeliveryaddress()));
                },
                child: Text(
                  "+ Add Address",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                )),
            Divider(
              color: textcolor,
            ),
            Text('Saved Address'),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text("Deliver To"),
            ),
            Divider(
              height: 1,
            ),
            addressProvider.getaddresslist.isEmpty
                ? Center(
                    child: Container(
                      child: Center(
                        child: Text("No Data"),
                      ),
                    ),
                  )
                : Column(
                    children: addressProvider.getaddresslist.map<Widget>((e) {
                      return SingleDeliveryItem(
                        address:
                            "area, ${e.area}, street, ${e.street}, landmark ${e.landMark}, pincode ${e.pinCode}",
                        title: "${e.name}",
                        number: "${e.mobileNo}",
                        addressType: e.addressType == "Addresstype.Home"
                            ? "Home"
                            : e.addressType == "Addresstypes.Other"
                                ? "Other"
                                : "Work",
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
