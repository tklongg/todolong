import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentSearchBtn extends StatelessWidget {
  final String data;

  const RecentSearchBtn({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {},
        child: Row(children: [
          const SizedBox(
            width: 20,
          ),
          const Icon(
            CupertinoIcons.clock,
            size: 24,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffd2d2d2))),
              ),
              child: Text(data, style: const TextStyle(color: Colors.black)),
            ),
          )
        ]),
      ),
    );
  }
}
