import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/student_details_model.dart';

enum AttendanceStatus { present, absent, onLeave, holiday, none }

class Attendance {
  final DateTime date;
  final AttendanceStatus status;

  Attendance(this.date, this.status);
}

class AttendanceScreen extends StatelessWidget {
  final UserDetailsModel userDetailsData;

  const AttendanceScreen({super.key, required this.userDetailsData});

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
            title: const Text("Attendance"),
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
              TableCalendar<Attendance>(
                daysOfWeekHeight: 40.0,
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(color: Color(0xff01398D), fontSize: 16, fontWeight: FontWeight.normal),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  decoration: BoxDecoration(color: Color(0xFF01398D)),
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Color(0xffD9D9D9)),
                ),
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                eventLoader: (day) {
                  return List.generate(
                    userDetailsData.student?.attendances?.length ?? 0,
                    (index) {
                      final date = DateFormat("yyyy-MM-dd").parse(userDetailsData.student!.attendances![index].date!);
                      AttendanceStatus status;
                      switch (userDetailsData.student!.attendances![index].status) {
                        case "present":
                          status = AttendanceStatus.present;
                          break;
                        case "absent":
                          status = AttendanceStatus.absent;
                          break;
                        case "onLeave":
                          status = AttendanceStatus.onLeave;
                          break;
                        case "holiday":
                          status = AttendanceStatus.holiday;
                          break;
                        default:
                          status = AttendanceStatus.none;
                          break;
                      }

                      return Attendance(date, status);
                    },
                    growable: false,
                  );
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) {
                      return const SizedBox();
                    }

                    List<Widget> markers = [];
                    for (final event in events) {
                      if (DateUtils.isSameDay(event.date, date)) {
                        AttendanceStatus status = event.status;
                        Color color;
                        switch (status) {
                          case AttendanceStatus.present:
                            color = const Color(0xff9CFC00);
                            break;
                          case AttendanceStatus.absent:
                            color = const Color(0xffD30000);
                            break;
                          case AttendanceStatus.onLeave:
                            color = const Color(0xffF9F328);
                            break;
                          case AttendanceStatus.holiday:
                            color = const Color(0xffD9D9D9);
                            break;
                          case AttendanceStatus.none:
                            color = const Color(0x00000000);
                            break;
                        }
                        if (event.status != AttendanceStatus.none) {
                          markers.add(
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.symmetric(vertical: 1.0),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: color,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: markers,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 3,
                  color: Color(0xffF9F328),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      _buildPageIndicator(const Color(0xff9CFC00)),
                      const Text('Present'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildPageIndicator(
                        const Color(0xffD30000),
                      ),
                      const Text('Absent'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildPageIndicator(
                        const Color(0xffF9F328),
                      ),
                      const Text('On Leave'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildPageIndicator(
                        const Color(0xffD9D9D9),
                      ),
                      const Text('Holiday'),
                    ],
                  ),
                ],
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
