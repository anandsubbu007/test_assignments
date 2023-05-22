import 'package:flutter/material.dart';

class ActionButtom extends StatefulWidget {
  const ActionButtom({super.key});

  @override
  State<ActionButtom> createState() => _ActionButtomState();
}

class _ActionButtomState extends State<ActionButtom> {
  bool isStrated = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isStrated ? Colors.red : Colors.blue,
            alignment: Alignment.center,
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        onPressed: () => setState(() => isStrated = !isStrated),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            isStrated ? "STOP" : "START",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
