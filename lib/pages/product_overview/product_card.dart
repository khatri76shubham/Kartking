import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class Productcard extends StatelessWidget {
  const Productcard({Key? key, required this.product, required this.press})
      : super(key: key);

  final Product product;

  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: whitecolor,
            border: Border.all(color: primarycolor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(product.image)),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Container(
                      height: 40,
                      width: 70,
                      child: Center(
                        child: Text(
                          product.price,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: primarycolor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
