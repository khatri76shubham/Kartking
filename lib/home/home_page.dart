import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/favorite_store.dart';
import 'package:kartking/items_view_all.dart';
import 'package:kartking/my_account.dart';
import 'package:kartking/home/single_store.dart';
import '../pages/product_overview/product_view.dart';
import '../pages/store_overview/storeview.dart';

// ignore: camel_case_types
class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget divider() {
    return const Divider(
      color: Colors.grey,
      height: 30,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  final imageurl = [
    'https://5.imimg.com/data5/BM/DV/KV/ANDROID-92423289/product-jpeg-500x500.jpg',
    'https://thumbs.dreamstime.com/z/many-used-modern-electronic-gadgets-use-white-floor-reuse-recycle-concept-top-view-153892434.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb1JxcBa6I2ikBu_VnV2ogxHrwnOAL9IxrOg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFwWUbSX87XZTO3pe3CIcfJRQUA-sMRZQieQ&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          backgroundColor: primarycolor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Myaccount()),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 20,
                    child: Icon(Icons.person),
                  )),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("store").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListView(
                  children: [
                    CarouselSlider.builder(
                      itemCount: imageurl.length,
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height),
                      itemBuilder: (context, index, realIndex) {
                        final imgurl = imageurl[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primarycolor,
                            boxShadow: [
                              BoxShadow(
                                color: primarycolor,
                                offset: const Offset(7, 10), //(x,y)
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.network(
                            imgurl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Itemsviewall()));
                            },
                            child: const Text(
                              'view all',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: item(),
                    ),
                    divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Near you',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) =>
                              Singlestore(index: index)),
                    ),
                    divider(),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("favoritedata")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection("favoritestore")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'favorite store',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 10.0,
                                    ),
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) =>
                                        Favoritestore(index: index)),
                              ),
                              divider(),
                            ],
                          );
                        }),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Stores',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Storeview(
                                        Index: snapshot.data?.docs[index])));
                              },
                              child: Material(
                                elevation: 3,
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                  height: size.height / 2.5,
                                  width: size.width / 1.1,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: size.height / 4,
                                        width: size.width / 1.1,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data?.docs[index]["simage"]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 12,
                                        width: size.width / 1.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data?.docs[index]
                                                  ["sname"],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              height: size.height / 25,
                                              width: size.width / 7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                snapshot.data?.docs[index]
                                                    ['srating'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${snapshot.data?.docs[index]["slocation"]}",
                                              style: const TextStyle(
                                                fontSize: 12.9,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          RatingBarIndicator(
                                            rating: double.parse(snapshot
                                                .data?.docs[index]['srating']),
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.red,
                                            ),
                                            itemCount: 5,
                                            itemSize: 25.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ],
                ),
              );
            }));
  }

  Widget item() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("store").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 10.0,
              ),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                var name = snapshot.data!.docs[index];
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("store")
                        .doc(name['sname'])
                        .collection("items")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 5.0,
                          ),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Productview(
                                          sid: name,
                                          itemnu: snapshot.data?.docs[index],
                                        )));
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 1,
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot.data
                                                  ?.docs[index]["iimage"]))),
                                    ),
                                    Expanded(
                                        child: Center(
                                      child: Text(
                                          snapshot.data?.docs[index]["iname"]),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          });
                    });
              }));
        });
  }
}
