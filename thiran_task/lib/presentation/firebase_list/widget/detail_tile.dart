import 'package:flutter/material.dart';

class RepoDetailItem extends StatelessWidget {
  final String fieldName, fieldValue;

  const RepoDetailItem(
      {Key? key, required this.fieldName, required this.fieldValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.02,
                      child: Text(
                        fieldName,
                        maxLines: null,
                      ))),
              // const SizedBox(width: 5),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2.02,
                  child: Text(
                    fieldValue,
                    maxLines: null,
                  ))
            ])),
        Container(
          width: double.infinity,
          color: Colors.grey[400],
          height: 1
        )
      ],
    );
  }
}
