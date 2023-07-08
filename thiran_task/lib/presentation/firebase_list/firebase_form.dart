// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:thiran_task/presentation/utilities/app_function.dart';
import '../utilities/validation_utils.dart';
import '../widgets/filled_button.dart';
import '../widgets/app_textfield.dart';
import '../../application/bloc/firebase/firebase_bloc.dart';
import '../../domain/model/firebase_request.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  @override
  void initState() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    context.read<FirebaseBloc>().add(OnFormLoadEvent());
    askPermissionForCameraStorage();
    super.initState();
  }

  Future askPermissionForCameraStorage() async {
    await AppFunctions.requestPermission(Permission.storage);
    await AppFunctions.requestPermission(Permission.camera);
  }

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;
  final TextEditingController _ditleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rise Firebase Ticket",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<FirebaseBloc, FirebaseState>(
        builder: (context, state) {
          if (state is NewFormFirebase) {
            return formBody();
          } else if (state is FirebaseError) {
            return errorWidget(state);
          } else if (state is FirebaseSaved) {
            return firebaseSaved();
          } else if (state is FirebaseLoading) {
            return AppFunctions.loadingWidget();
          } else {
            return AppFunctions.loadingWidget();
          }
        },
      ),
    );
  }

  Widget formBody() {
    return SingleChildScrollView(
        child: Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  autovalidateMode: mode,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                          controller: _ditleController,
                          prefixIcon: const Icon(Icons.description_outlined),
                          hint: "Problem Title",
                          validator: (arg) {
                            return ValidationUtils.validate(
                                arg, "Problem Title", context);
                          }),
                      AppTextField(
                        controller: _descController,
                        prefixIcon: const Icon(Icons.description_outlined),
                        hint: "Description",
                        validator: (arg) {
                          return ValidationUtils.validate(
                              arg, "Description", context);
                        },
                      ),
                      AppTextField(
                        controller: _locationController,
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        hint: "Location",
                        validator: (arg) {
                          return ValidationUtils.validate(
                              arg, "Location", context);
                        },
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: _dateController,
                        prefixIcon: const Icon(Icons.date_range),
                        hint: "Date",
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      (image != null)
                          ? SizedBox(
                              height: 130,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Center(
                                      child: Image.file(File(image!.path),
                                          height: 100)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          image = null;
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ))
                          : Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.attach_file),
                                label: const Text("Attachment"),
                                onPressed: () async {
                                  image = (await ImagePicker().pickImage(
                                      source: ImageSource.gallery)) as XFile;
                                  setState(() {});
                                },
                              ),
                            ),
                      const SizedBox(height: 30),
                      FilledAppButton(
                        label: "Submit",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<FirebaseBloc>().add(PageOnLoadEvent());
                            context.read<FirebaseBloc>().add(
                                OnFirebaseSaveEvent(
                                    firebase: FirebaseRequest(
                                        title: _ditleController.text,
                                        description: _descController.text,
                                        date: DateFormat("dd-MM-yyyy HH:mm:ss")
                                            .format(DateTime.now()),
                                        attachment:
                                            image != null ? image!.path : null,
                                        location: _locationController.text),
                                    userId: AppPreferences.instance.userUid!));
                          } else {
                            setState(() {
                              mode = AutovalidateMode.always;
                            });
                          }
                        },
                      ),
                    ],
                  )),
            )));
  }

  errorWidget(FirebaseError state) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.error.toString()),
        ]);
  }

  firebaseSaved() {
    _clearFields();
    return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  const Icon(
                    Icons.done_all_rounded,
                    color: Colors.green,
                    size: 40,
                  ),
                  const Text("Report sent successfully!"),
                  const SizedBox(height: 50),
                  FilledAppButton(
                    label: "New Report",
                    onPressed: () {
                      context.read<FirebaseBloc>().add(OnFormLoadEvent());
                    },
                  ),
                ])));
  }

  _clearFields() {
    _locationController.clear();
    _descController.clear();
    _ditleController.clear();
    image = null;
  }
}
