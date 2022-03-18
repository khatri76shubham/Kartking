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
        padding: EdgeInsets.symmetric(horizontal: 0.8),
        decoration: BoxDecoration(
            color: whitecolor,
            border: Border.all(color: primarycolor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: product.title!,
              child: Image.asset(product.image!),
            ),
            Text(
              product.title!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
