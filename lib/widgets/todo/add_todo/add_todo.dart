import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolong/widgets/todo/carousel/carousel.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late FocusNode _titleFocusNode;
  String title = '';
  String description = '';
  DateTime? dueDate = DateTime.now();
  DateTime? reminder;
  int test = 0;
  int priority = 4;
  void setDueDate(DateTime value) {
    dueDate = value;
  }

  void setReminder(DateTime value) {
    reminder = value;
  }

  void setPriority(int value) {
    priority = value;
  }

  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode(); // Khởi tạo FocusNode
    _titleFocusNode.requestFocus(); // Tự động focus vào ô title
  }

  @override
  void dispose() {
    _titleFocusNode.dispose(); // Hủy bỏ FocusNode khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.75,
            // width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    cursorColor: const Color(0xFFD74638),
                    focusNode: _titleFocusNode,
                    // Sử dụng FocusNode cho ô title
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'e.g Buy groceries at 8 PM',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: ".SF Pro Text",
                          fontSize: 20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: TextField(
                        cursorColor: const Color(0xFFD74638),
                        maxLines: null, // Cho phép nhiều dòng
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: ".SF Pro Text",
                              fontSize: 17),
                          border: InputBorder.none,
                        ),
                      )),
                ),
                Carousel(
                  dueDate: dueDate,
                  reminder: reminder,
                  priority: priority,
                  setDueDate: setDueDate,
                  setReminder: setReminder,
                  setPriority: setPriority,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                        bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.fromLTRB(0, 12, 10, 12),
                  child: GestureDetector(
                    onTap: () {
                      //handle add todo
                      print(1);
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD74638),
                        ),
                        height: 24,
                        width: 24,
                        // alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_upward_sharp,
                          size: 17,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
