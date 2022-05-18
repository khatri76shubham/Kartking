import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/product_overview/product_card.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class storeview extends StatelessWidget {
  final Index;
  storeview({Key? key, this.Index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String storename = Index['sname'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Index['sname'],
            style: TextStyle(color: textcolor),
          ),
          backgroundColor: primarycolor,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
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
                            image: NetworkImage(Index['simage']),
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
                                    Index['sname'],
                                    style: TextStyle(
                                      color: textcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(Index['srating']),
                                        itemBuilder: (context, index) => Icon(
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
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whitecolor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            Index['slocation'],
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                          sid: Index,
                                          itemnu: snapshot.data?.docs[index],
                                        )));
                              },
                            )),
                  ),
                )
              ],
            );
          },
        ));
  }
}
