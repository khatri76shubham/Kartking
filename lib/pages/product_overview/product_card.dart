import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class Productcard extends StatelessWidget {
  const Productcard({Key? key, required this.product, required this.press})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final product;

  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: whitecolor,
            border: Border.all(color: primarycolor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image(image: NetworkImage(product['iimage']))),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product['iname'],
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(color: primarycolor, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            product['iprice'],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
