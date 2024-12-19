import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/student_details_model.dart';
import 'grades_report_screen.dart';

class GradeHomeScreen extends StatefulWidget {
  final UserDetailsModel userDetailsData;

  const GradeHomeScreen({super.key, required this.userDetailsData});

  @override
  State<GradeHomeScreen> createState() => _GradeHomeScreenState();
}

class _GradeHomeScreenState extends State<GradeHomeScreen> {
  final monthly = <Grades>[];
  final mid = <Grades>[];
  final fnl = <Grades>[];

  @override
  void initState() {
    super.initState();

    for (final grade in widget.userDetailsData.student?.grades ?? <Grades>[]) {
      if (grade.type?.trim().toLowerCase() == "monthly") {
        monthly.add(grade);
      } else if (grade.type?.trim().toLowerCase() == "mid") {
        mid.add(grade);
      } else if (grade.type?.trim().toLowerCase() == "final") {
        fnl.add(grade);
      }
    }
  }

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
            title: const Text("Grades"),
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
              Column(
                children: [
                  const Text(
                    'Class 5-B (2023)',
                    style: TextStyle(
                      color: Color(0xff01398D),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          spreadRadius: 2,
                          offset: Offset(1, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ExpansionTile(
                              minTileHeight: 20,
                              shape: const Border(),
                              title: const Text(
                                'Monthly Assessments',
                                style: TextStyle(
                                  color: Color(0xff01398D),
                                ),
                              ),
                              children: List.generate(
                                monthly.length,
                                (index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            monthly[index].name ?? "_ _ _",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff01398D),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ViewReportButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GradesReportScreen(
                                                  userDetailsData: widget.userDetailsData.student,
                                                  report: monthly[index].photoOfGrade,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ExpansionTile(
                              minTileHeight: 20,
                              shape: const Border(),
                              title: const Text(
                                'Mid Term',
                                style: TextStyle(
                                  color: Color(0xff01398D),
                                ),
                              ),
                              children: List.generate(
                                mid.length,
                                (index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            mid[index].name ?? "_ _ _",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff01398D),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ViewReportButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GradesReportScreen(
                                                    userDetailsData: widget.userDetailsData.student, report: monthly[index].photoOfGrade),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ExpansionTile(
                              minTileHeight: 20,
                              shape: const Border(),
                              title: const Text(
                                'Final Term',
                                style: TextStyle(
                                  color: Color(0xff01398D),
                                ),
                              ),
                              children: List.generate(
                                fnl.length,
                                (index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            fnl[index].name ?? "_ _ _",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff01398D),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ViewReportButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GradesReportScreen(
                                                    userDetailsData: widget.userDetailsData.student, report: monthly[index].photoOfGrade),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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
