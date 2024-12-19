import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/student_details_model.dart';
import '../services/student_apis.dart';

class ParentProfileScreen extends StatelessWidget {
  final UserDetailsModel userDetailsData;
  final Function() refresh;

  const ParentProfileScreen({super.key, required this.userDetailsData, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),
        Image.asset('assets/images/green_card_top.png'),
        Image.asset('assets/images/red_card_top.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: const Text("Parent Details"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            children: [
             Container(
                height: 180,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 9,
                      spreadRadius: 1,
                      offset: Offset(1, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userDetailsData.student?.name ?? "_ _ _",
                          style: const TextStyle(color: Color(0xff01398D), fontSize: 20),
                        ),
                        const SizedBox(
                          width: 100,
                          child: Divider(
                            color: Color(0xffF9F328),
                            thickness: 2,
                          ),
                        ),
                        Text(
                          userDetailsData.student?.rollNo?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          userDetailsData.student?.campus?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Class ${userDetailsData.student?.clas?.trim() ?? "_ _ _"}",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Section ${userDetailsData.student?.section?.trim() ?? "_ _ _"}",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 112,
                          height: 108,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffF9F328),
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: userDetailsData.student?.clas != null
                              ? Image.network(userDetailsData.student!.avatar!)
                              : const Icon(CupertinoIcons.person),
                        ),
                        Row(
                          children: [
                            _buildPageIndicator(),
                            const Text('On-Roll'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Parents Profile',
                        style: TextStyle(
                          color: Color(0xffD30000),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Color(0xffD30000),
                      )
                    ],
                  ),
                  const Divider(
                    color: Color(0xffD30000),
                    thickness: 2,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Parents/Guardian Information',
                    style: TextStyle(color: Color(0xff707070), fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          spreadRadius: 1,
                          offset: Offset(1, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userDetailsData.student?.parent?.name ?? "_ _ _",
                          style: const TextStyle(color: Color(0xff01398D)),
                        ),
                        const Text(
                          'Name',
                          style: TextStyle(
                            color: Color(0xff838181),
                          ),
                        ),
                        const SizedBox(
                          width: 330,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xffF9F328),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userDetailsData.student?.parent?.phone ?? "_ _ _",
                                    style: const TextStyle(
                                      color: Color(0xff01398D),
                                    ),
                                  ),
                                  const Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      color: Color(0xff838181),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showEditDialog(
                                  context,
                                  'Update Father\'s Phone Number',
                                  TextEditingController(text: userDetailsData.student?.parent?.phone ?? ""),
                                  'Our records indicate that your information registered with us is as follows',
                                  'Father Phone Number',
                                  'Enter New Father Phone Number',
                                  'Tap to Edit',
                                  (text) async {
                                    await StudentAPIs.updateParent(phone: text, id: userDetailsData.student!.parent!.parentId!);
                                    refresh();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Icon(
                                CupertinoIcons.square_pencil_fill,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 330,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xffD9D9D9),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userDetailsData.student?.parent?.email ?? "_ _ _",
                                    style: const TextStyle(color: Color(0xff01398D)),
                                  ),
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                      color: Color(0xff838181),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showEditDialog(
                                  context,
                                  'Update Father\'s Email Address',
                                  TextEditingController(text: userDetailsData.student?.parent?.email ?? ""),
                                  'Our records indicate that your information registered with us is as follows',
                                  'Father Email Address',
                                  'Enter new email',
                                  'Tap to edit',
                                  (text) async {
                                    await StudentAPIs.updateParent(email: text, id: userDetailsData.student!.parent!.parentId!);
                                    refresh();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Icon(
                                CupertinoIcons.square_pencil_fill,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  const Text(
                    'Correspondence Information',
                    style: TextStyle(color: Color(0xff707070), fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          spreadRadius: 1,
                          offset: Offset(1, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userDetailsData.student?.parent?.address ?? "_ _ _",
                                    style: const TextStyle(color: Color(0xff01398D)),
                                  ),
                                  const Text(
                                    'Home Address',
                                    style: TextStyle(
                                      color: Color(0xff838181),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showEditDialog(
                                  context,
                                  'Update Correspondence Home Address',
                                  TextEditingController(text: userDetailsData.student?.parent?.address ?? ""),
                                  'Our records indicate that your information registered with us is as follows',
                                  'Home Address',
                                  'Enter new address',
                                  'Tap To Edit',
                                  (text) async {
                                    await StudentAPIs.updateParent(address: text, id: userDetailsData.student!.parent!.parentId!);
                                    refresh();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Icon(
                                CupertinoIcons.square_pencil_fill,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> showEditDialog(
    BuildContext context,
    final String title,
    final TextEditingController controller,
    final String description,
    final String fieldTitle,
    final String hintText,
    final String bottomTextFieldText,
    final Function(String) onUpdate,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: const BoxDecoration(
                  color: Color(0xff01398D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff838181),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      fieldTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff01398D),
                      ),
                    ),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        hintText: hintText,
                        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Text(
                      bottomTextFieldText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff838181),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => onUpdate(controller.text.trim()),
                        child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xff01398D),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

//This is the indicator container
  Widget _buildPageIndicator() {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff9CFC00),
      ),
    );
  }
}

class HomeCategoriesContainer extends StatelessWidget {
  const HomeCategoriesContainer({
    super.key,
    required this.imageLogo,
    required this.title,
  });

  final String imageLogo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                spreadRadius: 4,
                offset: Offset(1, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            imageLogo,
            height: 77,
            width: 77,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9), // Background color
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 3),
            ),
          ], // Rounded edges
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xff707070), // Text color
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
