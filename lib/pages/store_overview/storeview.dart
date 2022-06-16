import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/favorite.dart';
import 'package:kartking/pages/inside_store_search.dart';
import 'package:kartking/pages/product_overview/product_card.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Storeview extends StatefulWidget {
  final Index;
  Storeview({Key? key, this.Index}) : super(key: key);

  @override
  State<Storeview> createState() => _StoreviewState();
}

class _StoreviewState extends State<Storeview> {
  @override
  Widget build(BuildContext context) {
    String storename = widget.Index['sname'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.Index['sname'],
            style: TextStyle(color: textcolor),
          ),
          backgroundColor: primarycolor,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: Searchinside(index: widget.Index));
                },
                icon: Icon(Icons.search)),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("store")
              .doc("$storename")
              .collection('items')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.Index['simage']),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.7), BlendMode.dstIn),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.Index['sname'],
                                    style: TextStyle(
                                      color: textcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(
                                            widget.Index['srating']),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.red,
                                        ),
                                        itemCount: 5,
                                        itemSize: 40.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        "Reviews",
                                        style: TextStyle(
                                          color: textcolor,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Favorite(
                                  simage: widget.Index['simage'],
                                  slocation: widget.Index['slocation'],
                                  srating: widget.Index['srating'],
                                  sname: widget.Index['sname'])
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.Index['slocation'],
                            style: TextStyle(
                                color: textcolor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Your Favourite',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 1.2,
                                color: Colors.grey,
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) => Productcard(
                            product: snapshot.data?.docs[index],
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => productview(
                                        sid: widget.Index,
                                        itemnu: snapshot.data?.docs[index],
                                      )));
                            },
                          )),
                )
              ],
            );
          },
        ));
  }
}
