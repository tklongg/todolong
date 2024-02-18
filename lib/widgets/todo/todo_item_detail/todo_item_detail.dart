import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider.dart';
import 'package:todolong/widgets/todo/carousel/carousel.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';
import 'package:todolong/widgets/todo/todo_item/todo_priority_circle.dart';
import 'package:todolong/widgets/todo/todo_item_detail/todo_change_title_desc.dart';
import 'package:todolong/widgets/todo/todo_schedule_picker/todo_schedule_picker.dart';

// class  extends StatefulWidget {

//   @override
//   State<TodoItemDetail> createState() => _TodoItemDetailState();
// }

class TodoItemDetail extends StatelessWidget {
  final Todo todo;
  // const TodoItemDetail({super.key});
  const TodoItemDetail({super.key, required this.todo});

  Widget itemGap() {
    return const SizedBox(
      width: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    double columnGap = MediaQuery.of(context).size.height * 0.025;
    print(MediaQuery.of(context).size.height);
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
            SizedBox(height: columnGap / 2),
            // buildCarousel(),
            Carousel(
              reminder: todo.reminder,
              setReminder: (Duration? reminder) {
                final newTodo = todo;
                newTodo.reminder = reminder;
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(todo.id!, newTodo);
                print("setReminder");
                print(reminder);
              },
            ),

            // SizedBox(height: columnGap),
            // const Divider(),
            const SizedBox(height: 5),
            buildSubtaskArea(),
            const SizedBox(height: 5),
            buildCommentArea(),
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey[300]!),
              // ),
              height: MediaQuery.of(context).size.height * 0.2,
            )
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
    print(MediaQuery.of(context).size.height);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(1.0),
            child: TodoPriorityCircle(
              prior: todo.priority,
              handleClick: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .completeTodo(todo.id!);
                // Navigator.pop(context);
              },
            )),
        // const SizedBox(width: 10),
        itemGap(),

        Flexible(
          child: GestureDetector(
            onTap: () {
              showChangeTitleModal(context);
            },
            child: Text(
              todo.title,
              softWrap: true,
              style: const TextStyle(
                  fontFamily: ".SF Pro Text",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow
                  .visible, // Để văn bản có thể tràn ra ngoài và hiển thị đầy đủ
            ),
          ),
        ),
      ],
    );
  }

  void showChangeTitleModal(
    BuildContext context,
  ) {
    void saveChange(String title, String desc) {
      final newTodo = todo;
      newTodo.title = title;
      newTodo.description = desc;
      Provider.of<TodoProvider>(context, listen: false)
          .updateTodo(todo.id!, newTodo);
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TodoChangeTitleDesc(
              description: todo.description!, title: todo.title,save: saveChange);
        });
  }

  Widget buildDescription(context) {
    Widget a;
    if (todo.description != null) {
      a = Flexible(
        child: GestureDetector(
          onTap: () {
            showChangeTitleModal(context);
          },
          child: Text(
            todo.description ?? "",
            softWrap: true,
            style: const TextStyle(
              fontFamily: ".SF Pro Text",
              fontSize: 18,
            ),
            overflow: TextOverflow
                .visible, // Để văn bản có thể tràn ra ngoài và hiển thị đầy đủ
          ),
        ),
      );
    } else {
      a = Container();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.format_list_bulleted,
          size: 24,
          color: Colors.black38,
        ),
        const SizedBox(width: 20),
        a,
        const Divider()
      ],
    );
  }

  Widget buildSchedule(BuildContext context) {
    Color iconColor = Colors.black;
    Color textColor = Colors.black;
    String labelText = "Today";

    if (todo.dueDate != null) {
      DateTime today = DateTime.now();
      DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);

      if (DateOnlyCompare(todo.dueDate!).isYesterday(today)) {
        iconColor = Colors.red;
        textColor = Colors.red;
        labelText = "Yesterday";
        // Hôm qua
      } else if (DateOnlyCompare(todo.dueDate!).isBeforeYesterday()) {
        // Hôm nay
        iconColor = Colors.red;
        textColor = Colors.red;
        labelText = DateFormat('dd MMM').format(todo.dueDate!);
      } else if (DateOnlyCompare(todo.dueDate!).isSameDate(today)) {
        // Hôm nay
        iconColor = Colors.green;
        textColor = Colors.green;
        labelText = "Today";
      } else if (DateOnlyCompare(todo.dueDate!).isTomorrow(today)) {
        // Ngày mai
        iconColor = Colors.orange;
        textColor = Colors.orange;
        labelText = "Tomorrow";
      } else if (todo.dueDate!.isAfter(tomorrow)) {
        // Ngày mai
        iconColor = Colors.purple;
        textColor = Colors.purple;
        labelText = DateFormat('dd MMM').format(todo.dueDate!);
      }
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            useRootNavigator: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return TodoSchedulePicker(
                dueDate: todo.dueDate,
                setDueDate: (date) {
                  final newTodo = todo;
                  newTodo.dueDate = date;
                  Provider.of<TodoProvider>(context, listen: false)
                      .updateTodo(todo.id!, newTodo);
                },
              );
            });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.calendar_today_outlined,
              size: 26,
              color: iconColor,
              weight: 8,
            ),
          ),
          itemGap(),
          // const SizedBox(
          //   width: 10,
          // ),
          Text(labelText,
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
    switch (todo.priority) {
      case 1:
        color = const Color(0xFFD1453A);
        break;
      case 2:
        color = const Color(0xFFEC8711);
        break;
      case 3:
        color = Colors.blue;
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
        showPriorityActionSheet(context, todo.priority);
      },
      child: Row(
        children: [
          Icon(
            Icons.flag,
            size: 26,
            color: color,
          ),
          // const SizedBox(width: 10),
          itemGap(),
          Text('Priority ${todo.priority}',
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
                final newTodo = todo;
                newTodo.priority = 1;
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(todo.id!, newTodo);

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
                final newTodo = todo;
                newTodo.priority = 2;
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(todo.id!, newTodo);
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
                final newTodo = todo;
                newTodo.priority = 3;
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(todo.id!, newTodo);
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
                final newTodo = todo;
                newTodo.priority = 4;
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(todo.id!, newTodo);
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
                title: Text("Sub-tasks ${todo.subtasks!.length >> 0}",
                    style: const TextStyle(
                      fontFamily: ".SF Pro Text",
                      fontSize: 16,
                    )),
                collapsedBackgroundColor:
                    Colors.transparent, // Đặt màu nền khi thu gọn là trong suốt
                tilePadding: EdgeInsets.zero,
                // trailing: const SizedBox.shrink(),
                children: todo.subtasks!.isNotEmpty
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
    return todo.subtasks!.map((e) {
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
          title: Text("Comments ${todo.subtasks!.length >> 0}",
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
              title: Text("Comment 1"),
            ),
            ListTile(
              title: Text("Comment 2"),
            ),
            ListTile(
              title: Text("Comment 3"),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isYesterday(DateTime other) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool isBeforeYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isBefore(yesterday);
  }

  bool isTomorrow(DateTime other) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }
}
