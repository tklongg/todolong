import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoChangeTitleDesc extends StatefulWidget {
  final String title;
  final String description;
  final void Function(String, String)? save;
  // final VoidCallback? save;
  const TodoChangeTitleDesc(
      {super.key, required this.description, required this.title, this.save});

  @override
  State<TodoChangeTitleDesc> createState() => _TodoChangeTitleDescState();
}

class _TodoChangeTitleDescState extends State<TodoChangeTitleDesc> {
  late FocusNode _titleFocusNode;
  String titleState = '';
  String descState = '';
  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode(); // Khởi tạo FocusNode
    _titleFocusNode.requestFocus(); // Tự động focus vào ô title
    titleState = widget.title;
    descState = widget.description;
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
                CupertinoNavigationBar(
                  border: Border.all(color: Colors.transparent),
                  backgroundColor: Colors.white,
                  leading: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Color(0xFFD1453A))),
                  ),
                  middle: const Text('Edit Todo',
                      style: TextStyle(color: Colors.black)),
                  trailing: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.save!(titleState, descState);
                      // if (setDueDate != null) {
                      //   setDueDate!(selectedDate ?? DateTime.now());
                      // }
                    },
                    child: const Text('Save',
                        style: TextStyle(color: Color(0xFFD1453A))),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: TextFormField(
                    initialValue: widget.title,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    cursorColor: const Color(0xFFD74638),
                    focusNode: _titleFocusNode,
                    onChanged: (value) {
                      titleState = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Title',
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
                      child: TextFormField(
                        initialValue: widget.description ?? "",
                        cursorColor: const Color(0xFFD74638),
                        maxLines: null, // Cho phép nhiều dòng
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          descState = value;
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
                const SizedBox(height: 10),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border(
                //         top: BorderSide(color: Colors.grey[300]!),
                //         bottom: BorderSide(color: Colors.grey[300]!)),
                //   ),
                //   alignment: Alignment.bottomRight,
                //   padding: const EdgeInsets.fromLTRB(0, 12, 10, 12),
                //   child: GestureDetector(
                //     onTap: () {
                //       //handle add todo
                //       print(1);

                //       Navigator.of(context).pop();
                //     },
                //     child: Container(
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Color(0xFFD74638),
                //         ),
                //         height: 24,
                //         width: 24,
                //         // alignment: Alignment.center,
                //         child: const Icon(
                //           Icons.arrow_upward_sharp,
                //           size: 17,
                //           color: Colors.white,
                //         )),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
