import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final List<String>? labels;
  const LabelWidget({super.key, this.labels});
  void showLabel(context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => Center(
                child: AlertDialog(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              content: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey[300]!),
                //   borderRadius: BorderRadius.circular(0),
                // ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Column(children: [
                  const Text(
                    "Labels",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: ".SF Pro Text",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Image.asset(
                        kIsWeb ? "random.gif" : "assets/random.gif"),
                  ),
                  const Text(
                    "Label is not yet developed please stay tune for more",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ".SF Pro Text",
                      fontSize: 16,
                    ),
                  )
                ]),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showLabel(context);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        // height: 40,
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.tag,
              size: 15,
              color: const Color(0xFF6D6D6D),
            ), // Icon của mục
            SizedBox(width: 5),
            Text("Label",
                style: const TextStyle(
                  color: Color(0xFF6D6D6D),
                  fontFamily: ".SF Pro Text",
                  fontSize: 16,
                )), // Label của mục
          ],
        ),
      ),
    );
  }
}
