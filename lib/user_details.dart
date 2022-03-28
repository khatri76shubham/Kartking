import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class userdetail extends StatelessWidget {
  const userdetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.07),
              primary: Colors.black,
              padding: const EdgeInsets.all(8),
              shape: const StadiumBorder(),
              elevation: 5,
            ),
            child: const Text("Save")),
      ),
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primarycolor, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                cursorColor: textcolor,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Name'),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primarycolor, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                cursorColor: textcolor,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'E-mail'),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primarycolor, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
                cursorColor: textcolor,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Phone number"),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primarycolor, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                cursorColor: textcolor,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Address"),
              )),
        ],
      ),
    );
  }
}
