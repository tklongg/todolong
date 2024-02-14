import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoPriorityChoose extends StatelessWidget {
  final int? priority;
  final ValueChanged<int>? setPriority;
  const TodoPriorityChoose({super.key, this.priority, this.setPriority});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Container(
              child: const Row(
            children: [
              Icon(
                Icons.flag,
                size: 24,
                color: Color(0xFFD1453A),
              ),
              SizedBox(width: 15),
              Text('Priority 1',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ".SF Pro Text",
                    fontSize: 18,
                  ))
            ],
          )),
          onPressed: () {
            setPriority!(1);
            Navigator.pop(context, 1);
          },
        ),
        CupertinoActionSheetAction(
          child: Container(
              child: const Row(
            children: [
              Icon(
                Icons.flag,
                size: 24,
                color: Color(0xFFEC8711),
              ),
              SizedBox(width: 15),
              Text('Priority 2',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ".SF Pro Text",
                    fontSize: 18,
                  ))
            ],
          )),
          onPressed: () {
            setPriority!(2);
            Navigator.pop(context, 2);
          },
        ),
        CupertinoActionSheetAction(
          child: Container(
              child: const Row(
            children: [
              Icon(
                Icons.flag,
                size: 24,
                color: Color(0xFF236FDE),
              ),
              SizedBox(width: 15),
              Text('Priority 3',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ".SF Pro Text",
                    fontSize: 18,
                  ))
            ],
          )),
          onPressed: () {
            setPriority!(3);
            Navigator.pop(context, 4);
          },
        ),
        CupertinoActionSheetAction(
          child: Container(
              child: const Row(
            children: [
              Icon(
                Icons.flag,
                size: 24,
                color: Colors.grey,
              ),
              SizedBox(width: 15),
              Text('Priority 4',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ".SF Pro Text",
                    fontSize: 18,
                  ))
            ],
          )),
          onPressed: () {
            setPriority!(4);
            Navigator.pop(context, 4);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel',
            style: TextStyle(
                color: Colors.black,
                fontFamily: ".SF Pro Text",
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
