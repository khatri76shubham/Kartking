import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'Kart king',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              'KARTKING ("Licensed Application") is a piece of software created to This application uses flutter technology for its build and delivers the daily household products door to door in a minimum span of time.It was created for the people who could not go out and purchase something in their difficult times whether it is any disease or any other problem so it is easy for them to place order on their smartphone at their location rather to go out.Old age people also will get benefit from this app as they can\'t walk much and now in current scenario almost every person has a smartphone so it will be much easier for them to buy products themselves needed where they are. — and customized for Android mobile devices ("Devices"). It is used to The main use of application is to deliver the goods and products near any locality in minimum span of time that will be helpful for every person whether it is young or old.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ));
  }
}
