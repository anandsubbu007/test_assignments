import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/view/confirmation/components/dialogs.dart';
import 'package:flutter_app/view/home/home_pg.dart';
import 'package:flutter_app/view_model/provider/home_page_control.dart';

class ConfirmationPg extends StatefulWidget {
  const ConfirmationPg({super.key});

  @override
  State<ConfirmationPg> createState() => _ConfirmationPgState();
}

class _ConfirmationPgState extends State<ConfirmationPg> {
  void successDialog() {
    const SuccessDialog().callDialog(context);
  }

  void errorDialog(String message) {
    FailedDialog(message: message).callDialog(context);
  }

  @override
  void didChangeDependencies() {
    model = context.read<HomePageControl>();
    super.didChangeDependencies();
  }

  late HomePageControl model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Profile Summary",
            style: context.textTheme.titleLarge!
                .copyWith(color: AppColor.foreGround)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text.rich(
                        TextSpan(text: "Hi, ", children: [
                          TextSpan(
                              text: model.name,
                              style: context.textTheme.headlineLarge!.copyWith(
                                color: AppColor.focused,
                              ))
                        ]),
                        style: context.textTheme.headlineLarge!
                            .copyWith(color: AppColor.foreGround)),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text("You did it 🎉",
                        style: context.textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.foreGround)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please review your answers below and do change if any or confirm and continue.",
                              style: context.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              "My personal details 🙂",
                              style: context.textTheme.titleLarge!
                                  .copyWith(color: AppColor.focused),
                            ),
                            const SizedBox(height: 12),
                            Text.rich(
                              TextSpan(
                                  text: "", children: model.personalDetails),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              "How I keep busy 💻",
                              style: context.textTheme.titleLarge!
                                  .copyWith(color: AppColor.focused),
                            ),
                            const SizedBox(height: 12),
                            Text.rich(
                              TextSpan(
                                  text: "",
                                  children: model.keepsBusy,
                                  style: context.textTheme.labelMedium),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ActionButton(
              isConfirmation: true,
              onTap: () async {
                final key = GlobalKey();
                LoadingDialog(key: key).callDialog(context);
                void pop() {
                  if (key.currentContext?.mounted ?? false) {
                    Navigator.pop(key.currentContext!);
                  }
                }

                context.read<HomePageControl>().save(context).then((value) {
                  pop();
                  successDialog();
                }).onError((error, stackTrace) {
                  pop();
                  errorDialog(error.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
