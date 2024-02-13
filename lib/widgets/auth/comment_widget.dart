import 'package:flutter/material.dart';

// class SendMessageWidget extends StatefulWidget {
//   final double keyboardHeight;

//   const SendMessageWidget({Key? key, required this.keyboardHeight})
//       : super(key: key);
//   @override
//   State<SendMessageWidget> createState() => _SendMessageWidgetState();
// }

// class _SendMessageWidgetState extends State<SendMessageWidget> {
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     print("cout<<keyboardheightnow");
//     print(widget.keyboardHeight);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       margin: const EdgeInsets.all(12),
//       color: Colors.grey[200],
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _textEditingController,
//               onTapOutside: (x) {
//                 FocusScope.of(context).unfocus();
//               },
//               onChanged: (text) {
//                 setState(() {});
//               },
//               decoration: const InputDecoration.collapsed(
//                 hintText: "Type your comment...",
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: _textEditingController.text.isNotEmpty
//                 ? () {
//                     // Handle sending message here
//                     print("Send message: ${_textEditingController.text}");
//                     // Clear text field after sending message
//                     _textEditingController.clear();
//                     // Close keyboard
//                     FocusScope.of(context).unfocus();
//                   }
//                 : null,
//           ),
//         ],
//       ),
//     );
//   }
// }

class SendMessageWidget extends StatelessWidget {
  SendMessageWidget({super.key});
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.all(12),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onTapOutside: (x) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (text) {},
              decoration: const InputDecoration.collapsed(
                hintText: "Type your comment...",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _textEditingController.text.isNotEmpty
                ? () {
                    // Handle sending message here
                    print("Send message: ${_textEditingController.text}");
                    // Clear text field after sending message
                    _textEditingController.clear();
                    // Close keyboard
                    FocusScope.of(context).unfocus();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
