import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttons/custom_home_button.dart';
import '../models/student_details_model.dart';
import 'view_challan_detail_screen.dart';

class FeesChallanScreen extends StatefulWidget {
  final UserDetailsModel userDetailsData;

  const FeesChallanScreen({super.key, required this.userDetailsData});

  @override
  State<FeesChallanScreen> createState() => _FeesChallanScreenState();
}

class _FeesChallanScreenState extends State<FeesChallanScreen> {
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
            title: const Text("Fee Challan"),
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
                          widget.userDetailsData.student?.name ?? "_ _ _",
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
                          widget.userDetailsData.student?.rollNo?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          widget.userDetailsData.student?.campus?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Class ${widget.userDetailsData.student?.clas?.trim() ?? "_ _ _"}",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Section ${widget.userDetailsData.student?.section?.trim() ?? "_ _ _"}",
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
                          child: widget.userDetailsData.student?.clas != null
                              ? Image.network(widget.userDetailsData.student!.avatar!)
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.userDetailsData.student?.challans?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDetailsData.student?.challans?[index].month ?? "_ _ _",
                          style: const TextStyle(color: Color(0xff01398D), fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 330,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xffF9F328),
                          ),
                        ),
                        Text(
                          widget.userDetailsData.student?.challans?[index].amount ?? "_ _ _",
                          style: const TextStyle(
                            color: Color(0xff01398D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Status ${widget.userDetailsData.student?.challans?[index].paymentStatus ?? "_ _ _"}',
                          style: const TextStyle(
                            color: Color(0xff838181),
                          ),
                        ),
                        const SizedBox(
                          width: 330,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xffD9D9D9),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.center,
                          child: CustomHomeButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewChallansScreen(
                                    userDetailsData: widget.userDetailsData.student,
                                    report: widget.userDetailsData.student?.challans?[index].challanImage,
                                  ),
                                ),
                              );
                            },
                            showIcon: false,
                            text: 'View Challan',
                            backgroundColour: const Color(0xff01398D),
                            textColor: const Color(0xffFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
    BuildContext context,
    final String title,
    final String description,
    final String fieldTitle,
    final String hintText,
    final String bottomTextFieldText,
    final VoidCallback onUpdate,
  ) {
    return showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          title: title,
          description: description,
          fieldTitle: fieldTitle,
          hintText: hintText,
          onUpdate: onUpdate,
          bottomTextFieldText: bottomTextFieldText,
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

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final String description;
  final String fieldTitle;
  final String hintText;
  final String bottomTextFieldText;
  final VoidCallback onUpdate;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.fieldTitle,
    required this.hintText,
    required this.onUpdate,
    required this.bottomTextFieldText,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(
                0xff01398D,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                  widget.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff838181),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.fieldTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff01398D),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                Text(
                  widget.bottomTextFieldText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff838181),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 33,
                    width: 111,
                    decoration: BoxDecoration(
                      color: const Color(0xff01398D),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
