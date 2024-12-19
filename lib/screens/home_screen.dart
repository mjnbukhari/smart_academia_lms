import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/buttons/custom_home_button.dart';
import '../services/student_apis.dart';
import '../utlis/toast_messages.dart';
import 'attendance_screen.dart';
import 'fees_challan_screen.dart';
import 'grade_detail_screen.dart';
import 'parent_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),
        Image.asset('assets/images/green_card_top.png'),
        Image.asset('assets/images/red_card_top.png'),
        FutureBuilder(
          future: StudentAPIs.details(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              showError(context, snapshot.error.toString());
            }
            return Scaffold(
              backgroundColor: Colors.transparent,
              drawer: Drawer(
                backgroundColor: const Color(0xff01398D),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(
                          Icons.drag_handle_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Text(
                      "MENU",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/home.svg',
                          color: const Color(0xffF9F328),
                        ),
                        title: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (snapshot.data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceScreen(userDetailsData: snapshot.data!),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/attandance.svg',
                          color: const Color(0xffF9F328),
                        ),
                        title: const Text(
                          'Attendance',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (snapshot.data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeesChallanScreen(userDetailsData: snapshot.data!),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/challan_logo.png',
                          color: const Color(0xffF9F328),
                          scale: 2,
                        ),
                        title: const Text(
                          'Challans',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (snapshot.data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GradeHomeScreen(userDetailsData: snapshot.data!),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/grade.svg',
                          color: const Color(0xffF9F328),
                        ),
                        title: const Text(
                          'Grade',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (snapshot.data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParentProfileScreen(
                                userDetailsData: snapshot.data!,
                                refresh: () => setState(() {}),
                              ),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/parent_profile.svg',
                          color: const Color(0xffF9F328),
                        ),
                        title: const Text(
                          'Parent Profile',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/log_out.svg',
                          color: const Color(0xffF9F328),
                        ),
                        title: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    // Add more ListTile widgets for additional items
                  ],
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                title: const Text("Home"),
                centerTitle: true,
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
                          children: [
                            Text(
                              snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.name?.trim() ?? "_ _ _",
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
                              snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.rollNo?.trim() ?? "_ _ _",
                              style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                            ),
                            Text(
                              snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.campus?.trim() ?? "_ _ _",
                              style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                            ),
                            Text(
                              "Class ${snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.clas?.trim() ?? "_ _ _"}",
                              style: const TextStyle(color: Color(0xffD30000), fontSize: 14),
                            ),
                            Text(
                              "Section ${snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.section?.trim() ?? "_ _ _"}",
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
                              child: snapshot.connectionState == ConnectionState.waiting
                                  ? const Icon(CupertinoIcons.person)
                                  : snapshot.data?.student?.clas != null
                                      ? Image.network(snapshot.data!.student!.avatar!)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCategoriesContainer(
                        onTap: () {
                          if (snapshot.data != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendanceScreen(userDetailsData: snapshot.data!),
                              ),
                            );
                          }
                        },
                        imageLogo: 'assets/images/attendance_logo.png',
                        tittle: 'Attendance',
                      ),
                      HomeCategoriesContainer(
                        onTap: () {
                          if (snapshot.data != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GradeHomeScreen(userDetailsData: snapshot.data!),
                              ),
                            );
                          }
                        },
                        imageLogo: 'assets/images/grade_logo.png',
                        tittle: 'Grades',
                      ),
                      HomeCategoriesContainer(
                        onTap: () {
                          if (snapshot.data != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeesChallanScreen(userDetailsData: snapshot.data!),
                              ),
                            );
                          }
                        },
                        imageLogo: 'assets/images/challan_logo.png',
                        tittle: 'Challan',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 66,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Parents Profile',
                        style: TextStyle(
                          color: Color(0xffD30000),
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xffD30000),
                      )
                    ],
                  ),
                  const Divider(
                    color: Color(0xffD30000),
                    thickness: 2,
                  ),
                  const Text(
                    'Parents/Guardian Information',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.parent?.name ?? "_ _ _",
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
                        Text(
                          snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.parent?.phone ?? "_ _ _",
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
                        const SizedBox(
                          width: 330,
                          child: Divider(
                            thickness: 2,
                            color: Color(0xffD9D9D9),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.connectionState == ConnectionState.waiting ? '_ _ _' : snapshot.data?.student?.parent?.email ?? "_ _ _",
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
                        const SizedBox(height: 20),
                        Center(
                          child: CustomHomeButton(
                            text: 'View all',
                            showIcon: true,
                            onPressed: () {
                              if (snapshot.data != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ParentProfileScreen(
                                      userDetailsData: snapshot.data!,
                                      refresh: () => setState(() {}),
                                    ),
                                  ),
                                );
                              }
                            },
                            backgroundColour: const Color(0xffD9D9D9),
                            textColor: const Color(0xff707070),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

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
    required this.tittle,
    required this.onTap,
  });

  final String imageLogo;
  final String tittle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 9,
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
            tittle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
