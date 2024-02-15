import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';
import 'package:todolong/widgets/todo/todo_item/todo_priority_circle.dart';

class TodoItemDetail extends StatefulWidget {
  final Todo todo;
  // const TodoItemDetail({super.key});
  const TodoItemDetail({super.key, required this.todo});

  @override
  State<TodoItemDetail> createState() => _TodoItemDetailState();
}

class _TodoItemDetailState extends State<TodoItemDetail> {
  @override
  Widget build(BuildContext context) {
    double columnGap = MediaQuery.of(context).size.height * 0.02;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          // color: Colors.green,
          child: Column(children: [
            buildPriorityTitle(context),
            SizedBox(height: columnGap),
            buildDescription(context),
            // const Divider(),
            SizedBox(height: columnGap),
            buildSchedule(context),
            SizedBox(height: columnGap),
            buildPriorityChoosing(context),
            SizedBox(height: 5),
            buildCarousel(),
            // SizedBox(height: columnGap),
            // const Divider(),
            SizedBox(height: 5),
            buildSubtaskArea(),
            SizedBox(height: 5),
            buildCommentArea(),
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey[300]!),
              // ),
              height: MediaQuery.of(context).size.height * 0.2,
            )
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
            // Text("comments (show latest)"),
          ]),
        ),
      ),
    );
  }

  Widget rowGap() {
    return const SizedBox(
      width: 10,
    );
  }

  Widget buildPriorityTitle(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.all(1.0),
            child: TodoPriorityCircle(prior: widget.todo.priority)),
        const SizedBox(width: 10),
        Text(
          widget.todo.title,
          style: const TextStyle(
            fontFamily: ".SF Pro Text",
            fontSize: 18,
          ),
        )
      ],
    );
  }

  Widget buildDescription(context) {
    Widget a;
    if (widget.todo.description != null) {
      a = Text(
        widget.todo.description ?? "",
        style: const TextStyle(
          fontFamily: ".SF Pro Text",
          fontSize: 17,
        ),
      );
    } else {
      a = Container();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.format_list_bulleted,
          size: 24,
          color: Colors.black38,
        ),
        const SizedBox(width: 10),
        a,
        const Divider()
      ],
    );
  }

  Widget buildSchedule(BuildContext context) {
    Color? color = Colors.black38;
    String dateString = widget.todo.dueDate == null
        ? "Due Date"
        : DateFormat('dd MMM - EEEE').format(widget.todo.dueDate!);

    if (widget.todo.dueDate != null) {
      DateTime today = DateTime.now();
      DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
      if (widget.todo.dueDate!.isBefore(today)) {
        // Quá hạn
        color = Colors.red;
      } else if (widget.todo.dueDate!.day == today.day &&
          widget.todo.dueDate!.month == today.month &&
          widget.todo.dueDate!.year == today.year) {
        // Hôm nay
        color = Colors.green;
      } else if (widget.todo.dueDate!.day == tomorrow.day &&
          widget.todo.dueDate!.month == tomorrow.month &&
          widget.todo.dueDate!.year == tomorrow.year) {
        // Ngày mai
        color = Colors.yellow.shade800;
      } else {
        // Các trường hợp còn lại
        color = Colors.purple;
      }
    } else {
      color = Colors.grey[600];
    }

    return GestureDetector(
      onTap: () {
        print("xdx");
      },
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.calendar_today_outlined,
              size: 26,
              color: color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(dateString,
              style: const TextStyle(
                fontFamily: ".SF Pro Text",
                fontSize: 17,
              )),
        ],
      ),
    );
  }

  Widget buildPriorityChoosing(context) {
    Color color;
    switch (widget.todo.priority) {
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = Colors.yellow;
        break;
      case 3:
        color = Colors.green;
        break;
      case 4:
        color = Colors.grey;
        break;
      default:
        color = Colors.black;
        break;
    }

    return GestureDetector(
      onTap: () {
        showPriorityActionSheet(context, widget.todo.priority);
      },
      child: Row(
        children: [
          Icon(
            Icons.flag,
            size: 24,
            color: color,
          ),
          const SizedBox(width: 10),
          Text('Priority ${widget.todo.priority}',
              style: const TextStyle(
                fontFamily: ".SF Pro Text",
                fontSize: 17,
              )),
        ],
      ),
    );
  }

  void showPriorityActionSheet(BuildContext context, int currentPriority) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
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
                widget.todo.priority = 1;
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
                widget.todo.priority = 2;
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
                widget.todo.priority = 3;
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
                widget.todo.priority = 4;
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
      },
    );
  }

  Widget buildCarousel() {
    List<String> carouselItems = [
      'Label',
      'Reminder',
      'Location',
      'Descriptiona'
    ];

    return Container(
      height: 70, // Đặt chiều cao tùy ý của carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Cho phép cuộn ngang
        itemCount: carouselItems.length,
        itemBuilder: (BuildContext context, int index) {
          return buildItem(index);
        },
      ),
    );
  }

  Widget buildItem(int index) {
    List<String> items = ["Label", "Reminder", "Location", "Descriptiona"];
    List<IconData> icons = [
      Icons.tag,
      Icons.notifications,
      Icons.location_on,
      Icons.description
    ];
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // height: 40,
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icons[index],
            size: 15,
            color: Color(0xFF6D6D6D),
          ), // Icon của mục
          SizedBox(width: 5),
          Text(items[index],
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
                fontFamily: ".SF Pro Text",
                fontSize: 16,
              )), // Label của mục
        ],
      ),
    );
  }

  Widget buildSubtaskArea() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            // dense: true,
            // horizontalTitleGap: 0.0,
            // minLeadingWidth: 0,
            child: ExpansionTile(
                title: Text("Sub-tasks ${widget.todo.subtasks!.length >> 0}",
                    style: const TextStyle(
                      fontFamily: ".SF Pro Text",
                      fontSize: 16,
                    )),
                collapsedBackgroundColor:
                    Colors.transparent, // Đặt màu nền khi thu gọn là trong suốt
                tilePadding: EdgeInsets.zero,
                // trailing: const SizedBox.shrink(),
                children: widget.todo.subtasks!.isNotEmpty
                    ? buildSubTasks()
                    : [buildEmptySubtask()]),
          )),
    );
  }

  Widget buildEmptySubtask() {
    return Container(
      child: Text("No subtask"),
    );
  }

  List<Widget> buildSubTasks() {
    return widget.todo.subtasks!.map((e) {
      return TodoItemWidget(
        todo: e,
        onCloseModal: () {},
        onOpenModal: () {},
      );
    }).toList();
  }

  Widget buildCommentArea() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text("Comments ${widget.todo.subtasks!.length >> 0}",
              style: const TextStyle(
                fontFamily: ".SF Pro Text",
                fontSize: 16,
              )),
          collapsedBackgroundColor:
              Colors.transparent, // Đặt màu nền khi thu gọn là trong suốt
          tilePadding:
              EdgeInsets.zero, // Loại bỏ padding mặc định của ExpansionTile
          childrenPadding:
              EdgeInsets.all(8), // Đặt khoảng cách giữa các children
          children: [
            ListTile(
              title: Text("Subtask 1"),
            ),
            ListTile(
              title: Text("Subtask 2"),
            ),
            ListTile(
              title: Text("Subtask 3"),
            ),
          ],
        ),
      ),
    );
  }
}

// class TodoItemDetail extends StatelessWidget {
  
// }
