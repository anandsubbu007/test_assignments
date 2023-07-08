import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/firebase_request.dart';

class FirebaseItem extends StatelessWidget {
  final FirebaseRequest item;
  final GestureTapCallback? onTap;

  const FirebaseItem({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.all(4),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    if (item.attachment != null && item.attachment!.isNotEmpty)
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: item.attachment!,
                            placeholder: (context, url) =>
                                const Icon(Icons.account_circle_outlined),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.account_circle_outlined),
                            width: 50.0,
                          )),
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title!),
                        Text(item.description!),
                        Text(item.date!)
                      ],
                    )
                  ])
                ],
              )),
        ));
  }
}
