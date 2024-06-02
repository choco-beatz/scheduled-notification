import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cards extends StatelessWidget {
  final String text;
  final String time;
  const Cards({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          )),
    );
  }
}
