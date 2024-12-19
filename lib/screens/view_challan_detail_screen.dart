import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/student_details_model.dart';

class ViewChallansScreen extends StatelessWidget {
  final Student? userDetailsData;
  final String? report;

  const ViewChallansScreen({super.key, required this.userDetailsData, required this.report});

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
            title: const Text("Challan Details"),
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
                          userDetailsData?.name ?? "_ _ _",
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
                          userDetailsData?.rollNo?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          userDetailsData?.campus?.trim() ?? "_ _ _",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Class ${userDetailsData?.clas?.trim() ?? "_ _ _"}",
                          style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                        ),
                        Text(
                          "Section ${userDetailsData?.section?.trim() ?? "_ _ _"}",
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
                          child: userDetailsData?.clas != null
                              ? Image.network(userDetailsData!.avatar!)
                              : const Icon(CupertinoIcons.person),
                        ),
                        Row(
                          children: [
                            _buildPageIndicator(const Color(0xff9CFC00)),
                            const Text('On-Roll'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Grade Report',
                  style: TextStyle(
                    color: Color(0xff01398D),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (report == null)
                const SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_rounded),
                      SizedBox(height: 10),
                      Text("No Report Found"),
                    ],
                  ),
                )
              else
                Image.network(
                  report!,
                  width: double.infinity,
                )
            ],
          ),
        ),
      ],
    );
  }

  // This is the indicator container
  Widget _buildPageIndicator(Color color) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class ViewReportButton extends StatelessWidget {
  const ViewReportButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue, // Background color
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(1, 3),
            ),
          ], // Rounded edges
        ),
        child: const Center(
          child: Text(
            "View Report",
            style: TextStyle(
              color: Colors.white, // Text color
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
