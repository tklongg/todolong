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
            CupertinoIcons.arrow_counterclockwise,
            size: 24,
            color: Color(0xffd2d2d2),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,  
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffd2d2d2),width: 0.3)),
              ),
              child: Text(data,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: '.SF Pro Text')),
            ),
          )
        ]),
      ),
    );
  }
}
