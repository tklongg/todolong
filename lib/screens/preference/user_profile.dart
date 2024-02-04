import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _nameController = TextEditingController();
  String currName = '';
  bool isPhotoUpload = false;
  String photoURI = '';
  @override
  Widget build(BuildContext context) {
    void onNameChanged (String value) {
      setState(() {
        currName = value;
      });
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 10.0,
          centerTitle: true,
          leading: Container(
            // padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            // decoration: BoxDecoration(
            //   color: Colors.green,
            // ),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFFD74638),
                        size: 16,
                      ),
                      Text('Back',
                          style: TextStyle(
                            color: Color(0xFFD74638),
                          ))
                    ],
                  ),
                )),
          )),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Thank you for your answers ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "GGX88HV",
                ),
              ),
              TextSpan(
                text: '🌈',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'EmojiOne',
                ),
              ),
            ])),
            const SizedBox(height: 8.0),
            const Text(
              'Congratulations on taking the first step towards feeling more organized',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "GGX88Reg_Light",
                  color: Color(0xFF707070)),
            ),
            const SizedBox(height: 8.0),
            buildInfoInputForm(),
            const SizedBox(height: 18.0),
            buildLaunchButton()
          ],
        ),
      ),
    );
  }

  Widget buildInfoInputForm() {
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0XFFd2d2d2), // Màu của border
          width: 1.5, // Độ dày của border
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            alignment: Alignment.center, // Căng giữa theo chiều ngang
            child: const Text(
              "Your Profile",
              style: TextStyle(
                fontFamily: "GGX88Reg_Light",
                fontSize: 15, // Đặt kích thước phù hợp
                fontWeight: FontWeight.bold, // Đặt độ đậm
              ),
            ),
          ),
          buildPhotoSection(),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'YOUR NAME',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    fontFamily: "GGX88Reg_Light",
                    color: Color(0xFF6e6e6e)),
              ),
              TextField(
                // controller: _nameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: "GGX88Reg_Light",
                  color: Color(0xFF6e6e6e),
                ),
                onChanged: (value) {
                  print(
                      'First text field: $value (${value.characters.length})');
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Color(0xFFf4f4f4),
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontFamily: "GGX88Reg_Light",
                    color: Color(0xFFc6c6c6),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget buildPhotoSection() {
    return Column(
      //fill here
      children: [
        const SizedBox(height: 16.0),
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD74638), // Màu của hình tròn khi chưa có ảnh
          ),
          child: Center(
            child: isPhotoUpload
                ? // Nếu đã upload ảnh, hiển thị ảnh
                const CircleAvatar(
                    radius: 50,
                  )
                : Text(
                    currName.isNotEmpty
                        ? currName.substring(0, 2).toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            // Thêm logic tải ảnh
            setState(() {
              isPhotoUpload = true;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf4f4f4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(8),
          ),
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, color: Color(0xFF6e6e6e)),
                // const Spacer(),
                SizedBox(width: 8.0),
                Text(
                  'Upload your photo',
                  style: TextStyle(
                      fontFamily: 'GGX88Reg_Light',
                      fontSize: 13,
                      color: Color(0xFF6e6e6e)),
                )
              ]),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildLaunchButton() {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: const Color(0xFFD74638),
            minimumSize: const Size(double.infinity, 60),
          ),
          onPressed: () {},
          child: const Text(
            'Launch todolong',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "GGX88Reg",
              color: Colors.white,
            ),
          ),
        ));
  }
}
