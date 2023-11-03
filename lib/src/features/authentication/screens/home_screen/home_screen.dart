import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach_2/src/constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 170,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(banner),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 4),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Chat now"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Recents",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black87),
              borderRadius: BorderRadius.circular(22),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 2,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(0),
              children: List.generate(
                6,
                (index) => const Card(
                    shape: Border(), child: Center(child: Text("test"))),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Alerts",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            child: Placeholder(),
          ),
        )
      ],
    ));
  }
}

class AlertBoxes extends StatelessWidget {
  const AlertBoxes({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card(child: Column(children: [Icon(CupertinoIcons.phone)],),);
  }
}
