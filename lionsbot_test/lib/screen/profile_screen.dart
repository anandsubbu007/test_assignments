// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/screen/remote_control_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../controller/auth_controller.dart';

// ignore: use_key_in_widget_constructors
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final _bottomBarController = BottomBarWithSheetController(initialIndex: -1);
  AuthController authController = Get.put(AuthController());

  final double coverHeight = 225;
  final double profileHeight = 144;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: TextButton(
              onPressed: () {},
              child: Text("Home",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
                child: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            actions: [
              TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: Text("Logout",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            //bottom navigation bar on scaffold
            color: Colors.white,
            shape: CircularNotchedRectangle(), //shape of notch
            notchMargin:
                5, //notche margin between floating button and bottom appbar
            child: Row(
              //children inside bottom appbar
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                renderIconButton("Profile", Icons.person, () {}),
                renderIconButton(
                    "Messages", Icons.messenger_outline_outlined, () {}),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: MaterialButton(
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 3,
                        color: Colors.blue,
                        style: BorderStyle.solid,
                      ),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      // Get.to(() => RemoteControllScreen());
                    },
                    child: const Icon(
                      Icons.gamepad,
                      color: Colors.blue,
                    ),
                  ),
                ),
                renderIconButton("Settings", Icons.settings, () {}),
                renderIconButton("Remote", Icons.stay_primary_portrait, () {
                  Get.to(() => RemoteControllScreen());
                })
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildStack(),
              buildContent(),
              buildTab(),
              buildView()
            ],
          )),
    );
  }

  Widget renderIconButton(lable, icon, onPressed) {
    return TextButton(
      // ignore: sort_child_properties_last
      child: SizedBox(
          width: 65,
          height: 50,
          child: Column(children: [
            Icon(
              icon,
              color: Colors.blue,
            ),
            Text(
              lable,
              style: TextStyle(fontSize: 12),
            )
          ])),
      onPressed: onPressed,
    );
  }

  Widget buildContent() => Column(
        children: [
          SizedBox(
            height: 8,
          ),
          GradientText(
            authController.authService.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            colors: const [
              Colors.blue,
              Colors.purple,
              Colors.orange,
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Cleaning Hours : 18',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget buildStack() {
    final double top = coverHeight - profileHeight / 1.5;
    final double bottom = profileHeight / 2.5;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverBackground()),
          Positioned(top: top, child: buildProfileImage()),
        ]);
  }

  Widget buildCoverBackground() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // Colors.orange,
              // Colors.white,
              Colors.pinkAccent,
              Colors.blue,
            ],
          ),
        ),
        width: double.infinity,
        height: coverHeight,
      );

  Widget buildProfileImage() => CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(authController.authService.profile),
        radius: profileHeight / 2,
      );

  Widget buildTab() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xfffdcdcdc),
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              padding: EdgeInsets.all(2),
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Color(0xFFFAF8F9),
              ),
              labelColor: Color(0xfff0096ff),
              unselectedLabelColor: Colors.grey,

              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(text: 'Points'),

                // second tab [you can add an icon using the icon property]
                Tab(text: 'Badges'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(title, timeOperation, description) {
    return Row(
      children: [
        Column(
          children: [
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xfffdcdcdc),
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0),
                ))
          ],
        ),
        Padding(padding: EdgeInsets.all(10)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(timeOperation,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color.fromARGB(173, 120, 106, 106),
                          fontSize: 15,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(3)),
            Column(children: [
              Container(
                width: MediaQuery.of(context).size.width - 150,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Text(description),
              )
            ]),
          ],
        ),
      ],
    );
  }

  Widget buildView() {
    // final double top = coverHeight - profileHeight / 1.5;
    final double height = (MediaQuery.of(context).size.height / 2.7);
    return SizedBox(
        height: height,
        // margin: EdgeInsets.only(bottom: bottom),
        child: TabBarView(controller: _tabController, children: [
          // first tab bar view widget
          ListView(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            children: <Widget>[
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
              listItem("Sucessful Operation", "8m ago",
                  "+10 Point Sucessfully Operated Robots without any issues "),
              Divider(
                color: Colors.black,
              ),
            ],
          ),

          // second tab bar view widget
          Center(
            child: Text(
              'Points',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]));
  }
}
