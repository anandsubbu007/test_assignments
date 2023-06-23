import 'package:fininfocom/repo/repo.dart';
import 'package:flutter/material.dart';

import '../model/profile_res.dart';

class ProfilePg extends StatefulWidget {
  const ProfilePg({super.key});

  @override
  State<ProfilePg> createState() => _ProfilePgState();
}

class _ProfilePgState extends State<ProfilePg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("Refresh")),
              ),
            ),
            Expanded(
              child: FutureBuilder<ProfileRes>(
                  future: AppRepo.getProfileData(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? profileData(snapshot.data!)
                        : const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileData(ProfileRes profile) {
    return profile.results?.firstOrNull == null
        ? const Text("No Data Found")
        : ProfileDetails(data: profile.results!.first);
    // : ListView.builder(
    //     itemCount: profile.results?.length ?? 0,
    //     shrinkWrap: true,
    //     primary: false,
    //     itemBuilder: ((context, index) {
    //       final data = profile.results?[index];
    //       return data == null
    //           ? const Text("-")
    //           : ProfileDetails(data: data);
    //     }));
  }
}

class ProfileDetails extends StatelessWidget {
  final Results data;
  const ProfileDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    TableRow getTableRow(String title, String value) {
      return TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey[300],
            child: Image.network(
              data.picture?.large.toString() ?? "",
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('${data.name?.first ?? ''} ${data.name?.last ?? ''}',
            style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
              child: Table(
            children: [
              getTableRow("Location", data.location?.street?.name ?? ""),
              getTableRow("Email", data.email ?? ""),
              getTableRow("DOB", data.dateOfBirth),
              getTableRow("Registered", '${data.since} Days Ago'),
              //
            ],
          )),
        )
      ],
    );
  }
}
// Stack(
//   clipBehavior: Clip.none,
//   children: [
//     Stack(
//       children: [
//         kHeight(50),
//         Padding(
//           padding:
//               const EdgeInsets.symmetric(vertical: 85, horizontal: 16),
//           child: Column(
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     kHeight(25),
//                     Row(
//                       children: [
//                         kWidth(10),
//                         const Text(
//                           "Name:",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         kWidth(10),
//                         Text(
//                           data.name?.first ?? "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     kHeight(8),
//                     Row(
//                       children: [
//                         kWidth(10),
//                         const Text(
//                           ":",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w800,
//                               fontSize: 16),
//                         ),
//                         kWidth(10),
//                         Text(data.location?.street?.name ?? "",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 16))
//                       ],
//                     ),
//                     kHeight(8),
//                     Row(
//                       children: [
//                         kWidth(6),
//                         const Text(
//                           "Email:",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w800,
//                               fontSize: 16),
//                         ),
//                         kWidth(2),
//                         Text(data.email ?? "",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 16))
//                       ],
//                     ),
//                     kHeight(8),
//                     Row(
//                       children: [
//                         kWidth(10),
//                         const Text(
//                           ":",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16),
//                         ),
//                         kWidth(10),
//                         Text(data.dob?.age.toString() ?? "",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 16))
//                       ],
//                     ),
//                     kHeight(8),
//                     Row(
//                       children: [
//                         kWidth(10),
//                         const Text(
//                           " :  ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16),
//                         ),
//                         Expanded(
//                           child: Text(data.registered?.date ?? "",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16)),
//                         )
//                       ],
//                     ),
//                     kHeight(8),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ],
// ),
