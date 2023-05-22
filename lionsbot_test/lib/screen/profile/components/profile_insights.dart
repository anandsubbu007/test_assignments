// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/controller/auth_controller.dart';
import 'package:lionsbot_test/controller/points_controller.dart';
import 'package:lionsbot_test/db/models/points.dart';

class ProfileInsights extends StatefulWidget {
  const ProfileInsights({super.key});

  @override
  State<ProfileInsights> createState() => _ProfileInsightsState();
}

class _ProfileInsightsState extends State<ProfileInsights>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  AuthController authController = Get.put(AuthController());
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

  Widget tab2() {
    return const Center(
      child: Text(
        'No Data Found',
        style: TextStyle(
            fontSize: 15, color: Colors.black38, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xfffdcdcdc),
                borderRadius: BorderRadius.circular(25.0)),
            child: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.all(2),
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(0xFFFAF8F9)),
              labelColor: const Color(0xfff0096ff),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                // first tab [you can add an icon using the icon property]
                Tab(text: 'Points'),
                // second tab [you can add an icon using the icon property]
                Tab(text: 'Badges'),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [const PointTabDetails(), tab2()]))
        ],
      ),
    );
  }
}

class PointTabDetails extends StatelessWidget {
  const PointTabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Widget listItem(PointsModel data) {
      final textTheme = Theme.of(context).textTheme;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xfffdcdcdc),
                    borderRadius: BorderRadius.circular(5.0)),
                child: const SizedBox()),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            data.title,
                            maxLines: 1,
                            style: textTheme.titleSmall?.copyWith(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(data.timeOperation,
                          textAlign: TextAlign.right,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: const Color.fromARGB(173, 120, 106, 106),
                          ))
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(data.description,
                      style:
                          textTheme.bodySmall?.copyWith(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    PointsController pointsController = Get.put(PointsController());
    final data = pointsController.getPointsOfuser();
    return ListView.separated(
        separatorBuilder: (c, i) => const Divider(height: 1),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: data.length,
        itemBuilder: (ctx, i) {
          return listItem(data[i]);
        });
  }
}
