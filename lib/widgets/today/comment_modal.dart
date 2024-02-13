import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolong/widgets/auth/comment_widget.dart';

class CommentModal extends StatefulWidget {
  const CommentModal({super.key});

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  // final bool isInputing = false;
  // double keyboardHeight = 0.0;
  // @override
  // void initState() {
  //   super.initState();
  //   // SystemChannels.textInput.invokeMethod('TextInput.show');
  // }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // });
    // print("cout<<height<<todo: ");
    // print(MediaQuery.of(context).size.height * 1);
    // print("cout<<width<<todo: ");
    // print(MediaQuery.of(context).size.width * 1);
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: Container(
            // width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              // alignment: Alignment.topCenter,
              // alignment: Alignment.center,
              children: [
                buildTopModal(context),
                Align(
                  alignment: Alignment.center,
                  child: buildImage(context),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: buildCommentSection3(context)),
                )
                // const SizedBox(height: 10,width: 10),
              ],
            )));
  }

  Widget buildTopModal(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Đóng modal khi nhấn nút "Close"
            },
            child: const Text(
              'Close',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(0xFFD74638),
                fontSize: 16,
                fontFamily: ".SF Pro Text",
              ),
            ),
          ),
          const Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: ".SF Pro Text",
            ),
          ),
          const Icon(
            Icons.info_outline,
            color: Color(0xFFD74638),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    Widget img;

    if (kIsWeb) {
      img = Image.asset('comment-bg.jpg');
    } else {
      img = Image.asset(
        'assets/comment-bg.jpg',
      );
    }
    Widget a = Container(
        // margin: keyboardHeight == 0.0 ? EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.19) : const EdgeInsets.only(top: 10),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.19),
        child: Column(children: [
          img,
          const SizedBox(height: 10, width: 10),
          const Text("Add relevant notes, links, or files to this task.")
        ]));

    return a;
  }

  // Widget buildCommentSection2(BuildContext context, double keyboardHeight) {
  //   return SendMessageWidget(
  //     keyboardHeight: keyboardHeight,
  //   );
  // }
  Widget buildCommentSection3(BuildContext context) {
    return SendMessageWidget();
  }

  Widget buildCommentSection(BuildContext context, double keyboardHeight) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            onTap: () {
              print("hahaha");
              print(MediaQuery.of(context).viewInsets.bottom);
            },
            decoration: const InputDecoration(
              // border: OutlineInputBorder(),
              hintText: 'Enter your comment',
              hintStyle: TextStyle(
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFFc6c6c6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
