import 'package:fininfocom/plugin/bluetooth.dart';
import 'package:fininfocom/presentaion/profile_pg.dart';
import 'package:fininfocom/repo/repo.dart';
import 'package:flutter/material.dart';

class RandomImagePg extends StatefulWidget {
  const RandomImagePg({super.key});

  @override
  State<RandomImagePg> createState() => _RandomImagePgState();
}

class _RandomImagePgState extends State<RandomImagePg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("RandomImgPg"),
      appBar: AppBar(
        title: const Text("RandomImage Screen"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.bluetooth),
          onPressed: () async {
            final resp = await BlutoothPlugin.turnOn();
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(resp)));
            }
          },
        ),
        actions: [
          IconButton(
            key: const Key("to_profile_pg"),
            icon: const Icon(Icons.account_box_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePg()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ElevatedButton(
              key: const Key("refresh_key_dog"),
              onPressed: () {
                setState(() {});
              },
              child: const Text('Refresh'),
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
                future: AppRepo.fetchImage(),
                builder: (context, snapshot) {
                  return Center(
                    key: const Key("image"),
                    child: snapshot.hasData
                        ? Image.network(
                            snapshot.data!,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text("Error on Loading Image");
                            },
                          )
                        : snapshot.hasError
                            ? const Text("Error on Loading Image")
                            : const CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
