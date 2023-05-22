import 'package:get/get.dart';
import 'package:lionsbot_test/db/models/points.dart';

class PointsController extends GetxController {
  final List<PointsModel> _datas = [
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
    PointsModel(
        title: 'Sucessful Operation',
        timeOperation: '8m ago',
        description:
            "+10 Point Sucessfully Operated Robots without any issues"),
  ];

  List<PointsModel> getPointsOfuser() {
    return _datas;
  }
}
