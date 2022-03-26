import 'package:flutter/material.dart';

Color primarycolor = const Color(0xff7E89F0);
Color textcolor = Colors.black;
Color whitecolor = Colors.white;

class Product {
  String title, image, price;

  Product({required this.title, required this.image, required this.price});
}

List<Product> demo_products = [
  Product(
      title: "Cabbage",
      image: "assets/images/img_1.png",
      price: "\u{20B9}${50}"),
  Product(
      title: "Broccoli",
      image: "assets/images/img_2.png",
      price: '\u{20B9}${20}'),
  Product(
      title: "Carrot",
      image: "assets/images/img_3.png",
      price: '\u{20B9}${60}'),
  Product(
      title: "Pakcoy",
      image: "assets/images/img_4.png",
      price: '\u{20B9}${30}'),
  Product(
      title: "Cucumber",
      image: "assets/images/img_1.png",
      price: '\u{20B9}${40}'),
  Product(
      title: "Cabbage",
      image: "assets/images/img_1.png",
      price: "\u{20B9}${50}"),
  Product(
      title: "Broccoli",
      image: "assets/images/img_2.png",
      price: '\u{20B9}${20}'),
  Product(
      title: "Carrot",
      image: "assets/images/img_3.png",
      price: '\u{20B9}${60}'),
];

class Restaurants {
  String imageUrl, title, locations, rating, price;

  Restaurants(
      {required this.imageUrl,
      required this.locations,
      required this.price,
      required this.rating,
      required this.title});
}

List<Restaurants> restaurantList = [
  //0
  Restaurants(
      title: "Om Sweet & Snacks",
      locations: "North Indian,  South Indian, Chinese",
      price: "100",
      rating: "4.2",
      imageUrl:
          "https://2rdnmg1qbg403gumla1v9i2h-wpengine.netdna-ssl.com/wp-content/uploads/sites/3/2016/05/worstSnacks-527905022-770x533-1-745x490.jpg"),
  //1
  Restaurants(
    title: "The Masala Story",
    locations: "North Indian, Mughlai, Kebab",
    price: "300",
    rating: "4.1",
    imageUrl:
        "https://c.ndtvimg.com/2020-01/a39okhfk_620_625x300_21_January_20.jpg",
  ),
  //2
  Restaurants(
    title: "Domino's Pizza",
    locations: "Pizza, Fast Food",
    price: "150",
    rating: "4.1",
    imageUrl:
        "https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1-500x500.jpg",
  ),
  //3
  Restaurants(
    title: "MCDonald's",
    locations: "Burger, Fast Food, Beverages",
    price: "150",
    rating: "4.1",
    imageUrl:
        "https://www.newfoodmagazine.com/wp-content/uploads/mcdonalds.jpg",
  ),
  //4
  Restaurants(
    title: "Gohana Faous Jalebi",
    locations: "Street Food, Mithai",
    price: "100",
    rating: "4.2",
    imageUrl: "https://pbs.twimg.com/media/EhHIY9CWsAA9rN9.jpg",
  ),
  //5
  Restaurants(
    title: "Burger King",
    locations: "Burger, American, Desserts",
    price: "150",
    rating: "4.2",
    imageUrl:
        "https://media1.s-nbcnews.com/j/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.fit-2000w.jpg",
  ),
  //6
  Restaurants(
    title: "Haldiram's",
    locations: "North Indian, Mithai, South Indian",
    price: "100",
    rating: "4.0",
    imageUrl:
        "https://media.self.com/photos/5ebd7a636ed447b59b846244/4:3/w_2560%2Cc_limit/snack-plate.jpg",
  ),
];
