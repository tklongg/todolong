import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider_pref.dart';
import 'package:todolong/widgets/todo/carousel/carousel.dart';

class AddTodo extends StatefulWidget {
  final int? parentId;
  const AddTodo({super.key, this.parentId});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late FocusNode _titleFocusNode;
  String title = '';
  String description = '';
  DateTime now = DateTime.now();
  DateTime? dueDate;
  Duration? reminder;

  int test = 0;
  int priority = 4;
  // int? parentId;

  void setDueDate(DateTime value) {
    setState(() {
      dueDate = value;
    });
  }

  void setReminder(Duration? time) {
    setState(() {
      reminder = time;
    });
    print("reminder<<<");
    print(reminder);
  }

  void setPriority(int value) {
    setState(() {
      priority = value;
    });
  }

  @override
  void initState() {
    super.initState();
    dueDate = DateTime(now.year, now.month, now.day);
    _titleFocusNode = FocusNode(); // Khởi tạo FocusNode
    _titleFocusNode.requestFocus(); // Tự động focus vào ô title
  }

  @override
  void dispose() {
    _titleFocusNode.dispose(); // Hủy bỏ FocusNode khi widget bị hủy
    super.dispose();
  }

  void submit() {
    final todo = Todo(
        title: title,
        description: description.isEmpty ? null : description,
        dueDate: dueDate,
        reminder: reminder,
        priority: priority,
        parentId: widget.parentId);
    print(todo.toJson());
    Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
    print("ok added");
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
                      submit();
                      Navigator.of(context).pop();
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
