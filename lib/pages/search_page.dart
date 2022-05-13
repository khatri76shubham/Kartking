import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/data_controller.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class searchpage extends StatefulWidget {
  searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  final TextEditingController searchcontroller = TextEditingController();
//   List<Restaurants> _searched = [];
//   List<Product> _productsearch = [];

//   onsearch(String searche) {
//     setState(() {
//       _productsearch = demo_products
//           .where((Product) => Product.title.toLowerCase().contains(searche))
//           .toList();
//     });
//     setState(() {
//       _searched = restaurantList
//           .where((Restaurants) =>
//               Restaurants.title.toLowerCase().contains(searche))
//           .toList();
//     });
//   }
  QuerySnapshot? snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchdata() {
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshotData?.docs.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        storeview(Index: snapshotData?.docs[index])));
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(18),
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: whitecolor,
                      border: Border.all(color: primarycolor, width: 2),
                    ),
                    height: 400 / 2.5,
                    width: 500 / 1.1,
                    child: Column(
                      children: [
                        Container(
                          height: 350 / 4,
                          width: 500 / 1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshotData?.docs[index]['simage']),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          height: 350 / 12,
                          width: 500 / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshotData?.docs[index]['sname'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 350 / 25,
                                width: 500 / 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  snapshotData?.docs[index]['srating'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 500 / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${snapshotData?.docs[index]['slocation']}",
                                style: TextStyle(
                                  fontSize: 12.9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Text(
                              //   " ${user.price} for one",
                              //   style: TextStyle(
                              //     fontSize: 12.9,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GetBuilder<Datacontroller>(
            builder: (val) {
              return IconButton(
                  onPressed: () {
                    val.querydata(searchcontroller.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  },
                  icon: Icon(Icons.search));
            },
            init: Datacontroller(),
          )
        ],
        title: TextField(
          controller: searchcontroller,
          cursorColor: textcolor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            fillColor: primarycolor,
            filled: true,
            hintText: "search for items and stores",
          ),
        ),
        backgroundColor: primarycolor,
      ),
      body: isExecuted
          ? searchdata()
          : const Center(
              child: Text('search for items and stores'),
            ),
      // body: ListView(
      //   children: [
      //     ListView.builder(
      //       physics: ScrollPhysics(),
      //       shrinkWrap: true,
      //       itemCount: snapshotData?.docs.length ?? 0,
      //       itemBuilder: (context, index) {
      //         return searchbox(
      //           user: snapshotData?.docs[index],
      //           ontap: () {
      //             Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) =>
      //                     storeview(Index: snapshotData?.docs[index])));
      //           },
      //         );
      //       },
      //     ),
      //     ListView.builder(
      //         physics: ScrollPhysics(),
      //         shrinkWrap: true,
      //         itemCount: snapshotData?.docs.length ?? 0,
      //         itemBuilder: (context, index) => productseachbox(
      //               user: snapshotData?.docs[index],
      //               ontap: () {
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                     builder: (context) =>
      //                         productview(itemnu: snapshotData?.docs[index])));
      //               },
      //             )),
      //   ],
      // ),
    );
  }
}

// Widget productseachbox({required user, required ontap}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
//     child: GestureDetector(
//       onTap: ontap,
//       child: Material(
//         elevation: 3,
//         borderRadius: BorderRadius.circular(18),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(18)),
//             color: whitecolor,
//             border: Border.all(color: primarycolor, width: 2),
//           ),
//           height: 350 / 2.5,
//           width: 500 / 1.1,
//           child: Row(
//             children: [
//               Container(
//                 height: 350 / 2.5,
//                 width: 120 / 1.1,
//                 decoration: BoxDecoration(
//                     color: whitecolor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(18),
//                       bottomLeft: Radius.circular(18),
//                     ),
//                     image: DecorationImage(
//                         image: AssetImage(user['simage']), fit: BoxFit.cover)),
//               ),
//               Container(
//                 height: 350 / 2.5,
//                 width: 200 / 1.1,
//                 decoration: BoxDecoration(
//                   color: whitecolor,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(18),
//                     bottomRight: Radius.circular(18),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           user['sname'],
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Container(
//                           child: Text(
//                             "  ${user['iprice']} ",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "by shop name",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget searchbox({required user, required ontap}) {
//   return 
// }
