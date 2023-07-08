import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thiran_task/domain/model/firebase_request.dart';
import 'package:thiran_task/presentation/firebase_list/widget/detail_tile.dart';

class FirebaseDetailScreen extends StatelessWidget {
  final FirebaseRequest item;

  const FirebaseDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    alignment: Alignment.centerRight,
                    children: [
                     
                      Positioned(
                          child: IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                Navigator.pop(context);
                              }))
                    ],
                  )),
              if (item.attachment != null)
                Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            imageUrl: item.attachment!,
                            placeholder: (context, url) =>
                                const Icon(Icons.account_circle),
                            width: 100))),
              const SizedBox(height: 30),
              RepoDetailItem(
                  fieldName: "Problem Title", fieldValue: item.title!),
              RepoDetailItem(fieldName: "Date Time:", fieldValue: item.date!),
              RepoDetailItem(fieldName: "Location", fieldValue: item.location!),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description :"),
                      Text("   ${item.description!}")
                    ],
                  ))
            ],
          ),
        ));
  }

}
