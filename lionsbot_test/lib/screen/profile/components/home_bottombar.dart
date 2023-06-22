import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/screen/remote/remote_control_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget renderIconButton(lable, icon, onPressed) {
      return InkWell(
        onTap: onPressed,
        child: SizedBox(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Icon(icon, color: Colors.blue),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(lable,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontSize: 10, color: Colors.blue)),
              )
            ])),
      );
    }

    return BottomAppBar(
      //bottom navigation bar on scaffold
      color: Colors.white,
      shape: const CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, elevation: 15, shadowColor: Colors.black54,
      //notche margin between floating button and bottom appbar
      child: Row(
        //children inside bottom appbar
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: renderIconButton(
                  "Profile", CupertinoIcons.person_alt_circle, () {})),
          Expanded(
              flex: 2,
              child: renderIconButton(
                  "Messages", Icons.messenger_outline_outlined, () {})),
          MaterialButton(
            shape: const CircleBorder(
              side: BorderSide(
                  width: 4, color: Colors.blue, style: BorderStyle.solid),
            ),
            color: Colors.white,
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(11),
              child:
                  Icon(Icons.smart_toy_rounded, color: Colors.blue, size: 40),
            ),
          ),
          Expanded(
              flex: 2,
              child:
                  renderIconButton("Settings", CupertinoIcons.settings, () {})),
          Expanded(
            flex: 2,
            child: renderIconButton("Remote", Icons.stay_primary_portrait, () {
              Get.to(() => RemoteControllScreen());
            }),
          )
        ],
      ),
    );
  }
}
