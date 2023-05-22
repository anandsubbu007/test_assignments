import 'package:flutter/material.dart';
import 'package:lionsbot_test/component/custom_switch.dart';

class TopSwitches extends StatefulWidget {
  const TopSwitches({super.key});

  @override
  State<TopSwitches> createState() => _TopSwitchesState();
}

class _TopSwitchesState extends State<TopSwitches> {
  bool isWaterEnabled = false;
  bool isBrushEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.white),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CutomSwitch(
                  label: "WATER",
                  value: isWaterEnabled,
                  icon: Icons.water_drop_outlined,
                  onChanged: (value) {
                    setState(() {
                      isWaterEnabled = value;
                    });
                  },
                ),
              ),
              const VerticalDivider(width: 1, color: Colors.white),
              Expanded(
                child: CutomSwitch(
                  label: "BRUSH",
                  value: isBrushEnabled,
                  icon: Icons.wifi_tethering,
                  onChanged: (value) {
                    setState(() {
                      isBrushEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white),
      ],
    );
  }
}
